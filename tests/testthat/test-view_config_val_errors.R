test_that("Errors report launch successful", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(
    validate_config(config_path = config_path)
  )
  set.seed(1)
  tbl <- view_config_val_errors(validation)

  # Expect that the `gt_tbl` validation object has all of the
  # usual components and that they have all of the
  # expected dimensions and features
  # Tests adapted from gt package tests:
  # https://github.com/rstudio/gt/blob/master/tests/testthat/test-gt_object.R
  expect_tab(tbl)
  expect_snapshot(tbl$`_source_notes`)
  expect_snapshot(tbl$`_heading`)
  expect_snapshot(str(tbl$`_data`))
  expect_snapshot(tbl$`_styles`)
})

test_that("length 1 paths and related type & enum errors handled correctly", {
  config_path <- testthat::test_path("testdata", "admin-errors2.json")
  # TODO - change branch back to main branch when
  validation <- suppressWarnings(
    validate_config(
      config_path = config_path, config = "admin",
      branch = "main", schema_version = "v1.0.0"
    )
  )
  set.seed(1)
  tbl <- view_config_val_errors(validation)
  expect_snapshot(str(tbl$`_data`))
})

test_that("Data column handled correctly when required property missing", {
  set.seed(1)
  # One nested property missing, one type error
  config_path <- testthat::test_path("testdata", "tasks_required_missing.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))
  expect_snapshot(str(tbl$`_data`))

  # Only a single property missing
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))

  expect_snapshot(str(tbl$`_data`))

  # Two properties missing, only one nested
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only2.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))
  expect_snapshot(str(tbl$`_data`))

  # Two properties missing, both nested
  config_path <- testthat::test_path("testdata", "tasks_required_missing_only2b.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))

  expect_snapshot(str(tbl$`_data`))
})

test_that("Report handles additional property errors successfully", {
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  tbl <- view_config_val_errors(out)

  expect_snapshot(str(tbl$`_data`))
})

# validate_hub_config output ----

test_that("Report works corectly on validate_hub_config output", {
  config_dir <- system.file(
    "testhubs/simple/",
    package = "hubUtils"
  )

  tbl <- suppressMessages(
    view_config_val_errors(
      validate_hub_config(config_dir)
    )
  )
  expect_null(tbl)


  config_dir <- testthat::test_path(
    "testdata", "error_hub"
  )
  tbl <- suppressWarnings(
    view_config_val_errors(
      validate_hub_config(config_dir)
    )
  )

  expect_snapshot(str(tbl$`_data`))
})
