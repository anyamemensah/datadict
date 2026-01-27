##### Helper functions used to validate main function arguments
## Helper function to validate 'generate_dict' arguments
generate_dict_checks <- function(args) {
  # Shared checks
  shared_checks <- list(
    data = function(args)
      check_df(data = args$data),
    n_max = function(args)
      check_integer_scalar(x = args$n_max, x_label = "n_max"),
    label_fallback = function(args)
      check_label_fallback(label_fallback = args$label_fallback),
    label_width = function(args)
      check_integer_scalar(x = args$label_width, x_label = "label_width")
  )
  
  shared_results <- lapply(shared_checks, function(chk) chk(args))
  
  # Column-specific checks
  column_checks <- check_dt_columns(dt = shared_results$data$dt, columns = args$columns)
  
  # Return checked arguments
  list(
    dt = shared_results$data$dt,
    columns = column_checks$columns,
    empty_columns = column_checks$empty_columns,
    n_max = shared_results$n_max$x,
    label_fallback = shared_results$label_fallback$label_fallback,
    label_width = shared_results$label_width$x
  )
}

