test_that("validate data argument", {
  expect_snapshot(error = TRUE, { validate_df(data = NULL) })
  expect_snapshot(error = TRUE, { validate_df(data = data.frame()) })
  expect_snapshot(error = TRUE, { validate_df(data = data.frame(a = 1:3, a = 3:5, check.names = FALSE)) })
  
  observed1 <- validate_df(
    data = data.frame(a = 1:3, b = letters[1:3]),
    return_type = "dt",
    show_msg = FALSE
  )
  expected1 <- list(
    valid = TRUE,
    dt = data.table::as.data.table(x = data.frame(a = 1:3, b = letters[1:3])),
    type = "data.table"
  )
  
  expect_equal(observed1, expected1)
  
  
  observed2 <- validate_df(
    data = data.frame(a = 1:3, b = letters[1:3]),
    return_type = "tibble",
    show_msg = FALSE
  )
  expected2 <- list(
    valid = TRUE,
    data = tibble::as_tibble(x = data.frame(a = 1:3, b = letters[1:3])),
    type = "tibble"
  )
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
  
})

test_that("validate columns argument", {
  expect_snapshot(error = TRUE, {
    validate_dt_columns(dt = data.table::as.data.table(data.frame(
      a = NA, b = 1:3, c = letters[1:3]
    )),
    columns = c("a", "d"))
  })
  expect_snapshot(error = TRUE, {
    validate_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = NA)),
                     columns = NULL)
  })
  
  observed1 <- validate_dt_columns(dt = data.table::as.data.table(nlsy), columns = NULL)
  expected1 <- list(valid = TRUE, columns = colnames(nlsy), empty_columns = character(0))
  
  observed2 <- validate_dt_columns(dt = data.table::as.data.table(gss), columns = c("id", "year", "AGE"))
  expected2 <- list(valid = TRUE, columns = c("id", "year"), empty_columns = character(0))
  
  observed3 <- validate_dt_columns(
    dt = data.table::as.data.table(data.frame(
      a = NA, b = 1:3, c = letters[1:3]
    )),
    columns = c("a", "b", "c")
  )
  expected3 <- list(valid = TRUE, columns = c("b", "c"), empty_columns = "a")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
  expect_equal(observed3, expected3)
})

test_that("validate integer scalar", {
  expect_snapshot(error = TRUE, {validate_int_scalar(x = "A", x_label = "test_label1")})
  expect_snapshot(error = TRUE, {validate_int_scalar(x = NA, x_label = "test_label2")})
  expect_snapshot(error = TRUE, {validate_int_scalar(x = NULL, x_label = "test_label3")})
  
  observed1 <- validate_int_scalar(x = 1, x_label = "pass_label1")
  expected1 <- list(valid = TRUE, x = 1L, x_label = "pass_label1")
  
  observed2 <- validate_int_scalar(x = 5.333, x_label = "pass_label2")
  expected2 <- list(valid = TRUE, x = 5L, x_label = "pass_label2")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("validate character scalar", {
  expect_snapshot(error = TRUE, {validate_chr_scalar(x = 12, x_label = "test_label1")})
  expect_snapshot(error = TRUE, {validate_chr_scalar(x = NA, x_label = "test_label2")})
  expect_snapshot(error = TRUE, {validate_chr_scalar(x = 1.23, x_label = "test_label3")})
  
  observed1 <- validate_chr_scalar(x = "one", x_label = "pass_label1")
  expected1 <- list(valid = TRUE, x = "one", x_label = "pass_label1")
  
  observed2 <- validate_chr_scalar(x = "Another label", x_label = "pass_label2")
  expected2 <- list(valid = TRUE, x = "Another label", x_label = "pass_label2")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("validate logical scalar", {
  expect_snapshot(error = TRUE, {validate_logical(x = 12, x_label = "test_label1")})
  expect_snapshot(error = TRUE, {validate_logical(x = "a", x_label = "test_label2")})
  expect_snapshot(error = TRUE, {validate_logical(x = 1.23, x_label = "test_label3")})
  
  observed1 <- validate_logical(x = TRUE, x_label = "pass_label1")
  expected1 <- list(valid = TRUE, x = TRUE, x_label = "pass_label1")
  
  observed2 <- validate_logical(x = FALSE, x_label = "pass_label2")
  expected2 <- list(valid = TRUE, x = FALSE, x_label = "pass_label2")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("validate column exists in dataset", {
  expect_snapshot(error = TRUE, {
    validate_col_arg(
      x = "test",
      x_label = "test_arg",
      data = nlsy,
      show_msg = FALSE
    )
  })
  
  observed1 <- validate_col_arg(x = "race", x_label = "this_arg", data = nlsy, show_msg = FALSE)
  expected1 <- list(valid = TRUE, x = "race", x_label = "this_arg")
  
  expect_equal(observed1, expected1)
})

test_that("validate one-to-one relationship between from and to values", {
  test_data_fail <-
    data.frame(
      vars = c("A", "A", "A"),
      from_val = c(1, 2, NA),
      to_val = c("One", "Two", "Three")
    )
  
  test_data_pass <-
    data.frame(
      vars = c("A", "A", "A", "B", "B"),
      from_val = c(1, 2, 3, 0, 1),
      to_val = c("One", "Two", "Three", "No", "Yes")
    )
  expect_snapshot(error = TRUE, {
    validate_dict_val_lens(
      data = test_data_fail,
      var_col = "vars",
      from_col = "from_val",
      to_col = "to_val",
      remove_na = TRUE,
      remove_empty = TRUE,
      is_verbose = FALSE
    )
  })
  
  observed1 <- validate_dict_val_lens(
    data = test_data_pass,
    var_col = "vars",
    from_col = "from_val",
    to_col = "to_val",
    remove_na = TRUE,
    remove_empty = TRUE, 
    is_verbose = FALSE
  )
  expected1 <- TRUE
  
  expect_equal(observed1, expected1)
})

test_that("validate minimum row counts per category", {
  test_data_fail <-
    data.frame(
      vars = c("A", "A", "A", "B"),
      from_val = c(1, 2, 3, 0),
      to_val = c("One", "Two", "Three", "No")
    )
  
  test_data_pass <-
    data.frame(
      vars = c("A", "A", "A", "B", "B"),
      from_val = c(1, 2, 3, 0, 1),
      to_val = c("One", "Two", "Three", "No", "Yes")
    )
  expect_snapshot(error = TRUE, {
    validate_rows_per_variable(
      data = test_data_fail,
      column = "vars",
      n_rows = 2, 
      is_verbose = FALSE)
  })
  
  observed1 <- validate_rows_per_variable(
    data = test_data_pass,
    column = "vars", 
    n_rows = 2, 
    is_verbose = FALSE
    )
  expected1 <- TRUE
  
  expect_equal(observed1, expected1)
})
