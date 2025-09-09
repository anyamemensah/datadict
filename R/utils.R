.get_attribute <- function(x, attribute = c("label", "labels")) {
  
  attribute <- match.arg(attribute)
  
  return(attr(x, which = attribute, exact = TRUE))
  
}


.get_val_labels <- function(x, attribute = "labels") {
  
  .get_attribute(x = x, attribute = attribute)
  
}


.get_q_Label <- function(x, attribute = "label", label_width = 100) {
  
  qLabel <- .get_attribute(x = x, attribute = attribute)
  
  if (!is.null(qLabel)) {
    # only retain first n number of characters of question label
    if (nchar(qLabel) > label_width) {
      qLabel <- substr(qLabel, start = 1, stop = label_width)
    }
    
    return(qLabel)
    
  } else {
    return("NO QUESTION LABEL")
    
  }
}


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


.return_empty_cols <- function(data) {
  is_all_na <- colSums(is.na(data)) == nrow(data)
  
  is_all_empty <- sapply(data, \(col) {
    sum(as.character(col) == "", na.rm = TRUE) == length(col)
  })
  
  which(is_all_na | is_all_empty)
  
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
