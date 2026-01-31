# test validate_dict function: failures

    Code
      validate_dict(data = NULL, var_col = "vars", from_col = "from", to_col = "to",
        remove_na = TRUE, remove_empty = TRUE, min_rows = 1L)
    Condition
      Error in `validate_dict()`:
      ! Invalid `data` argument.
      i The `data` argument must be a <data.frame> or <tibble>.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "vars", from_col = "from",
        to_col = "to", remove_na = TRUE, remove_empty = TRUE, min_rows = 1L)
    Message
      v `data` is a valid <data.frame>.
    Condition
      Error in `validate_dict()`:
      ! Invalid `var_col` argument.
      i vars is not a column in `data`.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "column_name", from_col = "from",
        to_col = "to", remove_na = TRUE, remove_empty = TRUE, min_rows = 1L)
    Message
      v `data` is a valid <data.frame>.
      v column_name is a valid column in `data`.
    Condition
      Error in `validate_dict()`:
      ! Invalid `from_col` argument.
      i from is not a column in `data`.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "column_name", from_col = "old_values",
        to_col = "to", remove_na = TRUE, remove_empty = TRUE, min_rows = 1L)
    Message
      v `data` is a valid <data.frame>.
      v column_name is a valid column in `data`.
      v old_values is a valid column in `data`.
    Condition
      Error in `validate_dict()`:
      ! Invalid `to_col` argument.
      i to is not a column in `data`.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "column_name", from_col = "old_values",
        to_col = "new_labels", remove_na = "", remove_empty = TRUE, min_rows = 1L)
    Message
      v `data` is a valid <data.frame>.
      v column_name is a valid column in `data`.
      v old_values is a valid column in `data`.
      v new_labels is a valid column in `data`.
    Condition
      Error in `validate_dict()`:
      ! Invalid `remove_na` argument.
      x `remove_na` must be a logical (TRUE/FALSE) of length one.
      i Received <character> of length 1.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "column_name", from_col = "old_values",
        to_col = "new_labels", remove_na = TRUE, remove_empty = "", min_rows = 1L)
    Message
      v `data` is a valid <data.frame>.
      v column_name is a valid column in `data`.
      v old_values is a valid column in `data`.
      v new_labels is a valid column in `data`.
    Condition
      Error in `validate_dict()`:
      ! Invalid `remove_empty` argument.
      x `remove_empty` must be a logical (TRUE/FALSE) of length one.
      i Received <character> of length 1.

---

    Code
      validate_dict(data = grad_app_dict, var_col = "column_name", from_col = "old_values",
        to_col = "new_labels", remove_na = TRUE, remove_empty = TRUE, min_rows = "N")
    Message
      v `data` is a valid <data.frame>.
      v column_name is a valid column in `data`.
      v old_values is a valid column in `data`.
      v new_labels is a valid column in `data`.
    Condition
      Error in `validate_dict()`:
      ! Invalid `min_rows` argument.
      x `min_rows` must be a number of length one.
      i Received <character> of length 1.

