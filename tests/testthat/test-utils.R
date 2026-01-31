test_that("extract unique values", {
  observed1 <- extract_unique(c(1,1,3))
  expected1 <- c(1,3)
  
  observed2 <- extract_unique(c("b", "z","a","b", ""))
  expected2 <- c("b", "z", "a", "")
  
  observed3 <- extract_unique(c("b", "z","a","b", ""), remove_empty = TRUE)
  expected3 <- c("b", "z", "a")
  
  observed4 <- extract_unique(c("b", "", "z","a","b", NA), 
                              remove_na = TRUE, 
                              remove_empty = TRUE)
  expected4 <- c("b", "z", "a")
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
  expect_equal(observed3, expected3)
  expect_equal(observed4, expected4)
})

test_that("extract values (delimited)", {
  observed1 <- extract_values(x = "1,2,3", delim = ",")
  expected1 <- paste(1:3)
  
  observed2 <- extract_values(x = "a;b;c", delim = ";")
  expected2 <- c("a", "b", "c")

  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
})

test_that("get data type", {
  observed1 <- get_var_type(1:3)
  expected1 <- "numeric"
  
  observed2 <- get_var_type(letters[1:3])
  expected2 <- "character"
  
  observed3 <- get_var_type(factor(1:3, levels = 1:3, labels = c("a", "b", "c")))
  expected3 <- "factor"
  
  observed4 <- get_var_type(as.Date(x = "1988-08-03", format = "%Y-%m-%d"))
  expected4 <- "datetime"
  
  observed5 <- get_var_type(TRUE)
  expected5 <- "logical"
  
  observed6 <- get_var_type(gss$sexnow1[1])
  expected6 <- "labelled"
  
  expect_equal(observed1, expected1)
  expect_equal(observed2, expected2)
  expect_equal(observed3, expected3)
  expect_equal(observed4, expected4)
  expect_equal(observed5, expected5)
  expect_equal(observed6, expected6)
  
})

test_that("Process variable label function", {
  observed1 <- lapply(nursing_work[6:8], attr, which = "label", exact = TRUE)
  observed1 <- lapply(observed1,
                      process_var_label,
                      width = 100L,
                      default = "None Provided")
  
  expected1 <- list(Q5STATE = "State initial RN ed program located",
                    Q5COU = "Country initial RN ed program located",
                    Q6_0 = "No degree prior to RN ed program")
  
  observed2 <- lapply(nlsy[1:5], attr, which = "label", exact = TRUE)
  observed2 <- lapply(observed2,
                      process_var_label,
                      width = 100L,
                      default = "None Provided")
  
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

