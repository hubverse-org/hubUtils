test_that("read_config works on local hubs", {
  expect_snapshot(
    read_config(
      hub_path = system.file("testhubs", "simple", package = "hubUtils")
    )
  )
  expect_snapshot(
    read_config(
      hub_path = system.file("testhubs", "simple", package = "hubUtils"),
      config = "admin"
    )
  )
  expect_snapshot(
    read_config(
      hub_path = system.file("testhubs", "simple", package = "hubUtils"),
      config = "model-metadata-schema"
    )
  )
})

test_that("read_config works on S3 cloud hubs", {
  skip_if_not(arrow::arrow_with_s3())
  expect_snapshot(
    read_config(
      hub_path = suppressMessages(
        arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
      )
    )
  )
})

test_that("read_config_file works", {
  expect_snapshot(
    read_config_file(
      system.file("config", "tasks.json", package = "hubUtils")
    )
  )
})

test_that("read_config_file outputs warning when can't convert to config class", {
  expect_snapshot(
    read_config_file(test_path("testdata", "empty.json"))
  )
})

test_that("read_config_file warning silencing works", {
  expect_snapshot(
    read_config_file(test_path("testdata", "empty.json"),
      silent = TRUE
    )
  )
})
