test_that("test validate_dict function: failures", {
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = NULL,
      var_col = "vars",
      from_col = "from",
      to_col= "to",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "vars",
      from_col = "from",
      to_col= "to",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "column_name",
      from_col = "from",
      to_col= "to",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "column_name",
      from_col = "old_values",
      to_col= "to",
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "column_name",
      from_col = "old_values",
      to_col= "new_labels", 
      remove_na = "",
      remove_empty = TRUE,
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "column_name",
      from_col = "old_values",
      to_col= "new_labels", 
      remove_na = TRUE,
      remove_empty = "",
      min_rows = 1L)
  })
  
  expect_snapshot(error = TRUE, {
    validate_dict(
      data = grad_app_dict,
      var_col = "column_name",
      from_col = "old_values",
      to_col= "new_labels", 
      remove_na = TRUE,
      remove_empty = TRUE,
      min_rows = "N")
  })
})


test_that("test validate_dict function: pass", {
  observed1 <- validate_dict(
    data = grad_app_dict,
    var_col = "column_name",
    from_col = "old_values",
    to_col = "new_labels",
    remove_na = FALSE,
    remove_empty = FALSE,
    min_rows = 1L
  )
  expected1 <- tibble::as_tibble(
    data.frame(
      column_name = c(
        rep("school_decision", times = 3),
        rep("student_decision", times = 2)
      ),
      column_description = c(
        rep("School decision", times = 3),
        rep("Student response", times = 2)
      ),
      old_values = c("A", "W", "R", "A", "D"),
      new_labels = c(
        "Accepted",
        "Waitlisted",
        "Rejected",
        "Accepted Offer",
        "Declined Offer"
      )
    )
  )
  
  expect_equal(observed1[1:5,], expected1, ignore_attr = TRUE)
})