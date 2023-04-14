test_that("connect_hub works on local simple forecasting hub", {
  # Simple forecasting Hub example ----

  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  hub_con <- connect_hub(hub_path)

  # Tests that paths are assigned to attributes correctly
  expect_equal(
    attr(hub_con, "file_format"),
    "csv"
  )
  expect_equal(
    class(attr(hub_con, "file_system")),
    c("LocalFileSystem", "FileSystem", "ArrowObject", "R6")
  )
  expect_equal(
    class(hub_con),
    c("hub_connection", "FileSystemDataset", "Dataset", "ArrowObject",
      "R6")
  )

  # overwrite path attributes to make snapshot portable
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"
  expect_snapshot(str(hub_con))
})

test_that("connect_model_output works on local model_output_dir", {
  # Simple forecasting Hub example ----

  mod_out_path <- system.file("testhubs/simple/model-output", package = "hubUtils")
  mod_out_con <- connect_model_output(mod_out_path)

  # Tests that paths are assigned to attributes correctly
  expect_equal(
    attr(mod_out_con, "file_format"),
    "csv"
  )
  expect_equal(
    class(attr(mod_out_con, "file_system")),
    c("LocalFileSystem", "FileSystem", "ArrowObject", "R6")
  )
  expect_equal(
    class(mod_out_con),
    c("mod_out_connection", "FileSystemDataset", "Dataset", "ArrowObject",
      "R6")
  )
  # overwrite path attributes to make snapshot portable
  attr(mod_out_con, "model_output_dir") <- "test/model_output_dir"
  expect_snapshot(mod_out_con)
  expect_snapshot(str(mod_out_con))
})

test_that("hub_connection print method works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  hub_con <- connect_hub(hub_path)
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"

  expect_snapshot(hub_con)
  expect_snapshot(print(hub_con, verbose = TRUE))
})

test_that("mod_out_connection print method works", {
  mod_out_path <- system.file("testhubs/simple/model-output", package = "hubUtils")
  mod_out_con <- connect_model_output(mod_out_path)
  attr(mod_out_con, "model_output_dir") <- "test/model_output_dir"

  expect_snapshot(mod_out_con)
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
    dplyr::collect() %>%
      str())

  expect_snapshot(hub_con %>%
    dplyr::filter(
      horizon == 2,
      age_group == "65+") %>%
    dplyr::collect() %>%
      str()
  )


  model_output_dir <- system.file("testhubs/simple/model-output", package = "hubUtils")
  model_output_con <- connect_model_output(model_output_dir = model_output_dir)
  expect_snapshot(model_output_con %>%
    dplyr::filter(
      origin_date == "2022-10-08",
      horizon == 2,
      type_id == 0.01
    ) %>%
    dplyr::collect() %>%
      str())
})


test_that("connect_hub works on S3 bucket simple forecasting hub on AWS", {
  # Simple forecasting Hub example ----

  hub_path <- s3_bucket("hubutils/testhubs/simple/")
  hub_con <- connect_hub(hub_path)

  # Tests that paths are assigned to attributes correctly
  expect_equal(
    attr(hub_con, "file_format"),
    "csv"
  )
  expect_equal(
    class(attr(hub_con, "file_system")),
    c("S3FileSystem", "FileSystem", "ArrowObject", "R6")
  )
  expect_equal(
    class(hub_con),
    c("hub_connection", "FileSystemDataset", "Dataset", "ArrowObject",
      "R6")
  )

  # overwrite path attributes to make snapshot portable
  attr(hub_con, "model_output_dir") <- "test/model_output_dir"
  attr(hub_con, "hub_path") <- "test/hub_path"
  expect_snapshot(str(hub_con))

  expect_snapshot(hub_con %>%
                    dplyr::filter(
                      horizon == 2,
                      age_group == "65+") %>%
                    dplyr::collect() %>%
                    str())
})


test_that("connect_hub & connect_model_output fail correctly", {

  expect_snapshot(connect_hub("random/hub/path"), error = TRUE)
  expect_snapshot(connect_model_output("random/model-output/"), error = TRUE)

  temp_dir <- tempdir()
  expect_snapshot(connect_hub(temp_dir), error = TRUE)

  dir.create(fs::path(temp_dir, "hub-config"))
  expect_error(
    connect_hub(temp_dir),
    regexp = "Config file .*admin.* does not exist at path")

  fs::dir_copy(
    system.file("testhubs/simple/hub-config", package = "hubUtils"),
    temp_dir)
  expect_error(
    connect_hub(temp_dir),
    regexp = "Directory .*model-output.* does not exist at path")
})
