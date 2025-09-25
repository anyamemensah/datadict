#' Generate a data dictionary from a data frame.
#'
#' @description `generate_dict()` generates a data dictionary from a data frame. The data
#' dictionary includes variable indices (which help identify groups of variables with multiple 
#' values or labels), variable names, question labels (if available), variable values, value 
#' labels, and the frequencies of both non-missing and missing values or labels. NOTE: "tagged" 
#' missing values will appear with the prefix `NA_tagged` under the `value_labels` column. 
#' For variables with value label attributes (i.e., 'labelled' variables), any unique values 
#' that do not have a corresponding value label will have the value itself used as a value label 
#' in the `value_labels` column.
#'
#' @param data A data frame.
#' @param cols A character string, or vector of character strings, of the variable names
#' in `data` to include in the dictionary. Default is `NULL` and all variables will be
#' included in the dictionary.
#' @param max_display_values An integer that sets the maximum number of unique values from 
#' a numeric vector to display as individual rows in the dictionary. If the  vector contains 
#' more unique values than this limit, the values are summarized and presented as a range. 
#' This setting is especially useful when numeric variables have only a few  distinct values,
#' as it allows all values to be shown instead of condensing them into a range.
#' @param default_var_label A character string specifying the default label for variables without 
#' one in `data`. Default is `NO QUESTION LABEL`.
#' @param default_var_label_width An integer that sets the maximum number of characters displayed 
#' for a question (or variable) label. Default is `100` and the first 100 characters of 
#' the label will be shown.
#' @param default_empty_values A character string, or vector of character strings, specifying 
#' default values to search for in each variable of `data`. If an entire column consists solely 
#' of any or all of these values, that variable will be excluded from the dictionary. Default
#' values to search for are `NA` and `""`.
#' @param drop_unused_labels A boolean value specifying whether to remove value labels not present 
#' in the data. These unused value labels are identified separately for each variable. Default is 
#' `TRUE`.
#'
#' @returns A tibble summarizing the contents of `data` is displayed. The resulting columns 
#' include variable index (variable_index), variable names (variable_name) as they appear 
#' in the data frame, question labels (variable_label), distinct variable values 
#' (variable_values), corresponding value labels (value_labels), frequencies (n_size; 
#' the number of times each unique value/label appears), and a boolean flag (is_range) 
#' indicating whether the data for each variable is shown as a range.
#'
#' @examples
#' generate_dict(data = nlsy)
#'
#' # example shortening question labels to 25 characters
#' generate_dict(data = gss, default_var_label_width = 25)
#'
#' # example selecting a subset of variables from a data frame
#' generate_dict(data = gss, cols = c("year","age","sexnow1","hispanic","race","marital"))
#' 
#' # example retaining all value labels
#' generate_dict(data = gss, cols = c("age"))
#' generate_dict(data = gss, cols = c("age"), drop_unused_labels = FALSE)
#'
#' @export
generate_dict <- function(data,
                          cols = NULL,
                          max_display_values = 10,
                          default_var_label = NULL,
                          default_var_label_width = 100,
                          default_empty_values = c("", NA),
                          drop_unused_labels = TRUE) {
  withr::with_options(list(scipen = 999), {
    
    # Check 'data' is a data frame with at least one row/column
    if (!is.data.frame(data)) {
      stop("The 'data' argument is not a data frame.")
    }
    
    if (prod(dim(data)) == 0) {
      stop("The 'data' argument is empty.")
    }
    
    # Find 'cols' to include in the dictionary; stop if none are found
    cols_to_select <- .select_cols(data = data, cols_to_select = cols)
    
    if (!length(cols_to_select) || is.null(cols_to_select)) {
      stop("No variable names matching those provided were found in 'data'.")
    }
    
    # Check if any 'cols' are empty; if yes, remove them from 'cols_to_select'
    # and create an object to hold the names of the variables that were removed
    # to print to screen as a message with the dictionary
    empty_cols <- .return_empty_cols(data = data[cols_to_select], empty_values = default_empty_values)
    
    if (length(empty_cols) > 0) {
      cols_removed <- paste0(
        "The following variables in 'data' were excluded from the dictionary because they are empty: ",
        .join_text(text = names(empty_cols))
      )
      
      cols_to_select <- cols_to_select[-empty_cols]
    }
    
    # Check that there are still some columns to generate a dictionary for
    if (!length(cols_to_select) || is.null(cols_to_select)) {
      stop("All selected variables were empty and there are no remaining variables to review.")
    }
    
    # Subset data
    data <- data[cols_to_select]
    
    # Create a dictionary 'entry' for each variable in 'cols_to_select'
    row_list <- list()
    row_num <- 1
    
    for (num in seq_along(cols_to_select)) {
      
      # Setup
      x <- data[[num]]
      variable_label <- get_var_label(x, default_var_label, default_var_label_width)
      value_labels <- attr(x, "labels", exact = TRUE)
      variable_type <- .get_var_type(x)
      display_range <- FALSE
      
      # Check for NAs
      x_na <- is.na(x)
      
      # If any 'tagged' NA values are found, affix a prefix (NA_tagged) to them, and 
      # then add the values back to 'x' as character string and recheck for NAs
      if (any(haven::is_tagged_na(x))) {
        value_labels[paste0("NA_tagged(", stats::na.omit(haven::na_tag(x)), ")")] <-
          as.character(stats::na.omit(haven::na_tag(x)))
  
        # Add all 'tagged' NA values back to x
        x <- dplyr::coalesce(as.character(x), haven::na_tag(x))
        
        # Then recheck for NAs
        x_na <- is.na(x)
      }
      
      # Find non-missing, unique values
      x <- x[!(x_na)]
      unique_values <- unique(x)
      
      # If labels were found, check for unique value/label pairs
      if (!is.null(value_labels) && length(value_labels) > 0) {
        
        # unique values without labels to add
        if (!all(unique_values %in% unname(value_labels))) {
          labels_to_add <- unique_values[!unique_values %in% value_labels]
          value_labels <- c(value_labels, stats::setNames(labels_to_add, as.character(labels_to_add)))
        }
        
        # Whether to drop unused labels
        if (drop_unused_labels) {
          if (!all(unname(value_labels) %in% unique_values)) {
            labs_to_remove <- value_labels[!value_labels %in% unique_values]
            labs_to_remove <- stats::na.omit(match(labs_to_remove, value_labels))
            value_labels <- value_labels[-labs_to_remove]
          }
        }
        
        # Sort on values, coerce 'x' to factor, and then tally the unique occurrences 
        valLabels <- names(value_labels)[order(unname(value_labels))]
        values <- value_labels[order(unname(value_labels))]
        x <- factor(x, levels = unname(value_labels), labels = names(value_labels))
        n_size <- tabulate(x)
        
        # If factor, extract levels and then tally the unique occurrences
      } else if (is.factor(x) || ((!is.numeric(x) && !is.factor(x)))) {
        
        # Coerce to factor if not
        if (!is.numeric(x) && !is.factor(x)) {
          x <- as.factor(x)
        }
        
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
          
          # Otherwise, sort on values and then tally the unique occurrences
        } else {
          values <- unique_values[order(unique_values)]
          n_size <- tabulate(as.factor(x))
        }
      }
      
      # Finalize the entry
      row_list[[row_num]] <- list(
        variable_index = num,
        variable_name = cols_to_select[num],
        variable_label = variable_label,
        variable_type = variable_type,
        variable_values = as.character(values),
        value_labels = as.character(valLabels),
        n_size = n_size,
        is_range = display_range
      )
      row_num <- row_num + 1
      
      row_list[[row_num]] <- list(
        variable_index = num,
        variable_name = cols_to_select[num],
        variable_label = variable_label,
        variable_type = variable_type,
        variable_values = NA,
        value_labels = "system missing",
        n_size = sum(x_na),
        is_range = display_range
      )
      row_num <- row_num + 1
    }
    
    # Combine into a tibble
    data_dictionary <- dplyr::bind_rows(lapply(row_list, tibble::as_tibble))
    
    if (length(empty_cols) > 0) {
      # Print message of columns that were removed (if any)
      message(cols_removed)
    }
    
    # Return dictionary
    data_dictionary
    
  })
}
#'
#' @keywords internal
get_var_label <- function(x, default_value = NULL, label_width = 100) {
  
  label <- attr(x, "label", exact = TRUE)
  
  if (is.null(label)) {
    label <- check_default_label(default_value)
  }
  if (nchar(label) > label_width) {
    label <- substr(label, start = 1, stop = label_width)
  }
  label
}
#'
#' @keywords internal
check_default_label <- function(default_value = NULL) {
  
  if (!is.null(default_value) && (!is.character(default_value) || length(default_value) != 1)) {
    stop("default_value should either be NULL or a character vector of length one.")
  }
  
  if (is.null(default_value)) {
    return ("NO QUESTION LABEL")
  } else {
    return(default_value)
  }
}
