.onLoad <- function(libname, pkgname) {
  .datadict$env <- NULL
}


utils::globalVariables(c(
  ".SD",
  ".N",
  ".",
  "..check_columns",
  "..select_final_dict_cols",
  "sort_key",
  "var",
  "val",
  "n_size",
  "value_labels"
))

