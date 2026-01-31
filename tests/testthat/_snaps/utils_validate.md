# validate data argument

    Code
      validate_df(data = NULL)
    Condition
      Error in `validate_df()`:
      ! Invalid `data` argument.
      i The `data` argument must be a <data.frame> or <tibble>.

---

    Code
      validate_df(data = data.frame())
    Condition
      Error in `validate_df()`:
      ! Invalid `data` argument.
      i The `data` argument must have at least one row and one column.

---

    Code
      validate_df(data = data.frame(a = 1:3, a = 3:5, check.names = FALSE))
    Condition
      Error in `validate_df()`:
      ! Invalid `data` argument.
      x Column names must be unique.
      i Duplicate column names detected.

# validate columns argument

    Code
      validate_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = 1:3,
      c = letters[1:3])), columns = c("a", "d"))
    Condition
      Error in `validate_dt_columns()`:
      ! No valid columns to process.
      x The specific columns requested in `columns` are either missing from the data or entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

---

    Code
      validate_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = NA)),
      columns = NULL)
    Condition
      Error in `validate_dt_columns()`:
      ! No valid columns to process.
      x Every column in the provided data frame is entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

# validate integer scalar

    Code
      validate_int_scalar(x = "A", x_label = "test_label1")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label1` argument.
      x `test_label1` must be a number of length one.
      i Received <character> of length 1.

---

    Code
      validate_int_scalar(x = NA, x_label = "test_label2")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label2` argument.
      x `test_label2` must be a number of length one.
      i Received <logical> of length 1.

---

    Code
      validate_int_scalar(x = NULL, x_label = "test_label3")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label3` argument.
      x `test_label3` must be a number of length one.
      i Received <NULL> of length 0.

# validate character scalar

    Code
      validate_chr_scalar(x = 12, x_label = "test_label1")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label1` argument.
      x `test_label1` must be a character vector of length one.
      i Received <numeric> of length 1.

---

    Code
      validate_chr_scalar(x = NA, x_label = "test_label2")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label2` argument.
      x `test_label2` must be a character vector of length one.
      i Received <logical> of length 1.

---

    Code
      validate_chr_scalar(x = 1.23, x_label = "test_label3")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label3` argument.
      x `test_label3` must be a character vector of length one.
      i Received <numeric> of length 1.

# validate logical scalar

    Code
      validate_logical(x = 12, x_label = "test_label1")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label1` argument.
      x `test_label1` must be a logical (TRUE/FALSE) of length one.
      i Received <numeric> of length 1.

---

    Code
      validate_logical(x = "a", x_label = "test_label2")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label2` argument.
      x `test_label2` must be a logical (TRUE/FALSE) of length one.
      i Received <character> of length 1.

---

    Code
      validate_logical(x = 1.23, x_label = "test_label3")
    Condition
      Error in `validate_scalar()`:
      ! Invalid `test_label3` argument.
      x `test_label3` must be a logical (TRUE/FALSE) of length one.
      i Received <numeric> of length 1.

# validate column exists in dataset

    Code
      validate_col_arg(x = "test", x_label = "test_arg", data = nlsy, show_msg = FALSE)
    Condition
      Error in `validate_col_arg()`:
      ! Invalid `test_arg` argument.
      i test is not a column in `data`.

# validate one-to-one relationship between from and to values

    Code
      validate_dict_val_lens(data = test_data_fail, var_col = "vars", from_col = "from_val",
        to_col = "to_val", remove_na = TRUE, remove_empty = TRUE, is_verbose = FALSE)
    Condition
      Error in `validate_dict_val_lens()`:
      ! Mismatched from/to lengths detected.
      x The number of unique from_val values must match to_val values.
      i Failing variables: "A"

# validate minimum row counts per category

    Code
      validate_rows_per_variable(data = test_data_fail, column = "vars", n_rows = 2,
        is_verbose = FALSE)
    Condition
      Error in `validate_rows_per_variable()`:
      ! Frequency threshold not met.
      x Each unique value in `vars` must appear at least 2 time(s).
      i The following values have fewer than 2 row(s): "B"

