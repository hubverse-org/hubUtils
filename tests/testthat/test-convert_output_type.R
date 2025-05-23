test_that("providing a model_output_tbl with no model_id column throws an error", {
  sample_outputs <- create_test_sample_outputs() |>
    dplyr::select(-"model_id")
  expect_error(
    convert_output_type(sample_outputs, to = list("mean" = NA)),
    "Provided `model_output_tbl` must contain the column \"model_id\"",
    fixed = TRUE
  )
})

test_that("providing a model_output_tbl with multiple output types throws an error", {
  mixed_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    model_id = letters[1:4],
    location = "111",
    horizon = 1, # week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("mean", "median"),
    output_type_id = NA,
    value = c(5, 5, 3, 4, 8, 7, 6, 6)
  )
  expect_error(
    convert_output_type(mixed_outputs, to = list("quantile" = 0.5)),
    "Provided `model_out_tbl` may only contain one output type",
    fixed = TRUE
  )
})

test_that("providing a model_out_tbl containing an unsupported output type throws an error", {
  median_outputs <- data.frame(
    stringsAsFactors = FALSE,
    model_id = letters[1:4],
    location = "111",
    horizon = 1, # week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("median"),
    output_type_id = NA,
    value = c(5, 4, 7, 6)
  )
  expect_error(
    convert_output_type(median_outputs, to = list("quantile" = 0.5)),
    "Conversion of `output_type` ",
    fixed = TRUE
  )
})

test_that("requesting an unsupported or invalid conversion throws an error", {
  sample_outputs <- create_test_sample_outputs()
  expect_error(
    convert_output_type(sample_outputs, to = list("cdf" = 0.5)),
    " cannot be converted to",
    fixed = TRUE
  )
})

test_that("providing incompatible output_type_ids throws an error", {
  sample_outputs <- create_test_sample_outputs()
  # mean and median have to NA
  expect_warning(
    convert_output_type(sample_outputs, to = list("mean" = 0.5)),
    "`to` value is incompatible with ",
    fixed = TRUE
  )
  # quantile has numeric to between 0 and 1
  expect_error(
    convert_output_type(
      sample_outputs,
      to = list("mean" = NA, "quantile" = c(0.25, 1.75))
    ),
    "output type IDs should be between 0 and 1.",
    fixed = TRUE
  )
  # quantile has numeric to values
  expect_error(
    convert_output_type(
      sample_outputs,
      to = list("mean" = NA, "quantile" = c("0.25", 0.75))
    ),
    " output type IDs should be numeric",
    fixed = TRUE
  )

  # data frame to contains the required columns
  expect_error(
    convert_output_type(
      sample_outputs,
      to = list("quantile" = data.frame(value = c(0.25, 0.5, 0.75)))
    ),
    "`to` did not contain the required column ",
    fixed = TRUE
  )
  # data frame to includes task IDs not present in
  # the original model output data
  expect_error(
    convert_output_type(
      sample_outputs,
      to = list("quantile" = expand.grid(group = c(1, 2), output_type_id = c(0.33, 0.66)))
    ),
    " element of `to` included ",
    fixed = TRUE
  )
})

test_that("providing output_type_ids with incompatible join columns throws an error", {
  sample_outputs <- create_test_sample_outputs()
  # to has more cases of join column values than model_out_tbl (supported but warn)
  more_levels <- expand.grid(
    location = c("222", "555", "888"),
    output_type_id = c(0.25, 0.75),
    stringsAsFactors = FALSE
  )
  expected_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    KEEP.OUT.ATTRS = FALSE,
    model_id = letters[1:4],
    location = c("222", "888"),
    horizon = 1, # week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = "quantile",
    value = NA_real_
  ) |>
    dplyr::left_join(more_levels, by = "location", relationship = "many-to-many") |>
    dplyr::arrange(model_id) |>
    as_model_out_tbl()
  task_id_cols <- subset_task_id_names(colnames(expected_outputs))
  expected_outputs$value <- create_test_sample_outputs() |>
    dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols)))) |>
    dplyr::reframe(
      output_type_id = c(0.25, 0.75),
      value = stats::quantile(value, probs = c(0.25, 0.75), names = FALSE)
    ) |>
    dplyr::pull(value)

  # function call produces correct warning and output
  expect_warning(
    actual_outputs <- convert_output_type(sample_outputs, to = list("quantile" = more_levels)),
    r"{Some task ID variable combos present in the "quantile" element of `to` are missing from `model_out_tbl`}"
  )
  expect_equal(actual_outputs, expected_outputs)
  # correct missing cases are returned
  expect_equal(
    validate_join_by_cols("quantile", more_levels, sample_outputs, return_missing_combos = TRUE),
    dplyr::filter(more_levels, location == "555")
  )

  # model_out_tbl has more cases of join column values than to (not supported)
  fewer_levels <- data.frame(location = "222", output_type_id = c(0.25, 0.75), stringsAsFactors = FALSE)
  expect_error(
    convert_output_type(sample_outputs, to = list("quantile" = fewer_levels)),
    r"{Some task ID variable combos present in `model_out_tbl` are missing from the "quantile" element of `to`}"
  )
  # correct missing cases are returned
  expect_equal(
    validate_join_by_cols("quantile", fewer_levels, sample_outputs, return_missing_combos = TRUE),
    dplyr::filter(sample_outputs, location != "222")
  )
})

test_that("Simple conversions from samples works", {
  expected_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    KEEP.OUT.ATTRS = FALSE,
    model_id = letters[1:4],
    location = c("222", "888"),
    horizon = 1, # week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = c("mean", "median"),
    output_type_id = NA,
    value = NA_real_
  ) |>
    as_model_out_tbl()
  expected_outputs$value[expected_outputs$output_type == "mean"] <-
    c(110 / 3, 140 / 3, 45, 50, 500 / 3, 325, 1400 / 3, 300)
  expected_outputs$value[expected_outputs$output_type == "median"] <-
    c(40, 40, 45, 50, 150, 325, 500, 300)

  actual_outputs <- create_test_sample_outputs() |>
    convert_output_type(to = list("mean" = NA, "median" = NA)) |>
    dplyr::arrange(output_type, location)
  expect_equal(actual_outputs, expected_outputs)
})

test_that("More complex conversions from samples works", {
  # The set of output type IDs depends on task ID (location) levels
  ps_222 <- c(0.25, 0.5, 0.75)
  ps_888 <- c(0.1, 0.25, 0.5, 0.75, 0.9)
  quantile_levels <- rbind(
    data.frame(
      location = "222",
      output_type_id = ps_222
    ),
    data.frame(
      location = "888",
      output_type_id = ps_888
    )
  )

  expected_outputs <- expand.grid(
    stringsAsFactors = FALSE,
    KEEP.OUT.ATTRS = FALSE,
    model_id = letters[1:4],
    location = c("222", "888"),
    horizon = 1, # week
    target = "inc death",
    target_date = as.Date("2021-12-25"),
    output_type = "quantile",
    value = NA_real_
  ) |>
    dplyr::left_join(quantile_levels, by = "location", relationship = "many-to-many") |>
    as_model_out_tbl()

  task_id_cols <- subset_task_id_names(colnames(expected_outputs))
  expected_outputs$value <- c(
    create_test_sample_outputs() |>
      dplyr::filter(location == "222") |>
      dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols)))) |>
      dplyr::reframe(
        output_type_id = ps_222,
        value = stats::quantile(value, probs = ps_222, names = FALSE)
      ) |>
      dplyr::pull(value),
    create_test_sample_outputs() |>
      dplyr::filter(location == "888") |>
      dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols)))) |>
      dplyr::reframe(
        output_type_id = ps_888,
        value = stats::quantile(value, probs = ps_888, names = FALSE)
      ) |>
      dplyr::pull(value)
  )

  actual_outputs <- create_test_sample_outputs() |>
    convert_output_type(to = list("quantile" = quantile_levels)) |>
    dplyr::arrange(location, model_id)
  expect_equal(actual_outputs, expected_outputs)
})
