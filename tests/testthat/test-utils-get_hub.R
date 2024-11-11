test_that("get_hub_model_output_dir functions work", {
  hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
  expect_equal(get_hub_model_output_dir(hub_path), "forecasts")
  hub_path <- system.file("testhubs", "simple", package = "hubUtils")
  expect_equal(get_hub_model_output_dir(hub_path), "model-output")
})

test_that("get_hub_timezone functions work", {
  hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
  expect_equal(get_hub_timezone(hub_path), "US/Eastern")
})

test_that("get_hub_file_formats functions work", {
  hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
  expect_equal(get_hub_file_formats(hub_path), c("csv", "parquet", "arrow"))

  expect_equal(
    get_hub_file_formats(hub_path, "2022-12-12"),
    c("csv", "parquet", "arrow")
  )
})

test_that("get_derived_task_ids functions work", {
  expect_equal(
    suppressWarnings(
      get_derived_task_ids(
        hub_path = system.file("testhubs", "v4", "flusight", package = "hubUtils")
      )
    ),
    "target_date"
  )
  expect_null(
    suppressWarnings(
      get_derived_task_ids(
        hub_path = system.file("testhubs", "simple", package = "hubUtils")
      )
    )
  )
})
