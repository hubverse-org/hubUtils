test_that("Errors report launch successful", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(
    validate_config(config_path = config_path)
  )
  set.seed(1)
  tbl <- view_config_val_errors(validation) %>%
    gt::as_raw_html()
  expect_snapshot(tbl)
})


test_that("Data column handled correctly when required property missing", {
  set.seed(1)
  # One nested property missing, one type error
  config_path <- testthat::test_path("testdata", "tasks_required_missing.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  )) %>%
    gt::as_raw_html()
  expect_snapshot(tbl)

  # Only a single property missing
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  )) %>%
    gt::as_raw_html()
  expect_snapshot(tbl)

  # Two properties missing, only one nested
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only2.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  )) %>%
    gt::as_raw_html()
  expect_snapshot(tbl)

  # Two properties missing, both nested
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only2b.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  )) %>%
    gt::as_raw_html()
  expect_snapshot(tbl)
})
