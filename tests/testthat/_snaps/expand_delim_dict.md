# test expand_delim_dict function: failures

    Code
      expand_delim_dict(data = NULL, var_col = "vars", from_col = "from", to_col = "to",
        from_delim = ";", to_delim = ";", remove_na = TRUE, remove_empty = TRUE,
        min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `data` argument.
      i The `data` argument must be a <data.frame> or <tibble>.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "vars", from_col = "from",
        to_col = "to", from_delim = ";", to_delim = ";", remove_na = TRUE,
        remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `var_col` argument.
      i vars is not a column in `data`.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "from", to_col = "to", from_delim = ";", to_delim = ";",
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `from_col` argument.
      i from is not a column in `data`.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "to", from_delim = ";", to_delim = ";",
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `to_col` argument.
      i to is not a column in `data`.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = 1, to_delim = ";",
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `from_delim` argument.
      x `from_delim` must be a character vector of length one.
      i Received <numeric> of length 1.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = ";", to_delim = TRUE,
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `to_delim` argument.
      x `to_delim` must be a character vector of length one.
      i Received <logical> of length 1.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = ";", to_delim = ";",
        remove_na = 1, remove_empty = TRUE, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `remove_na` argument.
      x `remove_na` must be a logical (TRUE/FALSE) of length one.
      i Received <numeric> of length 1.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = ";", to_delim = ";",
        remove_na = TRUE, remove_empty = 1, min_rows = 1L, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `remove_empty` argument.
      x `remove_empty` must be a logical (TRUE/FALSE) of length one.
      i Received <numeric> of length 1.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = ";", to_delim = ";",
        remove_na = TRUE, remove_empty = TRUE, min_rows = TRUE, run_check = TRUE)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `min_rows` argument.
      x `min_rows` must be a number of length one.
      i Received <logical> of length 1.

---

    Code
      expand_delim_dict(data = grad_app_dict_delim, var_col = "column_name",
        from_col = "old_values", to_col = "new_labels", from_delim = ";", to_delim = ";",
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L, run_check = 1)
    Condition
      Error in `expand_delim_dict()`:
      ! Invalid `run_check` argument.
      x `run_check` must be a logical (TRUE/FALSE) of length one.
      i Received <numeric> of length 1.

# test expand_dict function: failures

    Code
      expand_dict(dt = data.table::as.data.table(tbl), var_col = "vars", from_col = "from",
      to_col = "to", from_delim = ";", to_delim = ";", remove_na = TRUE,
      remove_empty = TRUE)
    Condition
      Error in `abort_sus_delim()`:
      x Suspected delimiter mismatch in var_a.
      i It looks like the values weren't split, but the strings contain other separators.
      * Arguments: `from_delim = ;` and `to_delim = ;`.
      * Values detected:
        from: "1,2,3"
        to: "one,two"
      v Confirm if your delimiter arguments match the data.

---

    Code
      expand_dict(data.table::as.data.table(tbl), var_col = "vars", from_col = "from",
      to_col = "to", from_delim = ",", to_delim = ",", remove_na = TRUE,
      remove_empty = TRUE)
    Condition
      Error in `abort_length_mismatch()`:
      x Mismatched from/to lengths detected in var_a.
      i The number of unique from_vals values must match to_vals values.
      * Values detected:
        from: "1", "2", and "3"
        to: "one" and "two"

