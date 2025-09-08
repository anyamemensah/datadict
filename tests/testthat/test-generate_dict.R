# Test generate_dict

test_that("Invalid 'data' argument", {
  expect_error(
    generate_dict(
      data = NULL,
      cols = "sexnow1"
    ),
    "The 'data' argument is not a data frame."
  )
  
  expect_error(
    generate_dict(
      data = data.frame(),
      cols = "sexnow1"
    ),
    "The 'data' argument is empty."
  )
})


test_that("All empty columns", {

  test_dict_data1 <- 
    data.frame(
      a = rep("", times = 50),
      b = rep(NA, times = 50)
      )
  
  expect_error(
    generate_dict(
      data = test_dict_data1,
      cols = c("a", "b")
    ),
    "All selected variables were empty and there are no remaining variables to review."
  )
})


test_that("Expected output", {
  set.seed(8899)
  observed_data <- 
    tibble::tibble(
      gender = sample(c(1:3,9), size = 50, replace = TRUE),
      african_born = sample(c(0:1, NA), size = 50, replace = TRUE)
  ) |>
    dplyr::mutate(
      gender = labelled::labelled(gender, 
                                  labels = c(woman = 1, man = 2, `non-binary` = 3),
                                  label = "Respondent's gender identity"),
      african_born = labelled::labelled(african_born, 
                                  labels = c(yes = 1, no = 0),
                                  label = "Whether respondent was born on the continent of Africa")
    )
   labelled::na_values(observed_data[["gender"]]) <- 9
  
  observed_dict <- generate_dict(data = observed_data)
    
  expected_dict <-
    tibble::tibble(
      column_index = c(rep(1, times = 5), rep(2, times = 3)),
      variable_name = c(rep("gender", times = 5), rep("african_born", times = 3)),
      question_label = c(rep("Respondent's gender identity", times = 5), 
                         rep("Whether respondent was born on the continent of Africa", 
                             times = 3)),
      variable_values = as.character(c(1:3, 9, NA, 0:1, NA)),
      value_labels = c("woman", "man", "non-binary", "na_9", 
                       "system missing", "no", "yes", 
                       "system missing"),
      n_size = c(16, 15, 10, 9, 0, 12, 21, 17),
      is_range = rep(FALSE, times = 8)
    )
  
  
  expect_equal(observed_dict, expected_dict)
})



