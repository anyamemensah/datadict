#' @title Generate a data dictionary
#'
#' @description `generate_dict()` builds a data dictionary from a data frame
#' or tibble. It produces a structured overview of variable metadata, including
#' variable names, labels, data types, value distributions, and any available
#' values or value labels.
#'
#' @param data A data frame or tibble.
#' @param columns An optional character vector of column names to include in 
#' the dictionary. If `NULL` (default), information for all non-empty columns/
#' variables are included in the dictionary.
#' @param n_max An integer that controls how detailed numeric reporting should 
#' be. If a numeric variable has more unique values than this threshold, it is 
#' summarized  as a range (e.g., `1 – 100`). If it has fewer, each unique value 
#' receives its own row in the dictionary. Defaults to `10`.
#' @param label_fallback The placeholder text to use when a variable does not 
#' have a defined label attribute. Defaults to `"NO QUESTION LABEL"`.
#' @param label_width An integer to truncate long variable labels for better 
#' readability. Defaults to `100` characters.
#'
#' @returns A tibble with the following structural metadata:
#'\itemize{
#' \item variable_name: The column/variable name as it appears in the data source.
#' \item variable_label: The descriptive variable label or the default placeholder.
#' \item variable_type: The type of data contained within the column/variable (e.g., 
#' numeric, character, labelled, factor). Data type is derived using R's `class()` 
#' function.
#' \item variable_values: Individual data values or range of data values.
#' \item value_labels: The descriptive labels assigned to specific data values.
#' \item n_size: The frequency count for each value/label pair.
#' \item is_range: A boolean flag indicating if the `variable_values` column 
#' represents a summarized range rather than a discrete value.
#'}
#'
#' @author Ama Nyame-Mensah
#'
#' @examples
#' generate_dict(data = nlsy)
#'
#' # example shortening variable labels to 25 characters
#' generate_dict(data = gss, label_width = 25)
#'
#' # example selecting a subset of variables from a tibble
#' generate_dict(
#'   data = gss,
#'   columns = c("year", "age", "sexnow1", "hispanic", "race", "marital")
#' )
#'
#' @export
generate_dict <- function(data,
                          columns = NULL,
                          n_max = 10L,
                          label_fallback = "NO QUESTION LABEL",
                          label_width = 100L) {
  set_call()
  on.exit({ .datadict$env <- NULL }, add = TRUE)
  
  args <- list(
    data = data,
    columns = columns,
    n_max = n_max,
    label_fallback = label_fallback,
    label_width = label_width
  )
  
  checks <- check_gen_dict_args(args)
  check_columns <- checks$columns
  check_empty_columns <- checks$empty_columns
  check_n_max <- checks$n_max
  check_label_fallback <- checks$label_fallback
  check_label_width <- checks$label_width
  
  dt_sub <- checks$dt[, ..check_columns]
  dt_sub_backup <- checks$dt[, ..check_columns]
  
  # Extract variable metadata: variable labels, variable 
  # types, variable values, and value labels
  meta_list <- 
    lapply(dt_sub[, ..check_columns], function(x) {
      list(
        label = process_var_label(
          attr(x, "label", exact = TRUE),
          check_label_width,
          check_label_fallback
        ),
        type = get_var_type(x),
        variable_values = as.vector(unname(attr(x, "labels", exact = TRUE))),
        value_labels = names(attr(x, "labels", exact = TRUE))
      )
    })
  
  # Coerce 'haven_labelled' columns to atomic vectors
  for (j in check_columns) {
    if (inherits(dt_sub[[j]], "haven_labelled")) {
      data.table::set(dt_sub, j = j, value = as.vector(dt_sub[[j]]))
    }
  }
  
  # Melt data to long format; one row per observation per column/variable
  long_dt <- suppressWarnings(
    data.table::melt.data.table(
      dt_sub,
      measure.vars = check_columns,
      variable.factor = FALSE,
      value.name = "val",
      variable.name = "var"
    )
  )
  
  # Create key 
  data.table::setkeyv(long_dt, c("var", "val"))
  
  # Calculate frequencies
  stats_dt <- long_dt[, .(n_size = .N), by = .(var, val)]
  
  # Split stats_dt into a list by variable name
  stats_by_var <- split(stats_dt, by = "var")
  
  # Assemble dictionary by iterating over the metadata list
  final_list <- lapply(check_columns, function(cn) {
    # Column-specific metadata
    m <- meta_list[[cn]]
    
    # Column-specific stats
    col_stats <- stats_by_var[[cn]]
    
    # Extract non-missing stats
    valid_stats <- col_stats[!is.na(val)]
    valid_stats[, val := as.character(val)]
    
    # Extract missing data row info
    missing_count <- col_stats[is.na(val), sum(n_size)]
    missing_row <- data.table::data.table(
      variable_name = cn,
      variable_label = m$label,
      variable_type = m$type,
      variable_values = NA_character_,
      value_labels = "system missing",
      n_size = missing_count,
      is_range = FALSE
    )
    
    # Create 'is_num' flag
    # Note: data type must be numeric AND number of rows in
    # valid_stats must be greater than specified n_max
    is_num <- m$type == "numeric" && nrow(valid_stats) > check_n_max
    
    # If column data are numeric
    if (is_num) {
      # Calculate range
      r_vals <- range(as.numeric(valid_stats$val), na.rm = TRUE)
      fmt <- if (all(r_vals %% 1 == 0)) "%.0f - %.0f" else "%.2f - %.2f"
      
      # Create main dictionary for non-missing entries
      main_rows <- data.table::data.table(
        variable_name = cn,
        variable_label = m$label,
        variable_type = m$type,
        variable_values = sprintf(fmt, r_vals[1], r_vals[2]),
        value_labels = NA_character_,
        n_size = sum(valid_stats$n_size),
        is_range = TRUE
      )
      # If column data are not numeric
    } else {
      # Extract possible value/label pairs from metadata
      possible_dt <- 
        if (!is.null(m$variable_values)) {
          data.table::data.table(
            val = as.character(m$variable_values),
            value_labels = m$value_labels
          )
        } else {
          data.table::data.table(val = character(), value_labels = character())
        }
      
      # Extract actual values from data
      observed_dt <- valid_stats[, .(val = as.character(val), n_size)]
      
      # Create main dictionary for non-missing entries by merging
      # observed_dt / possible_dt by vals
      main_rows <- 
        data.table::merge.data.table( 
          possible_dt,
          observed_dt,
          by = "val", 
          all = TRUE,
          sort = FALSE
        )
      
      # Create a sort key based on the variable type:
      # factors: use the variable's defined level order
      # labelled: use the label order defined in the metadata
      # all others: sort numerically where possible
      if (m$type == "factor") {
        lvls <- levels(dt_sub_backup[[cn]])
        main_rows[, sort_key := match(val, lvls)]
        
      } else if (m$type == "labelled") {
        lvls <- as.character(m$variable_values)
        main_rows[, sort_key := match(val, lvls)]
        
      } else {
        main_rows[, sort_key := suppressWarnings(as.numeric(val))]
      }
      # Sort and remove temporary key
      data.table::setorder(main_rows, sort_key, val, na.last = TRUE)
      main_rows[, sort_key := NULL]
      
      # Add other metadata to main dictionary
      main_rows[, `:=`(
        variable_name = cn,
        variable_label = m$label,
        variable_type = m$type,
        variable_values = val,
        value_labels = data.table::fcoalesce(value_labels, val),
        is_range = FALSE
      )]
      data.table::setnafill(main_rows, fill = 0, cols = "n_size")
    }
    
    # Combine min_rows, missing_row into a list
    return(list(main_rows, missing_row))
  })
  
  # If any empty columns were excluded, alert.
  if (length(check_empty_columns) > 0) {
    cli::cli_alert_info(
      text = paste(
        "The following empty columns/variables were excluded",
        "from the data dictionary: {.val {check_empty_columns}}."
      ),
      wrap = TRUE
    )
  }
  
  # Flatten final_list into a table; retain select columns
  final_dict <- data.table::rbindlist(unlist(final_list, recursive = FALSE),
                                      use.names = TRUE,
                                      fill = TRUE)[, ..dict_columns]
  
  # Return full data dictionary as tibble
  return(tibble::as_tibble(final_dict))
}
