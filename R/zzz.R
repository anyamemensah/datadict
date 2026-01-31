.onLoad <- function(libname, pkgname) {
  .datadict$env <- NULL
}


utils::globalVariables(c(
  ".BY",
  "N",
  ".SD",
  ".N",
  ".",
  "..check_columns",
  "..dict_columns",
  "sort_key",
  "var",
  "val",
  "n_size",
  "value_labels"
))

