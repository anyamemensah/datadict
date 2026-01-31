# Failure: 'data' argument

    Code
      generate_dict(data = NULL)
    Condition
      Error in `generate_dict()`:
      ! Invalid `data` argument.
      i The `data` argument must be a <data.frame> or <tibble>.

---

    Code
      generate_dict(data = data.frame())
    Condition
      Error in `generate_dict()`:
      ! Invalid `data` argument.
      i The `data` argument must have at least one row and one column.

# Failure: 'n_max', 'label_fallback', 'label_width' arguments

    Code
      generate_dict(data = nlsy, columns = NULL, n_max = "TRUE", label_fallback = NULL,
        label_width = NULL)
    Condition
      Error in `generate_dict()`:
      ! Invalid `n_max` argument.
      x `n_max` must be a single number of length one.
      i Received <character> of length 1.

---

    Code
      generate_dict(data = nlsy, columns = NULL, n_max = 12, label_fallback = 123,
        label_width = NULL)
    Condition
      Error in `generate_dict()`:
      ! Invalid `label_fallback` argument.
      x `label_fallback` must be a character vector of length one.
      i Received <numeric> of length 1.

---

    Code
      generate_dict(data = nlsy, columns = NULL, n_max = 12, label_fallback = "Fallback label",
        label_width = NULL)
    Condition
      Error in `generate_dict()`:
      ! Invalid `label_width` argument.
      x `label_width` must be a single number of length one.
      i Received <NULL> of length 0.

# Failure: All empty columns and columns not found

    Code
      generate_dict(data = test_dict_data1, columns = c("a", "b"))
    Condition
      Error in `generate_dict()`:
      ! No valid columns to process.
      x The specific columns requested in `columns` are either missing from the data or entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

---

    Code
      generate_dict(data = test_dict_data1, columns = c("d", "e"))
    Condition
      Error in `generate_dict()`:
      ! No valid columns to process.
      x The specific columns requested in `columns` are either missing from the data or entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

