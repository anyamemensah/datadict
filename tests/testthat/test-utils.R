test_that("check data argument", {
  expect_snapshot(error = TRUE, { check_df(data = NULL) })
  expect_snapshot(error = TRUE, { check_df(data = data.frame()) })
  expect_snapshot(error = TRUE, { check_df(data = data.frame(a = 1:3, a = 3:5, check.names = FALSE)) })
  
  observed1 <- check_df(data = data.frame(a = 1:3, b = letters[1:3]))
  expected1 <- list(valid = TRUE, dt = data.table::as.data.table(x = data.frame(a = 1:3, b = letters[1:3])))

  expect_equal(observed1, expected1)

})

test_that("check columns argument", {
  expect_snapshot(error = TRUE, {
    check_dt_columns(dt = data.table::as.data.table(data.frame(
      a = NA, b = 1:3, c = letters[1:3]
    )),
    columns = c("a", "d"))
  })
  expect_snapshot(error = TRUE, {
    check_dt_columns(dt = data.table::as.data.table(data.frame(a = NA, b = NA)),
    columns = NULL)
  })

  observed1 <- check_dt_columns(dt = data.table::as.data.table(nlsy), columns = NULL)
  expected1 <- list(valid = TRUE, columns = colnames(nlsy), empty_columns = character(0))
  
  observed2 <- check_dt_columns(dt = data.table::as.data.table(gss), columns = c("id", "year", "AGE"))
  expected2 <- list(valid = TRUE, columns = c("id", "year"), empty_columns = character(0))
  
  observed3 <- check_dt_columns(
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

test_that("check integer argument(s)", {
  expect_snapshot(error = TRUE, {check_integer_scalar(x = "A", x_label = "test_label1")})
  expect_snapshot(error = TRUE, {check_integer_scalar(x = NA, x_label = "test_label2")})
  expect_snapshot(error = TRUE, {check_integer_scalar(x = NULL, x_label = "test_label3")})
  
  observed1 <- check_integer_scalar(x = 1, x_label = "pass_label1")
  expected1 <- list(valid = TRUE, x = 1L, x_label = "pass_label1")
  
  observed2 <- check_integer_scalar(x = 5.333, x_label = "pass_label2")
  expected2 <- list(valid = TRUE, x = 5L, x_label = "pass_label2")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("check label fallback", {
  expect_snapshot(error = TRUE, {check_label_fallback(label_fallback = NA)})
  expect_snapshot(error = TRUE, {check_label_fallback(label_fallback = NULL)})

  observed1 <- check_label_fallback(label_fallback = "Label Fallback")
  expected1 <- list(valid = TRUE, label_fallback = "Label Fallback")
  
  observed2 <- check_label_fallback(label_fallback = "This is a label fallback")
  expected2 <- list(valid = TRUE, label_fallback = "This is a label fallback")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("Process variable label function", {
  observed1 <- lapply(nursing_work[6:8], attr, which = "label", exact = TRUE)
  observed1 <- lapply(
    observed1,
    process_var_label,
    default_label_width = 100L,
    default_label = "None Provided"
  )
  
  expected1 <- list(Q5STATE = "State initial RN ed program located",
                    Q5COU = "Country initial RN ed program located",
                    Q6_0 = "No degree prior to RN ed program")
  
  observed2 <- lapply(nlsy[1:5], attr, which = "label", exact = TRUE)
  observed2 <- lapply(
    observed2,
    process_var_label,
    default_label_width = 100L,
    default_label = "None Provided"
  )
  
  expected2 <- list(
    CID = "None Provided",
    race = "None Provided",
    gender = "None Provided",
    birthord = "None Provided",
    magebirth = "None Provided"
  )
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})


test_that("Get variable type function", {
  set.seed(1234)
  observed_data <-
    data.frame(
      dob = sample(seq(
        as.Date('1985/01/01'), as.Date('2000/01/01'), 
        by = "day"), 
        5),
      gender = sample(0:2, size = 5, replace = TRUE),
      low_income = sample(c(TRUE, FALSE), size = 5, replace = TRUE),
      low_bthwht = sample(0:1, size = 5, replace = TRUE),
      reading_test = sample(55:100, size = 5, replace = TRUE)
    )
  observed_data$gender <- factor(
    observed_data$gender,
    levels = c(0:2),
    labels = c("woman", "man", "non-binary")
  )
  observed_data$low_bthwht <- 
    labelled::labelled(
      observed_data$low_bthwht,
      c("Regular weight" = 0, "Low birth weight" = 1)
      )
  
  observed <- lapply(observed_data, get_var_type)
  expected <- list(
    dob = "datetime",
    gender = "factor",
    low_income = "logical",
    low_bthwht = "labelled",
    reading_test = "numeric"
  )
  
  expect_equal(observed, expected)
})
