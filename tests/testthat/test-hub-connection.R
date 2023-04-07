test_that("connect_hub works on simple forecasting hub", {
  # Simple forecasting Hub example ----

  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  hub_con <- connect_hub(hub_path)

  # Tests that paths are assigned to attributes correctly
  expect_equal(
    attr(hub_con, "file_format"),
    "csv"
  )

  # overwrite path attributes to make snapshot portable
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"
  expect_snapshot(str(hub_con))
})


test_that("connect_hub print method works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  hub_con <- connect_hub(hub_path)
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"

  expect_snapshot(hub_con)
  expect_snapshot(print(hub_con, verbose = TRUE))
})



test_that("connect_hub works on model_output_dir", {
  # Simple forecasting Hub example ----

  model_output_dir <- system.file("testhubs/simple/model-output", package = "hubUtils")
  hub_con <- connect_hub(model_output_dir = model_output_dir)

  # Tests that paths are assigned to attributes correctly
  expect_equal(
    attr(hub_con, "file_format"),
    "csv"
  )

  # overwrite path attributes to make snapshot portable
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"
  expect_snapshot(hub_con)
  expect_snapshot(str(hub_con))
})

test_that("connect_hub data extraction works on simple forecasting hub", {
  # Simple forecasting Hub example ----

  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  hub_con <- connect_hub(hub_path)

  suppressMessages(library(dplyr))
  expect_snapshot(hub_con %>%
    dplyr::filter(
      origin_date == "2022-10-08",
      horizon == 2,
      type_id == 0.01
    ) %>%
    dplyr::collect())


  model_output_dir <- system.file("testhubs/simple/model-output", package = "hubUtils")
  model_output_con <- connect_hub(model_output_dir = model_output_dir)
  expect_snapshot(model_output_con %>%
    dplyr::filter(
      origin_date == "2022-10-08",
      horizon == 2,
      type_id == 0.01
    ) %>%
    dplyr::collect())
})
