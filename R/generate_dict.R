#' Generate a data dictionary from a data frame.
#'
#' @description `generate_dict()` generates a data dictionary from a data frame. The
#' data dictionary includes variable indices (which help identify groups of variables 
#' with multiple values or labels), variable names, variable labels (if available), 
#' variable types, variable values, value labels, and the frequencies of both non-missing 
#' and missing values or labels. NOTE: "tagged" missing values will appear with the prefix 
#' `NA_tagged` under the `value_labels` column. For variables with value label attributes 
#' (i.e., 'labelled' variables), any unique values that do not have a corresponding value 
#' label will have the value itself used as a value label in the `value_labels` column. 
#' Variables that consist solely of `NA` values will be excluded from the dictionary.
#'
#' @param data A data frame.
#' @param cols A character string or a vector of character strings indicating which 
#' variable names from `data` to include in the dictionary. By default (`NULL`), information 
#' for all non-empty variables in `data` will be included.
#' @param max_numeric_display An integer specifying the maximum number of unique numeric values 
#' to display as individual rows in the dictionary. If a numeric vector has more unique values 
#' than the specified limit, the values are summarized as a range. This option is particularly 
#' helpful when numeric variables have only a few distinct values, allowing all of them to be 
#' displayed rather than condensed into a range. The default is `NULL`, which sets the maximum 
#' number of unique displayed values to 10.
#' @param default_var_label A character string to use as the default label for variables in 
#' `data` that do not have an existing label. The default is `NULL`, in which case the label 
#' is set to `NO QUESTION LABEL`.
#' @param default_var_label_width An integer specifying the maximum number of characters to 
#' display for each question or variable label. If `NULL` (default), only the first 100 
#' characters of each label will be shown.
#' @param drop_unused_labels If `FALSE` retains all value labels and not just those present in 
#' the data. These unused value labels are identified separately for each variable. Default is 
#' `TRUE`.
#'
#' @returns A tibble summarizing the contents of `data` is displayed. The resulting columns 
#' include variable index (variable_index), variable names (variable_name) as they appear 
#' in the data frame, variable labels (variable_label), variable types (variable_type) 
#' distinct variable values (variable_values), corresponding value labels (value_labels), 
#' frequencies (n_size; the number of times each unique value/label pair appears), and a 
#' boolean flag (is_range) indicating whether the data for each variable is shown as a range.
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
#' # example retaining only valid value labels vs all defined
#' generate_dict(data = gss, cols = c("age"))
#' generate_dict(data = gss, cols = c("age"), drop_unused_labels = FALSE)
#'
#' @export
generate_dict <- function(data,
                          cols = NULL,
                          max_numeric_display = NULL,
                          default_var_label = NULL,
                          default_var_label_width = NULL,
                          drop_unused_labels = TRUE) {
  withr::with_options(list(scipen = 999), {
    
    # Check 'data' is a data frame with at least one row/column
    if (!is.data.frame(data)) {
      stop("The 'data' argument is not a data frame.")
    }
    
    if (prod(dim(data)) == 0) {
      stop("The 'data' argument is empty.")
    }
    
    # Check 'cols' returns at least one valid variable; If not, stop 
    cols_info <- .select_cols(data = data, cols_to_select = cols)
    cols_to_select <- cols_info$selected   
    empty_cols <- cols_info$all_missing  
    
    if (is.null(cols_to_select)) {
      if (length(empty_cols) > 0) {
        stop("All selected variables consist entirely of missing values. Please review 'data' and select different variables.")
      } else {
        stop("No variable names matching those provided were found in 'data'.")
      }
    }
    
    # Check 'max_numeric_display' is a numeric vector of length 1
    if (is.null(max_numeric_display)) {
      max_numeric_display <- 10L
    } else {
      max_numeric_display <- suppressWarnings(as.integer(max_numeric_display))
    }
    
    if (!is.integer(max_numeric_display) || length(max_numeric_display) !=1 || is.na(max_numeric_display)) {
      stop("Invalid 'max_numeric_display' argument. 'max_numeric_display' must be an integer vector of length one.")
    }
    
    # Check 'default_var_label' is a character vector of length 1
    if (is.null(default_var_label)) {
      default_var_label <- "NO QUESTION LABEL"
    } else {
      default_var_label <- default_var_label
    }
    
    if (!is.character(default_var_label) || length(max_numeric_display) !=1) {
      stop("Invalid 'default_var_label' argument. 'default_var_label' must be a character vector of length one.")
    }
    
    # Check 'default_var_label_width' is a numeric vector of length 1
    if (is.null(default_var_label_width)) {
      default_var_label_width <- 100L
    } else {
      default_var_label_width <- suppressWarnings(as.integer(default_var_label_width))
    }
    
    if (!is.integer(default_var_label_width) || length(default_var_label_width) !=1 || is.na(default_var_label_width)) {
      stop("Invalid 'default_var_label_width' argument. 'default_var_label_width' must be an integer vector of length one.")
    }
    
    # Check 'drop_unused_labels' is a logical vector of length 1
    if (!is.logical(drop_unused_labels) || length(drop_unused_labels) !=1) {
      stop("Invalid 'drop_unused_labels' argument. 'drop_unused_labels' must be a logical vector of length one.")
    }
    
    # Preprocessing: subset relevant columns from 'data', pre-calculate 
    # lists of variable attributes, and initialize object to store dictionary 
    # entries
    data <- data[cols_to_select]
    
    variable_labels_list <- lapply(cols_to_select, function(col) attr(data[[col]], "label", exact = TRUE))
    names(variable_labels_list) <- cols_to_select
    variable_labels_list <- lapply(variable_labels_list, .process_var_label, default_var_label_width, default_var_label)
    
    variable_types_list <- lapply(cols_to_select, function(col) .get_var_type(data[[col]]))
    
    value_labels_list <- lapply(cols_to_select, function(col) attr(data[[col]], "labels", exact = TRUE))
    names(value_labels_list) <- cols_to_select
    
    na_tagged_labels <- lapply(cols_to_select, function(col) any(haven::is_tagged_na(data[[col]])))
    
    row_list <- list()
    row_num <- 1L
    
    # Create an 'entry' for each variable in 'cols_to_select'
    for (num in seq_along(cols_to_select)) {
      
      x <- data[[num]]
  
      display_range <- FALSE
      
      # If 'x' has 'tagged' NA values, affix a prefix (NA_tagged) to them, add 
      # then add the updated 'tagged' values back to 'x' as character string
      if (na_tagged_labels[[num]]) {
        value_labels_list[[num]][paste0("NA_tagged(", stats::na.omit(haven::na_tag(x)), ")")] <-
          as.character(stats::na.omit(haven::na_tag(x)))
  
        x <- dplyr::coalesce(as.character(x), haven::na_tag(x))
      }
      
      # Identify unique values in 'x'
      x_na <- is.na(x)
      x <- x[!x_na]
      unique_values <- unique(x)
      
      # If 'value_labels' is not empty, check for unique value/label pairs
      # (including whether to drop unused value labels), and then tally the 
      # unique occurrences
      if (!is.null(value_labels_list[[num]])) {
        
        value_labels <- value_labels_list[[num]]
        
        if (!all(unique_values %in% unname(value_labels))) {
          labels_to_add <- unique_values[!unique_values %in% value_labels]
          value_labels <- c(value_labels, stats::setNames(labels_to_add, as.character(labels_to_add)))
        }
        
        if (drop_unused_labels) {
          if (!all(unname(value_labels) %in% unique_values)) {
            labs_to_remove <- value_labels[!value_labels %in% unique_values]
            labs_to_remove <- stats::na.omit(match(labs_to_remove, value_labels))
            value_labels <- value_labels[-labs_to_remove]
          }
        }
        
        valLabels <- names(value_labels)[order(unname(value_labels))]
        values <- unname(value_labels[order(unname(value_labels))])
        n_size <- .count_occurences(x, values)
        
        # If 'x' is a factor OR if 'x' is not numeric and not a factor extract 
        # values and then tally the unique occurrences
      } else if (is.factor(x) || ((!is.numeric(x) && !is.factor(x)))) {
        
        valLabels <- NA
        values <- unique_values[order(unique_values)]
        n_size <- .count_occurences(x, values)
        
        # If 'x' is numeric length of unique_values is greater than max_numeric_display,
        # print range; otherwise, sort on unique values and then tally the unique 
        # occurrences
      } else {
        valLabels <- NA
        
        if (length(unique_values) > max_numeric_display) {
          display_range <- TRUE
          
          r_vals <- range(x, na.rm = TRUE)
          
          if (!any(r_vals %% 1 != 0)) {
            values <- sprintf("%.0f - %.0f", r_vals[1], r_vals[2])
          } else {
            values <- sprintf("%.2f - %.2f", r_vals[1], r_vals[2])
          }
          
          n_size <- sum(!x_na)
          
        } else {
          values <- as.character(unique_values[order(unique_values)])
          n_size <- .count_occurences(x, values)
        }
      }
      
      # Append all items to 'entry'
      row_list[[length(row_list) + 1L]] <- list(
        variable_index = num,
        variable_name = cols_to_select[num],
        variable_label = variable_labels_list[[num]],
        variable_type = variable_types_list[[num]],
        variable_values = as.character(values),
        value_labels = as.character(valLabels),
        n_size = as.integer(n_size),
        is_range = display_range
      )

      row_list[[length(row_list) + 1L]] <- list(
        variable_index = num,
        variable_name = cols_to_select[num],
        variable_label = variable_labels_list[[num]],
        variable_type = variable_types_list[[num]],
        variable_values = NA,
        value_labels = "system missing",
        n_size = sum(x_na),
        is_range = display_range
      )
    }
    
    data_dictionary <- dplyr::bind_rows(lapply(row_list, tibble::as_tibble))
    
    if (length(empty_cols) > 0) {
      message(paste0("The following variables in 'data' were excluded from the dictionary because they consist entirely of missing values: ",
                     .join_text(text = empty_cols)))
    }
    
    data_dictionary
    
  })
}

