test_that("create_output_type_point functions work correctly", {
  expect_snapshot(
    create_output_type_mean(
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0L
    )
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = FALSE,
      value_type = "integer",
      value_maximum = 0L
    )
  )
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      value_type = "double"
    )
  )
  # Test back-compatibility
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      value_type = "double",
      schema_version = "v1.0.0"
    )
  )
})


test_that("create_output_type_point functions error correctly", {
  expect_snapshot(
    create_output_type_mean(
      is_required = "TRUE",
      value_type = "double"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = TRUE,
      value_type = c("double", "integer")
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = FALSE,
      value_type = "character",
      value_maximum = 0L
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_median(is_required = FALSE),
    error = TRUE
  )
})


test_that("create_output_type_dist functions work correctly", {
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0
    )
  )
  expect_snapshot(
    create_output_type_cdf(
      required = c(10, 20),
      optional = NULL,
      value_type = "double"
    )
  )
  expect_snapshot(
    create_output_type_cdf(
      required = NULL,
      optional = c(
        "EW202240",
        "EW202241",
        "EW202242"
      ),
      value_type = "double"
    )
  )
  expect_snapshot(
    create_output_type_pmf(
      required = NULL,
      optional = c(
        "low", "moderate",
        "high", "extreme"
      ),
      value_type = "double"
    )
  )
  expect_snapshot(
    create_output_type_sample(
      required = 1:10, optional = 11:15,
      value_type = "double"
    )
  )

  # Test back-compatibility
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0,
      schema_version = "v1.0.0"
    )
  )
})


test_that("create_output_type_dist functions error correctly", {
  expect_snapshot(
    create_output_type_cdf(
      required = NULL,
      optional = c(
        "EW202240",
        "EW202241",
        "EW2022423"
      ),
      value_type = "double"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.6, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_sample(
      required = 0:10, optional = 11:15,
      value_type = "double"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_sample(
      required = 1:10, optional = 11:15,
      value_type = "character"
    ),
    error = TRUE
  )
})


test_that("create_output_type_dist functions creates expected warnings", {
  expect_snapshot(
    create_output_type_sample(
      required = 1:50,
      optional = NULL,
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L
    )
  )
})
