# Test generate_dict

test_that("Failure: 'data' argument", {
  expect_snapshot(error = TRUE, {
    generate_dict(data = NULL)
  })
  
  expect_snapshot(error = TRUE, {
    generate_dict(data = data.frame())
  })
})


test_that("Failure: 'n_max', 'label_fallback', 'label_width' arguments", {
  expect_snapshot(error = TRUE, {
    generate_dict(
      data = nlsy,
      columns = NULL,
      n_max = "TRUE",
      label_fallback = NULL,
      label_width = NULL
    )
  })
  
  expect_snapshot(error = TRUE, {
    generate_dict(
      data = nlsy,
      columns = NULL,
      n_max = 12,
      label_fallback = 123,
      label_width = NULL
    )
  })
  
  expect_snapshot(error = TRUE, {
    generate_dict(
      data = nlsy,
      columns = NULL,
      n_max = 12,
      label_fallback = "Fallback label",
      label_width = NULL
    )
  })
})

test_that("Failure: All empty columns and columns not found", {
  set.seed(0222)
  test_dict_data1 <- 
    data.frame(
      a = rep(NA, times = 50),
      b = rep(NA, times = 50),
      c = sample(c("", NA), size = 50, replace = TRUE)
    )
  
  expect_snapshot(error = TRUE, {
    generate_dict(
      data = test_dict_data1,
      columns = c("a","b")
    )
  })
  
  expect_snapshot(error = TRUE, {
    generate_dict(
      data = test_dict_data1,
      columns = c("d","e")
    )
  })
})


test_that("Expected output #1", {
  observed_dict <- generate_dict(data = nlsy, label_fallback = "None provided")
  
  expected_dict <-
    tibble::tibble(
      variable_name = "race",
      variable_label = "None provided",
      variable_type = "character",
      variable_values = c("Black", "Hispanic", "Non-Black,Non-Hispanic", NA),
      value_labels = c("Black", "Hispanic", "Non-Black,Non-Hispanic", "system missing"),
      n_size = c(868L, 631L, 1477L, 0L),
      is_range = FALSE
    )
  
  expect_equal(subset(observed_dict, variable_name == "race"), expected_dict)
})


test_that("Expected output #2", {
  set.seed(8899)
  observed_data <- data.frame(gender = sample(c(1:3, 9), size = 50, replace = TRUE),
                              african_born = sample(c(0:1, NA), size = 50, replace = TRUE))
  observed_data$gender <- labelled::labelled(
    observed_data$gender,
    labels = c(
      woman = 1,
      man = 2,
      `non-binary` = 3,
      "I don't know" = 9
    ),
    label = "Respondent's gender identity"
  )
  observed_data$african_born <- labelled::labelled(
    observed_data$african_born,
    labels = c(yes = 1, no = 0),
    label = "Whether respondent was born on the continent of Africa"
  )
  
  observed_dict <- generate_dict(data = tibble::as_tibble(observed_data))
    
  expected_dict <-
    data.frame(
      variable_name = c(rep("gender", times = 5), rep("african_born", times = 3)),
      variable_label = c(rep("Respondent's gender identity", times = 5), 
                         rep("Whether respondent was born on the continent of Africa", 
                             times = 3)),
      variable_type = "labelled",
      variable_values = as.character(c(1:3, 9, NA, 1,0, NA)),
      value_labels = c("woman", "man", "non-binary", "I don't know", 
                       "system missing","yes", "no", "system missing"),
      n_size = c(16, 15, 10, 9, 0, 21, 12, 17),
      is_range = rep(FALSE, times = 8)
    )
  expected_dict <- tibble::as_tibble(expected_dict)
  
  expect_equal(observed_dict, expected_dict)
})



