#' Generate a data dictionary from a data frame.
#'
#' @description `generate_dict()` generates a data dictionary from a data frame. The data
#' dictionary includes contains column indices (which help identify groups of variables with 
#' multiple values or labels), variable names, question labels (if available), variable values, 
#' value labels, and the frequencies of both non-missing and missing values or labels. NOTE:
#' "tagged" missing values will appear with `na_` prefix under the `value_labels` column.
#'
#' @param data A data frame.
#' @param cols A character string, or vector of character strings, of the variable names
#' in `data` to include in the data_dictionary. Default is `NULL` and all variables will be 
#' included in the dictionary.
#' @param max_display_values An integer that determines how many unique values or labels in a
#' numeric vector are displayed before summarizing them as a range. This setting is especially
#' useful when numeric variables have only a few distinct values, as it allows all values or
#' labels to be shown instead of condensing them into a range.
#' @param q_label_width An integer specifying the maximum number of characters
#' displayed for a question (or variable) label. Default is `100` and the first 100
#' characters of the label will be shown.
#'
#' @returns A tibble summarizing the contents of the data frame is displayed. The resulting
#' columns include column index (column_index; location of the variable within the dataset),
#' variable names (variable_name) as they appear in the data frame, question labels 
#' (question_label), distinct variable values (variable_values), corresponding value labels 
#' (value_labels), frequencies (n_size; the number of times each unique value/label appears), 
#' and a flag (is_range) indicating whether the data for each variable is shown as a range.
#'
#' @examples
#' generate_dict(data = nlsy)
#'
#' # example shortening question labels to 25 characters
#' generate_dict(data = gss, q_label_width = 25)
#'
#' # example selecting a subset of variables from a data frame
#' generate_dict(data = gss, cols = c("year","age","sexnow1","hispanic","race","marital"))
#'
#' @export
generate_dict <- function(data,
                          cols = NULL,
                          max_display_values = 10,
                          q_label_width = 100) {
  withr::with_options(list(scipen = 999), {
    
    # Check 'data' is a data frame with at least one row/column
    if (!is.data.frame(data)) {
      stop("The 'data' argument is not a data frame.")
    }
    
    if (prod(dim(data)) == 0) {
      stop("The 'data' argument is empty.")
    }
    
    # Find 'cols' to include in the data dictionary; return NULL if none are found
    cols_to_select <- .select_cols(data = data, cols_to_select = cols)
    
    if (!length(cols_to_select) || is.null(cols_to_select)) {
      stop("No variable names matching those provided were found in 'data'.")
    }
    
    # Check if any 'cols' are empty; if yes, return remove from 'cols_to_select' 
    # and create an object to hold the names of the variables that were removed
    empty_cols <- .return_empty_cols(data = data[cols_to_select])
    
    if (length(empty_cols) > 0) {
      cols_removed <- paste0("The following variables in 'data' were excluded from the dictionary because they are empty: ",
                             .join_text(text = names(empty_cols)))
      
      cols_to_select <- cols_to_select[-empty_cols]
    }
    
    if (!length(cols_to_select) || is.null(cols_to_select)) {
      stop("All selected variables were empty and there are no remaining variables to review.")
    }
    
    # Create a dictionary 'entry' for each variable in 'cols_to_select'
    # data_dictionary <- tibble::tibble()
    row_list <- list()      
    row_num <- 1
    
    for (num in seq_along(cols_to_select)) {
      
      # Setup
      x <- data[[cols_to_select[num]]]
      x_na <- is.na(x)
      question_label <- .get_q_Label(x, label_width = q_label_width)
      value_labels <- .get_val_labels(x)
      display_range <- FALSE
      
      # If labelled
      if (!is.null(value_labels)) {
        
        # find na values (both labelled and tagged)
        na_labels <- labelled::get_na_values(x)
        na_vals_x <- if (is.double(x)) haven::na_tag(x) else NULL
        na_values <- na.omit(na_vals_x)
        
        # affix a prefix (na_) to 'tagged' values
        if (length(na_labels) > 0 || length(na_values) > 0) {
          value_labels[paste0("na_", c(na_labels,na_values))] <-
            as.character(c(na_labels, na_values))
          
          x <- dplyr::coalesce(as.character(x), na_vals_x)
          x_na <- is.na(x)
        }
      }
      
      x <- x[!(x_na)]
      unique_values <- unique(x)
      
      # If not numeric or factor coerce to factor
      if (!is.numeric(x) && !is.factor(x)) {
        x <- as.factor(x)
      }
      
      # Check for unique values and value labels
      if (!is.null(value_labels) && length(value_labels) > 0) {
        
        if (!all(unique_values %in% unname(value_labels))) {
          vals_to_add <- unique_values[!unique_values %in% value_labels]
          value_labels <- c(value_labels, stats::setNames(vals_to_add, vals_to_add))
        }
        
        if (!all(unname(value_labels) %in% unique_values)) {
          vals_to_remove <- value_labels[!value_labels %in% unique_values]
          vals_to_remove <- stats::na.omit(match(vals_to_remove, value_labels))
          value_labels <- value_labels[-vals_to_remove]
        }
        
        valLabels <- names(value_labels)[order(unname(value_labels))]
        values <- sort(unname(value_labels))
        n_size <- tabulate(as.factor(x))
        
        # If factor
      } else if (is.factor(x)) {
        values <- levels(x)
        valLabels <- NA
        n_size <- tabulate(x)
        
        # If numeric
      } else {
        valLabels <- NA
        
        # Print range, if length of unique_values > max_display_values
        if (length(unique_values) > max_display_values) {
          display_range <- TRUE
          r_vals <- range(x, na.rm = TRUE)
          values <- sprintf("%.2f - %.2f", r_vals[1], r_vals[2])
          n_size <- sum(!x_na)
          
          # Otherwise print unique values (sorted)
        } else {
          values <- sort(unique_values)
          n_size <- tabulate(as.factor(x))
        }
      }
      # Finalize the entry
      row_list[[row_num]] <- list(
        column_index = num,
        variable_name = cols_to_select[num],
        question_label = question_label,
        variable_values = as.character(values),
        value_labels = as.character(valLabels),
        n_size = n_size,
        is_range = display_range
      )
      row_num <- row_num + 1
      
      row_list[[row_num]] <- list(
        column_index = num,
        variable_name = cols_to_select[num],
        question_label = question_label,
        variable_values = NA,
        value_labels = "system missing",
        n_size = sum(x_na),
        is_range = display_range
      )
      row_num <- row_num + 1
    }
    
    data_dictionary <- dplyr::bind_rows(lapply(row_list, tibble::as_tibble))
    
    if (length(empty_cols) > 0) {
      message(cols_removed)
    }
    data_dictionary
  }
  )}

