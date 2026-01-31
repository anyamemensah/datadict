#' @title Expand a delimited data dictionary
#'
#' @description `expand_delim_dict()` unpacks a delimited data dictionary 
#' by expanding rows containing multiple values into a tidy, row-per-value 
#' format. The function identifies entries where multiple original values and 
#' labels are stored as strings (e.g., "1,2,3") and restructures the data so 
#' that each unique `from`/`to` pair occupies its own dedicated row.
#'
#' \strong{Note:} The function only retains columns relevant to the expansion 
#' process: `var_col`, `from_col`, and `to_col.` All other columns present in 
#' the input dictionary are removed during processing.
#'
#' @param data A data frame or tibble containing the unique `from` and `to` 
#' values for variables in a dataset.
#' @param var_col A character string of the name of the column in `data` 
#' that contains unique variable names in your dataset.
#' @param from_col A character string specifying the name of the column in 
#' `data` that contains the original values (i.e., `from values`) for each 
#' variable in your dataset.
#' @param to_col A character string specifying the name of the column in 
#' `data` that contains the new values (i.e., `to values`) for each variable 
#' in your dataset.
#' @param from_delim A character or set of characters used to separate values 
#' in the `from_col`. Default is a comma `,`.
#' @param to_delim A character or set of characters used to separate values 
#' in the `to_col`. Default is a semi-colon `;`.
#' @param remove_na A logical value indicating whether to remove `NA` 
#' values from both `from_col` and `to_col.` Default is `FALSE`.
#' @param remove_empty A logical value indicating whether to remove empty 
#' strings (including entries that are blank or contain only whitespace) 
#' from both `from_col` and `to_col`. Default is `FALSE`.
#' @param run_check A logical value indicating whether to run 
#' \code{\link{validate_dict}} to validate the expanded data dictionary. 
#' 
#' Verification ensures:
#' \itemize{
#'   \item Each unique category in `var_col` meets the minimum row threshold.
#'   \item A strict one-to-one relationship exists between `from` and `to`
#'   values for every unique category in `var_col`.
#' }
#' Default is `TRUE`.
#' 
#' @param min_rows A non-negative integer indicating the minimum number
#' of entries (rows) expected for each variable in the data dictionary.
#' Default is `1`.
#' @param quiet A logical value indicating whether to suppress progress 
#' and validation success alerts. Default is `FALSE`.
#'
#' @return A tibble in long format containing only the three columns specified 
#' in `var_col`, `from_col`, and `to_col`.
#' 
#' @author Ama Nyame-Mensah
#' 
#' @examples
#' expand_delim_dict(
#'   data = grad_app_dict_delim,
#'   var_col = "column_name",
#'   from_col = "old_values",
#'   to_col = "new_labels",
#'   from_delim = ";",
#'   to_delim = ";",
#'   remove_na = FALSE,
#'   remove_empty = FALSE,
#'   min_rows = 1L
#' )
#'
#' @export
expand_delim_dict <- function(data,
                              var_col,
                              from_col,
                              to_col,
                              from_delim = ",",
                              to_delim = ";",
                              remove_na = FALSE,
                              remove_empty = FALSE,
                              run_check = TRUE,
                              min_rows = 1L,
                              quiet = FALSE) {
  set_call()
  on.exit({ .datadict$env <- NULL }, add = TRUE)
  
  args <- list(
    data = data,
    var_col = var_col,
    from_col = from_col,
    to_col = to_col,
    from_delim = from_delim,
    to_delim = to_delim,
    remove_na = remove_na,
    remove_empty = remove_empty,
    run_check = run_check,
    min_rows = min_rows,
    quiet = quiet
  )
  
  # checks
  checks <- check_expand_dict_args(args)
  check_data <- checks$data
  
  # return expanded dictionary as tibble
  return(tibble::as_tibble(check_data))
}

#' @keywords internal
expand_dict <- function(dt,
                        var_col,
                        from_col,
                        to_col,
                        from_delim,
                        to_delim,
                        remove_na,
                        remove_empty) {
  dt_internal <- data.table::as.data.table(dt)
  
  # Extract values and check them by 'var_col'
  expanded_dt <- dt_internal[, {
    # Extract 'from' values
    from_vals <- extract_unique(
      extract_values(.SD[[from_col]], delim = from_delim),
      remove_na = remove_na,
      remove_empty = remove_empty
    )
    
    # Extract 'to' values
    to_vals   <- extract_unique(
      extract_values(.SD[[to_col]], delim = to_delim),
      remove_na = remove_na,
      remove_empty = remove_empty
    )
    
    # Check if the values seem unparsed.
    # If yes, throw an error message
    if (length(from_vals) == 1 && length(to_vals) == 1) {
      
      # Identify common delimiters
      potential_delims <- c(",", ";", "|", ":")
      
      # Find characters that are present in the string but 
      # not used as the delimiter
      suspicious_from <- setdiff(potential_delims, from_delim)
      suspicious_to   <- setdiff(potential_delims, to_delim)
      
      # Build regex patterns (escape for safety)
      pattern_from <- paste(Hmisc::escapeRegex(suspicious_from), collapse = "|")
      pattern_to   <- paste(Hmisc::escapeRegex(suspicious_to), collapse = "|")
      
      # Check if strings contain any of the 'other' delimiters
      from_is_suspicious <- nchar(pattern_from) > 0 && grepl(pattern_from, from_vals)
      to_is_suspicious   <- nchar(pattern_to) > 0 && grepl(pattern_to, to_vals)
      
      if (from_is_suspicious || to_is_suspicious) {
        abort_sus_delim(
          var_col = .BY[[var_col]], 
          from_vals = from_vals, 
          to_vals = to_vals, 
          from_delim = from_delim,
          to_delim = to_delim
        )
      }
    }
    
    # Check that from/to pairs are the same length
    # If they aren't, throw an error message
    if (length(from_vals) != length(to_vals)) {
      abort_length_mismatch(.BY[[var_col]], from_vals, to_vals)
    }
    
    # Combine into list
    list(from = from_vals, to = to_vals)
    
  }, by = var_col]
  
  # Rename columns
  data.table::setnames(expanded_dt,
                       old = c("from", "to"),
                       new = c(from_col, to_col))
  
  # Return expanded dictionary as tibble
  return(tibble::as_tibble(expanded_dt))
}
#' @keywords internal
abort_length_mismatch <- function(var_col, from_vals, to_vals) {
  cli::cli_abort(
    c(
      "x" = "Mismatched from/to lengths detected in {.field {var_col}}.",
      "i" = "The number of unique {.field from_vals} values must match {.field to_vals} values.",
      "*" = "Values detected:",
      " " = "{.field from}: {.val {from_vals}}",
      " " = "{.field to}:   {.val {to_vals}}"),
    call = get_call()
  )
}
#' @keywords internal
abort_sus_delim <- function(var_col, from_vals, to_vals, from_delim, to_delim) {
  cli::cli_abort(
    c(
      "x" = "Suspected delimiter mismatch in {.field {var_col}}.",
      "i" = "It looks like the values weren't split, but the strings contain other separators.",
      "*" = "Arguments: {.code from_delim = {from_delim}} and {.code to_delim = {to_delim}}.",
      "*" = "Values detected:",
      " " = "{.field from}: {.val {from_vals}}",
      " " = "{.field to}:   {.val {to_vals}}",
      "v" = "Confirm if your delimiter arguments match the data."
    ),
    call = get_call()
  )
}
