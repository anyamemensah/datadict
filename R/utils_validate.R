#### Utility functions for validation
# Validate the 'data' argument
validate_df <- function(data, return_type = c("dt", "tibble"), show_msg = FALSE) {
  return_type <- match.arg(return_type)
  
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
        "i" = "Duplicate column names detected."),
      call = get_call()
    )
  }
  
  if (show_msg) cli::cli_alert_success("{.arg data} is a valid {.cls data.frame}.")
  
  if (return_type == "dt") {
    return(list(
      valid = TRUE, 
      dt = data.table::as.data.table(data),
      type = "data.table"
    ))
  } else {
    return(list(
      valid = TRUE, 
      data = tibble::as_tibble(data),
      type = "tibble"
    ))
  }
}

# Validate columns/variables to process
validate_dt_columns <- function(dt, columns) {
  # Extract all column names
  all_cols <- colnames(dt)
  
  # Find columns to process
  if (is.null(columns)) {
    cols_to_process <- all_cols
  } else {
    cols_to_process <- generics::intersect(all_cols, columns)
  }
  
  # Remove complete empty (NA) columns
  empty_check <- 
    dt[, lapply(.SD, function(x) all(is.na(x))), .SDcols = cols_to_process]
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

# Generic scalar validation helper (Internal)
validate_scalar <- function(x, x_label, type_check_fn, type_name) {
  if (length(x) != 1 || !type_check_fn(x) || is.na(x)) {
    cli::cli_abort(
      c("Invalid {.arg {x_label}} argument.",
        "x" = "{.arg {x_label}} must be a {type_name} of length one.",
        "i" = "Received {.cls {class(x)}} of length {length(x)}."),
      call = get_call()
    )
  }
  return(x)
}

validate_chr_scalar <- function(x, x_label) {
  val <- validate_scalar(x, x_label, is.character, "character vector")
  
  return(list(valid = TRUE, x = val, x_label = x_label))
}

validate_int_scalar <- function(x, x_label) {
  val <- validate_scalar(x, x_label, is.numeric, "number")
  if (val < 0) {
    cli::cli_abort("{.arg {x_label}} must be a non-negative number.", call = get_call())
  }
  
  return(list(valid = TRUE, x = as.integer(val), x_label = x_label))
}

validate_logical <- function(x, x_label) {
  val <- validate_scalar(x, x_label, is.logical, "logical (TRUE/FALSE)")
  
  return(list(valid = TRUE, x = val, x_label = x_label))
}

# Validate a column/variable exists
validate_col_arg <- function(x, x_label, data, show_msg = FALSE) {
  if (!is.character(x) || length(x) != 1) {
    cli::cli_abort(
      c("Invalid {.field {x_label}} argument.", 
        "i" = "The {.field {x_label}} argument must be a character vector of length one."),
      call = get_call()
    )
  }
  
  if (!x %in% colnames(data)) {
    cli::cli_abort(
      c("Invalid {.arg {x_label}} argument.", 
        "i" = "{.field {x}} is not a column in {.arg data}."),
      call = get_call()
    )
  }
  
  if (show_msg) {
    cli::cli_alert_success("{.field {x}} is a valid column in {.arg data}.")
  }
  
  return(list(valid = TRUE, x = x, x_label = x_label))
}

# Ensure a one-to-one relationship between from and to values
validate_dict_val_lens <- function(data,
                                   var_col,
                                   from_col,
                                   to_col,
                                   remove_na,
                                   remove_empty,
                                   is_verbose) {
  dt <- data.table::as.data.table(data)
  
  split_list <- split(dt[, c(var_col, from_col, to_col), with = FALSE], by = var_col)
  
  mismatches <- vapply(split_list, function(sub) {
    u_from <- length(extract_unique(sub[[from_col]], remove_na, remove_empty))
    u_to   <- length(extract_unique(sub[[to_col]], remove_na, remove_empty))
    u_from != u_to
  }, logical(1))
  
  failing_vars <- names(mismatches)[mismatches]
  
  if (length(failing_vars) > 0L) {
    cli::cli_abort(
      c("Mismatched from/to lengths detected.",
        "x" = "The number of unique {.field {from_col}} values must match {.field {to_col}} values.",
        "i" = "Failing variables: {.val {failing_vars}}"),
      call = get_call()
    )
  }
  
  if (is_verbose) {
    cli::cli_alert_success(
      "All categories in {.field {var_col}} have an equal number of from/to values."
    )
  }
  
  return(invisible(TRUE))
}


# Validate minimum row counts per category
validate_rows_per_variable <- function(data, column, n_rows, is_verbose) {
  dt <- data.table::as.data.table(data)
  
  counts <- dt[, .N, by = c(column)][N < n_rows]
  failing_elements <- counts[[column]]
  
  if (length(failing_elements) > 0L) {
    cli::cli_abort(
      c("Frequency threshold not met.",
        "x" = "Each unique value in {.arg {column}} must appear at least {.val {n_rows}} time(s).",
        "i" = "The following values have fewer than {.val {n_rows}} row(s): {.val {failing_elements}}"),
      call = get_call()
    )
  }
  
  if (is_verbose) {
    cli::cli_alert_success(
      "All categories in {.field {column}} meet the {.val {n_rows}}-row minimum."
    )
  }
  
  return(invisible(TRUE))
}
