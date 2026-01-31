##### Helper functions used to validate main function arguments
## Helper function to validate 'generate_dict' arguments
check_gen_dict_args <- function(args) {
  # Shared checks
  shared_checks <- list(
    data = function(args)
      validate_df(
        data = args$data,
        return_type = "dt",
        show_msg = FALSE
      ),
    n_max = function(args)
      validate_int_scalar(x = args$n_max, x_label = "n_max"),
    label_fallback = function(args)
      validate_chr_scalar(x = args$label_fallback, x_label = "label_fallback"),
    label_width = function(args)
      validate_int_scalar(x = args$label_width, x_label = "label_width")
  )
  
  shared_results <-
    lapply(shared_checks, function(chk) chk(args))
  
  # Column-specific checks
  column_checks <-
    validate_dt_columns(dt = shared_results$data$dt, columns = args$columns)
  
  # Return checked arguments
  list(
    dt = shared_results$data$dt,
    columns = column_checks$columns,
    empty_columns = column_checks$empty_columns,
    n_max = shared_results$n_max$x,
    label_fallback = shared_results$label_fallback$x,
    label_width = shared_results$label_width$x
  )
}


## Helper function to validate 'validate_dict' arguments
validate_dict_args <- function(args) {
  # Check quiet
  verbose_check <- validate_logical(args$quiet, x_label = "quiet")
  is_verbose <- !verbose_check$x
  
  # Shared checks
  shared_checks <- list(
    quiet = function(args)
      validate_logical(x = args$quiet, x_label = "quiet"),
    data = function(args)
      validate_df(
        data = args$data,
        show_msg = is_verbose,
        return_type = "tibble"
      ),
    var_col = function(args)
      validate_col_arg(
        x = args$var_col,
        x_label = "var_col",
        data = args$data,
        show_msg = is_verbose
      ),
    from_col = function(args)
      validate_col_arg(
        x = args$from_col,
        x_label = "from_col",
        data = args$data,
        show_msg = is_verbose
      ),
    to_col = function(args)
      validate_col_arg(
        x = args$to_col,
        x_label = "to_col",
        data = args$data,
        show_msg = is_verbose
      ),
    remove_na = function(args)
      validate_logical(x = args$remove_na, x_label = "remove_na"),
    remove_empty = function(args)
      validate_logical(x = args$remove_empty, x_label = "remove_empty"),
    min_rows = function(args)
      validate_int_scalar(x = args$min_rows, x_label = "min_rows"),
    is_verbose = function(args)
      is_verbose
  )
  
  shared_results <- lapply(shared_checks, function(chk) chk(args))
  
  # Validate each unique category in 'var_col' meets the
  # minimum row threshold.
  validate_rows_per_variable(
    data = shared_results$data$data,
    column = shared_results$var_col$x,
    n_rows = shared_results$min_rows$x,
    is_verbose = shared_results$is_verbose
  )
  
  # Validate that there is a strict one-to-one relationship
  # between 'from_col' and 'to_col' values for every unique
  # category in 'var_col'
  validate_dict_val_lens(
    data = shared_results$data$data,
    var_col = shared_results$var_col$x,
    from_col = shared_results$from_col$x,
    to_col = shared_results$to_col$x,
    remove_na = shared_results$remove_na$x,
    remove_empty = shared_results$remove_empty$x,
    is_verbose = shared_results$is_verbose
  )
  
  # Return validated data
  list(data = shared_results$data$data)
}


## Helper function to validate 'expand_delim_dict' arguments
check_expand_dict_args <- function(args) {
  # Shared checks
  shared_checks <- list(
    data = function(args)
      validate_df(
        data = args$data,
        return_type = "dt",
        show_msg = FALSE
      ),
    var_col = function(args)
      validate_col_arg(
        x = args$var_col,
        x_label = "var_col",
        data = args$data,
        show_msg = FALSE
      ),
    from_col = function(args)
      validate_col_arg(
        x = args$from_col,
        x_label = "from_col",
        data = args$data,
        show_msg = FALSE
      ),
    to_col = function(args)
      validate_col_arg(
        x = args$to_col,
        x_label = "to_col",
        data = args$data,
        show_msg = FALSE
      ),
    from_delim = function(args)
      validate_chr_scalar(x = args$from_delim, x_label = "from_delim"),
    to_delim = function(args)
      validate_chr_scalar(x = args$to_delim, x_label = "to_delim"),
    remove_na = function(args)
      validate_logical(x = args$remove_na, x_label = "remove_na"),
    remove_empty = function(args)
      validate_logical(x = args$remove_empty, x_label = "remove_empty"),
    run_check = function(args)
      validate_logical(x = args$run_check, x_label = "run_check"),
    min_rows = function(args)
      validate_int_scalar(x = args$min_rows, x_label = "min_rows"),
    quiet = function(args)
      validate_logical(x = args$quiet, x_label = "quiet")
  )
  
  shared_results <- lapply(shared_checks, function(chk) chk(args))
  
  # Expand the dictionary
  expanded_tibble <-
    expand_dict(
      dt = shared_results$data$dt,
      var_col = shared_results$var_col$x,
      from_col = shared_results$from_col$x,
      to_col = shared_results$to_col$x,
      from_delim = shared_results$from_delim$x,
      to_delim = shared_results$to_delim$x,
      remove_na = shared_results$remove_na$x,
      remove_empty = shared_results$remove_empty$x
    )
  
  # If 'run_check' is TRUE
  if (shared_results$run_check$x) {
    validated_dict <-
      validate_dict(
        data = expanded_tibble,
        var_col = shared_results$var_col$x,
        from_col = shared_results$from_col$x,
        to_col = shared_results$to_col$x,
        remove_na = shared_results$remove_na$x,
        remove_empty = shared_results$remove_empty$x,
        min_rows = shared_results$min_rows$x,
        quiet = shared_results$quiet$x
      )
    
    # Return expanded data
    return(list(data = validated_dict))
  }
  
  # Return expanded data
  return(list(data = expanded_tibble))
}
