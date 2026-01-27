#### Utility functions
# Function to set environment; for use with cli::cli_abort() 
# and cli::cli_warn()
set_call <- function(env = parent.frame()) {
  .datadict$env <- env
  invisible()
}


# Function to get environment; for use with cli::cli_abort() 
# and cli::cli_warn()
get_call <- function() {
  if(!is.null(.datadict$env)) {
    return(.datadict$env)
  }
  
  return(sys.call(sys.parent()))
}


# Function that validates the 'data' argument
check_df <- function(data) {
  if (!is.data.frame(data)) {
    cli::cli_abort(
      c("Invalid {.arg data} argument.", 
        "i" = "The {.arg data} argument must be a {.cls data.frame} or {.cls tibble}."),
      call = get_call()
    )
  }
  
  if (prod(dim(data)) == 0) {
    cli::cli_abort(
      c("Invalid {.arg data} argument.", 
        "i" = "The {.arg data} argument must have at least one row and one column."),
      call = get_call()
    )
  }
  
  if (anyDuplicated(colnames(data)) > 0) {
    cli::cli_abort(
      c("Invalid {.arg data} argument.",
        "x" = "Column names must be unique.",
        "i" = "Duplicate column names detected. Please ensure column names are unique before passing the data."),
      call = get_call()
    )
  }
  
  data.table_df <- data.table::as.data.table(data)
  
  return(list(valid = TRUE, dt = data.table_df))
}

# Function to check columns/variables to process
check_dt_columns <- function(dt, columns) {
  # Extract all column names
  all_cols <- colnames(dt)
  
  # Find columns to process
  if (is.null(columns)) {
    cols_to_process <- all_cols
  } else {
    cols_to_process <- generics::intersect(all_cols, columns)
  }
  
  # Remove complete empty (NA) columns
  empty_check <- dt[, lapply(.SD, function(x) all(is.na(x))), .SDcols = cols_to_process]
  empty_cols <- cols_to_process[as.logical(empty_check)]
  
  # Update columns to process
  cols_to_process <- generics::setdiff(cols_to_process, empty_cols)
  
  # Stop if no columns left to process
  if (length(cols_to_process) == 0) {
    error_msg <- if (is.null(columns)) {
      "Every column in the provided data frame is entirely {.cls NA}."
    } else {
      "The specific columns requested in {.arg columns} are either missing from the data or entirely {.cls NA}."
    }
    
    cli::cli_abort(
      c("No valid columns to process.",
        "x" = error_msg,
        "i" = "The data dictionary requires at least one column with non-missing values to generate metadata."),
      call = get_call()
    )
  }
  
  return(list(
    valid = TRUE,
    columns = cols_to_process,
    empty_columns = empty_cols
  ))
}

# Function to check integer argument ('n_max' and 'label_width')
check_integer_scalar <- function(x, x_label) {
  if (length(x) != 1 || !is.numeric(x)) {
    cli::cli_abort(
      c("Invalid {.arg {x_label}} argument.",
        "x" = "{.arg {x_label}} must be a single number.",
        "i" = "Received {.cls {class(x)}} of length {length(x)}."),
      call = get_call()
    )
  }
  
  return(list(valid = TRUE, x = as.integer(x), x_label = x_label))
}


# Function to check 'label_fallback' argument
check_label_fallback <- function(label_fallback) {
  if (length(label_fallback) != 1 || !is.character(label_fallback)) {
    cli::cli_abort(
      c("Invalid {.arg label_fallback} argument",
        "i" = "{.arg label_fallback} must be a character vector of length one."),
      call = get_call()
    )
  }
  
  return(list(valid = TRUE, label_fallback = label_fallback))
}


# Function to process column/variable label
process_var_label <- function(var_label,
                              default_label_width,
                              default_label) {
  if (is.null(var_label)) {
    var_label <- default_label
  }
  
  if (nchar(var_label) > default_label_width) {
    var_label <- substr(var_label, start = 1, stop = default_label_width)
  }
  
  return(var_label)
}

# Function to retrieve data type for a column/variable
get_var_type <- function(x) {
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
