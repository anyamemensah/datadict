.is_col_empty <- function(data) {
  all_na <- colSums(is.na(data)) == nrow(data)
  names(which(all_na))
}


.select_cols <- function(data, cols_to_select = NULL) {
  all_cols <- colnames(data)
  
  is_empty_col <- .is_col_empty(data)
  
  if (is.null(cols_to_select)) {
    selected <- setdiff(all_cols, is_empty_col)
    empty_cols <- intersect(all_cols, is_empty_col)
  } else {
    cols <- trimws(cols_to_select)
    selected <- setdiff(all_cols[all_cols %in% cols], is_empty_col)
    empty_cols <- intersect(all_cols[all_cols %in% cols], is_empty_col)
  }
  
  if (length(selected) == 0) selected <- NULL
  
  list(
    selected = selected,         
    all_missing = empty_cols     
  )
}


.process_var_label <- function(var_label,
                               default_label_width,
                               default_label) {
  if (is.null(var_label)) {
    var_label <- default_label
  }
  
  if (nchar(var_label) > default_label_width) {
    var_label <- substr(var_label, start = 1, stop = default_label_width)
  }
  
  var_label
}


.join_text <- function(text, sep = ", ", before_last = "and ") {
  if (is.null(text)) {
    return(NULL)
  }
  
  text <- text[!(text %in% c("", NA))]
  text_n <- length(text)
  
  if (text_n == 0) {
    return(NULL)
  }
  
  if (text_n == 1) {
    return(text)
  }
  
  if (text_n == 2)
    return(paste(text, collapse = paste0(" ", before_last)))
  
  paste0(paste(text[1:(text_n - 1)], collapse = sep), sep, before_last, text[text_n])
}


.count_occurences <- function(x, values) {
  freq_tab <- table(as.character(x))
  ix <- match(as.character(values), names(freq_tab), nomatch = NA_integer_)
  n_size <- ifelse(ix == 0, 0L, as.integer(freq_tab[ix]))
  n_size[is.na(n_size)] <- 0 
  n_size
}


.get_var_type <- function(x) {
  class_x <- class(x)
  
  if ("haven_labelled" %in% class_x) {
    "labelled"
  } else if ("factor" %in% class_x) {
    "factor"
  } else if ("POSIXt" %in% class_x || "POSIXct" %in% class_x ||
             "POSIXlt" %in% class_x || "POSIXt" %in% class_x ||
             "Date" %in% class_x  || "difftime" %in% class_x) {
    "datetime"
  } else if ("numeric" %in% class_x || "integer" %in% class_x ||
             "double" %in% class_x) {
    "numeric"
  } else if ("logical" %in% class_x) {
    "logical"
  } else {
    "character"
  }
}
