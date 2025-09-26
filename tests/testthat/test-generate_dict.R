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


test_that("Invalid arguments: max_numeric_display, default_var_label, default_var_label_width, drop_unused_labels", {
  
  expect_error(
    generate_dict(
      data = nlsy,
      cols = NULL,
      max_numeric_display = "TRUE",
      default_var_label = NULL,
      default_var_label_width = NULL,
      drop_unused_labels = TRUE
    ),
    "Invalid 'max_numeric_display' argument. 'max_numeric_display' must be an integer vector of length one."
  )
  
  expect_error(
    generate_dict(
      data = nlsy,
      cols = NULL,
      max_numeric_display = NULL,
      default_var_label = 123,
      default_var_label_width = NULL,
      drop_unused_labels = TRUE
    ),
    "Invalid 'default_var_label' argument. 'default_var_label' must be a character vector of length one."
  )
  
  expect_error(
    generate_dict(
      data = nlsy,
      cols = NULL,
      max_numeric_display = NULL,
      default_var_label = NULL,
      default_var_label_width = "TEN",
      drop_unused_labels = TRUE
    ),
    "Invalid 'default_var_label_width' argument. 'default_var_label_width' must be an integer vector of length one."
  )
  
  expect_error(
    generate_dict(
      data = nlsy,
      cols = NULL,
      max_numeric_display = NULL,
      default_var_label = NULL,
      default_var_label_width = NULL,
      drop_unused_labels = 1234
    ),
    "Invalid 'drop_unused_labels' argument. 'drop_unused_labels' must be a logical vector of length one."
  )
})


test_that("All empty columns and columns not found", {
  
  test_dict_data1 <- 
    data.frame(
      a = rep(NA, times = 50),
      b = rep(NA, times = 50),
      c = sample(c("", NA), size = 50, replace = TRUE)
    )
  
  expect_error(
    generate_dict(
      data = test_dict_data1,
      cols = c("C", "D")
    ),
    "No variable names matching those provided were found in 'data'."
  )
  
  expect_error(
    generate_dict(
      data = test_dict_data1,
      cols = c("a","b")
    ),
    "All selected variables consist entirely of missing values. Please review 'data' and select different variables."
  )
})


test_that("Expected output1", {

  observed_dict <- generate_dict(data = nlsy, default_var_label = "None provided")
  
  expected_dict <-
    tibble::tibble(
      variable_index = 2L,
      variable_name = "race",
      variable_label = "None provided",
      variable_type = "character",
      variable_values = c("Black", "Hispanic", "Non-Black,Non-Hispanic", NA),
      value_labels = c(rep(NA, times = 3), "system missing"),
      n_size = c(868L, 631L, 1477L,0L),
      is_range = FALSE
    )
  
  expect_equal(subset(observed_dict, variable_name == "race"), expected_dict)
})


test_that("Expected output2", {
  set.seed(8899)
  observed_data <- 
    tibble::tibble(
      gender = sample(c(1:3,9), size = 50, replace = TRUE),
      african_born = sample(c(0:1, NA), size = 50, replace = TRUE)
  ) |>
    dplyr::mutate(
      gender = labelled::labelled(gender, 
                                  labels = c(woman = 1, man = 2, `non-binary` = 3, "I don't know" = 9),
                                  label = "Respondent's gender identity"),
      african_born = labelled::labelled(african_born, 
                                  labels = c(yes = 1, no = 0),
                                  label = "Whether respondent was born on the continent of Africa")
    )
  
  observed_dict <- generate_dict(data = observed_data)
    
  expected_dict <-
    tibble::tibble(
      variable_index = c(rep(1, times = 5), rep(2, times = 3)),
      variable_name = c(rep("gender", times = 5), rep("african_born", times = 3)),
      variable_label = c(rep("Respondent's gender identity", times = 5), 
                         rep("Whether respondent was born on the continent of Africa", 
                             times = 3)),
      variable_type = "labelled",
      variable_values = as.character(c(1:3, 9, NA, 0:1, NA)),
      value_labels = c("woman", "man", "non-binary", "I don't know", 
                       "system missing", "no", "yes", 
                       "system missing"),
      n_size = c(16, 15, 10, 9, 0, 12, 21, 17),
      is_range = rep(FALSE, times = 8)
    )
  
  
  expect_equal(observed_dict, expected_dict)
})



