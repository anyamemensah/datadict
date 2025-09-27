# Test utils functions

test_that("'Empty columns'", {
  set.seed(0721)
  empty_observed <- data.frame(
    col_1 = NA,
    col_2 = sample(c("", NA), size = 500, replace = TRUE),
    col_3  = sample(c(0:2), size = 500, replace = TRUE)) |>
    .is_col_empty()

  empty_expected <- "col_1"

  expect_equal(empty_observed, empty_expected)
})


test_that("Select cols function", {
  set.seed(0803)
  select_observed <- data.frame(
    col_1 = NA,
    col_2 = sample(c("", NA), size = 150, replace = TRUE),
    col_3  = sample(c(0:2), size = 150, replace = TRUE)) |>
    .select_cols()
  
  select_expected <- list(
    selected = c("col_2", "col_3"),
    all_missing = c("col_1")
  )
  
  expect_equal(select_observed, select_expected)
})


test_that("Process variable label function", {
  observed1 <-
    lapply(nursing_work[6:8], attr, which = "label", exact = TRUE) |>
    lapply(.process_var_label, default_label_width = 100L,
           default_label = "None Provided")
  
  expected1 <- list(
    Q5STATE = "State initial RN ed program located",
    Q5COU = "Country initial RN ed program located",
    Q6_0 = "No degree prior to RN ed program"
  )
  
  observed2 <-
    lapply(nlsy[1:5], attr, which = "label", exact = TRUE) |>
    lapply(.process_var_label, default_label_width = 100L,
           default_label = "None Provided")
  
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

test_that("join text function", {
  observed1 <- .join_text(c("a", "b", "c"))
  expected1 <- "a, b, and c"
  
  observed2 <- .join_text(text = c(NA, "a", "b"))
  expected2 <- "a and b"
  
  observed3 <- .join_text(text = "m")
  expected3 <- "m"
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
  expect_equal(observed3, expected3)
})


test_that("Count occurences function", {
  set.seed(1234)
  observed_data_1 <- sample(1:3, size = 50, replace = TRUE)
  observed1 <- .count_occurences(x = observed_data_1, values = c(1,2,3))
  expected1 <- tabulate(factor(observed_data_1))
  
  set.seed(3456)
  observed_data_2 <- sample(letters[1:4], size = 50, replace = TRUE)
  observed2 <- .count_occurences(x = observed_data_2, values = c("a", "b", "c", "d"))
  expected2 <- tabulate(factor(observed_data_2))
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})


test_that("Get variable type function", {
  set.seed(1234)
  observed_data <- 
    data.frame(
      dob = sample(seq(as.Date('1985/01/01'), as.Date('2000/01/01'), by="day"), 5),
      gender = sample(0:2, size = 5, replace = TRUE),
      low_income = sample(c(TRUE, FALSE), size = 5, replace = TRUE),
      low_bthwht = sample(0:1, size = 5, replace = TRUE),
      reading_test = sample(55:100, size = 5, replace = TRUE)
    )
  observed_data$gender <- factor(observed_data$gender, levels = c(0:2), labels = c("woman", "man", "non-binary"))
  observed_data$low_bthwht <- labelled::labelled(observed_data$low_bthwht,
                                                 c("Regular weight" = 0, "Low birth weight" = 1))
  
  observed <- lapply(observed_data, .get_var_type)
  expected <- list(
    dob = "datetime",
    gender = "factor",
    low_income = "logical",
    low_bthwht = "labelled",
    reading_test = "numeric"
  )
  
  expect_equal(observed, expected)
})


