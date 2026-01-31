#### Utility functions for processing and state
# Set environment; for use with cli:: functions
set_call <- function(env = parent.frame()) {
  .datadict$env <- env
  invisible()
}

# Get environment; for use with cli:: functions
get_call <- function() {
  if(!is.null(.datadict$env)) return(.datadict$env)
  sys.call(sys.parent())
}

# Extract unique values
extract_unique <- function(x, remove_na = FALSE, remove_empty = FALSE) {
  x_unique <- unique(x)
  if (remove_na) x_unique <- x_unique[!is.na(x_unique)]
  if (remove_empty) {
    x_unique <- trimws(gsub("\\s+", " ", x_unique))
    x_unique <- x_unique[nzchar(x_unique)]
  }
  x_unique
}

# Extract values
extract_values <- function(x, delim = ",") {
  if (!(is.vector(x) || is.factor(x))) {
    cli::cli_abort("{.arg x} must be a vector or factor.")
  }
  trimws(unlist(strsplit(as.character(x), split = delim)))
}

# Retrieve data type for a column/variable
get_var_type <- function(x) {
  class_x <- class(x)
  if ("haven_labelled" %in% class_x) return("labelled")
  if ("factor" %in% class_x) return("factor")
  if (any(c("POSIXt", "Date", "difftime") %in% class_x)) return("datetime")
  if (any(c("numeric", "integer", "double") %in% class_x)) return("numeric")
  if ("logical" %in% class_x) return("logical")
  "character"
}

# Process column/variable label
process_var_label <- function(var_label, width, default) {
  label <- if (is.null(var_label)) default else var_label
  if (nchar(label) > width) substr(label, start = 1, stop = width) else label
}

# Constant dictionary columns
dict_columns <- c(
  "variable_name", "variable_label", "variable_type",
  "variable_values", "value_labels", "n_size", "is_range"
)
