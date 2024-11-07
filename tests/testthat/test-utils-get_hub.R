test_that("get_hub_model_output_dir functions work", {
  hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
  expect_equal(get_hub_model_output_dir(hub_path), "forecasts")
  hub_path <- system.file("testhubs/simple", package = "hubValidations")
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
