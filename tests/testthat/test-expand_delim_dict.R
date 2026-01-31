test_that("test expand_delim_dict function: failures", {
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = NULL,
      var_col = "vars",
      from_col = "from",
      to_col = "to",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "vars",
      from_col = "from",
      to_col = "to",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "from",
      to_col = "to",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "to",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = 1,
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = TRUE,
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = ";",
      remove_na = 1,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = 1,
      min_rows = 1L,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = TRUE,
      run_check = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = 1
    )
  })
})


test_that("test expand_delim_dict function: pass", {
  observed1 <-
    expand_delim_dict(
      data = grad_app_dict_delim,
      var_col = "column_name",
      from_col = "old_values",
      to_col = "new_labels",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L,
      run_check = TRUE
    )
  expected1 <- tibble::as_tibble(data.frame(
    column_name = c(
      rep("school_decision", times = 3),
      rep("student_decision", times = 2),
      "ft_pt"
    ),
    old_values = c("A", "W", "R", "A", "D", "pt"),
    new_labels = c(
      "Accepted",
      "Waitlisted",
      "Rejected",
      "Accepted Offer",
      "Declined Offer",
      "Part-time"
    )
  ))
  
  expect_equal(observed1[1:6, ], expected1, ignore_attr = TRUE)
})

test_that("test expand_dict function: failures", {
  tbl <-
    data.frame(
      vars = c("var_a", "var_b"),
      from = c("1,2,3", "0,1"),
      to = c("one,two", "Yes")
    )
  
  expect_snapshot(error = TRUE, {
    expand_dict(
      dt = data.table::as.data.table(tbl),
      var_col = "vars",
      from_col = "from",
      to_col = "to",
      from_delim = ";",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE
    )
  })
  
  expect_snapshot(error = TRUE, {
    expand_dict(
      data.table::as.data.table(tbl),
      var_col = "vars",
      from_col = "from",
      to_col = "to",
      from_delim = ",",
      to_delim = ",",
      remove_na = TRUE,
      remove_empty = TRUE
    )
  })
})

test_that("test expand_dict function: pass", {
  tbl <-
    data.frame(
      vars = c("var_a", "var_b"),
      from = c("1,2,3", "0,1"),
      to = c("one;two;three", "No;Yes")
    )
  
  observed <- 
    expand_dict(
      dt = data.table::as.data.table(tbl),
      var_col = "vars",
      from_col = "from",
      to_col = "to",
      from_delim = ",",
      to_delim = ";",
      remove_na = TRUE,
      remove_empty = TRUE
    )

  expected <- 
    tibble::as_tibble(
      data.frame(
        vars = c(rep("var_a", times = 3), 
                 rep("var_b", times = 2)),
        from = c(paste(1:3), paste(0:1)),
        to = c("one", "two", "three", "No", "Yes")
      )
    )
  expect_equal(observed, expected, ignore_attr = TRUE)
})
