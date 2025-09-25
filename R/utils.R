.select_cols <- function(data, cols_to_select) {
  
  all_cols <- colnames(data)
  
  if (!is.null(cols_to_select)) {
    cols <- grep(paste0("^", trimws(cols_to_select), "$", collapse = "|"),
                 colnames(data),
                 value = TRUE)
    all_cols <- all_cols[all_cols %in% cols]
  }
  
  if (length(all_cols) == 0L) {
    return(NULL)
    
  } else {
    return(all_cols)
  }
  
}


.return_empty_cols <- function(data, empty_values = c("", NA)) {
  
  is_empty_col <- vapply(data, function(x) all(x %in% empty_values), logical(1))
  
  which(is_empty_col)
}


.join_text <- function(text,
                       sep = ", ",
                       before_last = "and ") {
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


.get_var_type <- function(x) {
  
  x <- class(x)
  
  if ("haven_labelled" %in% x) {
    "labelled"
  } else if ("factor" %in% x) {
    "factor"
  } else if ("POSIXt" %in% x | "POSIXct" %in% x |
             "POSIXlt" %in% x | "POSIXt" %in% x |
             "Date" %in% x  | "difftime" %in% x
  ) {
    "datetime"
  } else if ("numeric" %in% x | "integer" %in% x |
             "double" %in% x) {
    "numeric"
  } else if ("logical" %in% x) {
    "logical"
  } else {
    "character"
  }
  
}
