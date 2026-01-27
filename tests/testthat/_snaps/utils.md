# check data argument

    Code
      check_df(data = NULL)
    Condition
      Error in `check_df()`:
      ! Invalid `data` argument.
      i The `data` argument must be a <data.frame> or <tibble>.

---

    Code
      check_df(data = data.frame())
    Condition
      Error in `check_df()`:
      ! Invalid `data` argument.
      i The `data` argument must have at least one row and one column.

---

    Code
      check_df(data = data.frame(a = 1:3, a = 3:5, check.names = FALSE))
    Condition
      Error in `check_df()`:
      ! Invalid `data` argument.
      x Column names must be unique.
      i Duplicate column names detected. Please ensure column names are unique before passing the data.

# check columns argument

    Code
      check_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = 1:3, c = letters[
        1:3])), columns = c("a", "d"))
    Condition
      Error in `check_dt_columns()`:
      ! No valid columns to process.
      x The specific columns requested in `columns` are either missing from the data or entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

---

    Code
      check_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = NA)),
      columns = NULL)
    Condition
      Error in `check_dt_columns()`:
      ! No valid columns to process.
      x Every column in the provided data frame is entirely <NA>.
      i The data dictionary requires at least one column with non-missing values to generate metadata.

# check integer argument(s)

    Code
      check_integer_scalar(x = "A", x_label = "test_label1")
    Condition
      Error in `check_integer_scalar()`:
      ! Invalid `test_label1` argument.
      x `test_label1` must be a single number.
      i Received <character> of length 1.

---

    Code
      check_integer_scalar(x = NA, x_label = "test_label2")
    Condition
      Error in `check_integer_scalar()`:
      ! Invalid `test_label2` argument.
      x `test_label2` must be a single number.
      i Received <logical> of length 1.

---

    Code
      check_integer_scalar(x = NULL, x_label = "test_label3")
    Condition
      Error in `check_integer_scalar()`:
      ! Invalid `test_label3` argument.
      x `test_label3` must be a single number.
      i Received <NULL> of length 0.

# check label fallback

    Code
      check_label_fallback(label_fallback = NA)
    Condition
      Error in `check_label_fallback()`:
      ! Invalid `label_fallback` argument
      i `label_fallback` must be a character vector of length one.

---

    Code
      check_label_fallback(label_fallback = NULL)
    Condition
      Error in `check_label_fallback()`:
      ! Invalid `label_fallback` argument
      i `label_fallback` must be a character vector of length one.

