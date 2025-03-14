test_that("providing a model_output_tbl with no model_id column throws an error", {
  sample_outputs <- create_test_sample_outputs() |>
    dplyr::select(-"model_id")
  expect_error(
    convert_output_type(sample_outputs, terminal_output_type = "mean", terminal_output_type_id = NA),
    "Provided `model_output_tbl` must contain the column \"model_id\"",
    fixed = TRUE
  )
})

test_that("providing a model_output_tbl with multiple output types throws an error", {
  mixed_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    model_id = letters[1:4],
    location = "111",
    horizon = 1, #week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("mean", "median"),
    output_type_id = NA,
    value = c(5, 5, 3, 4, 8, 7, 6, 6)
  )
  expect_error(
    convert_output_type(mixed_outputs, terminal_output_type = "quantile", terminal_output_type_id = 0.5),
    "Provided `model_output_tbl` may only contain one output type", fixed = TRUE
  )
})

test_that("providing a model_out_tbl containing an unsupported output type throws an error", {
  median_outputs <- data.frame(
    stringsAsFactors = FALSE,
    model_id = letters[1:4],
    location = "111",
    horizon = 1, #week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("median"),
    output_type_id = NA,
    value = c(5, 4, 7, 6)
  )
  expect_error(
    convert_output_type(median_outputs, terminal_output_type = "quantile", terminal_output_type_id = 0.5),
    "Transformation of `output_type` ", fixed = TRUE
  )
})

test_that("requesting an unsupported or invalid transformation throws an error", {
  sample_outputs <- create_test_sample_outputs()
  expect_error(
    convert_output_type(sample_outputs, terminal_output_type = "cdf", terminal_output_type_id = 0.5),
    " cannot be converted to", fixed = TRUE
  )
})

test_that("providing incompatible output_type_ids throws an error", {
  sample_outputs <- create_test_sample_outputs()
  # mean and median have terminal_output_type_id NA
  expect_error(
    convert_output_type(sample_outputs, terminal_output_type = "mean", terminal_output_type_id = 0.5),
    "`terminal_output_type_id` is incompatible with ", fixed = TRUE
  )
  # quantile has numeric terminal_output_type_id between 0 and 1
  expect_error(
    convert_output_type(
      sample_outputs,
      terminal_output_type = c("mean", "quantile"),
      terminal_output_type_id = list(mean = NA, quantile = c(0.25, 1.75))
    ),
    "elements of `terminal_output_type_id` should be between 0 and 1", fixed = TRUE
  )
})

test_that("convert_from_sample works (return quantile)", {
  expected_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    KEEP.OUT.ATTRS = FALSE,
    model_id = letters[1:4],
    location = c("222", "888"),
    horizon = 1, #week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("median"),
    output_type_id = NA,
    value = NA_real_
  ) |>
    as_model_out_tbl()
  expected_outputs$value <- c(40, 40, 45, 50, 150, 325, 500, 300)
  actual_outputs <- create_test_sample_outputs() |>
    convert_output_type(terminal_output_type = "median", terminal_output_type_id = NA) |>
    dplyr::arrange(location)
  expect_equal(actual_outputs, expected_outputs)
})
