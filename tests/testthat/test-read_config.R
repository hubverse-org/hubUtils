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
  skip_if_offline()
  expect_snapshot(
    read_config(
      hub_path = suppressMessages(
        arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
      )
    )
  )
})

test_that("read_config with GitHub urls", {
  skip_if_offline()
  github_hub <- "https://github.com/hubverse-org/example-simple-forecast-hub"
  github_config <- read_config(github_hub)
  expect_s3_class(github_config, "config")
  expect_equal(
    attr(github_config, "schema_id"),
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
  )

  github_config_admin <- read_config(github_hub, config = "admin")
  expect_s3_class(github_config_admin, "config")
  expect_equal(
    attr(github_config_admin, "schema_id"),
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/admin-schema.json"
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
    read_config_file(test_path("testdata", "empty.json"), silent = FALSE)
  )
})

test_that("read_config_file warning silencing works", {
  expect_snapshot(
    read_config_file(test_path("testdata", "empty.json"))
  )
})

test_that("read_config_file with urls works", {
  skip_if_offline()

  # Read from a GitHub url
  config_github <- read_config_file(
    "https://raw.githubusercontent.com/hubverse-org/example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
  )

  skip_if_not(arrow::arrow_with_s3())
  expect_s3_class(config_github, "config")
  expect_equal(
    attr(config_github, "schema_id"),
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
  )

  # Error if not a JSON file
  md_url <-
    "https://raw.githubusercontent.com/hubverse-org/example-simple-forecast-hub/refs/heads/main/README.md"
  expect_error(
    read_config_file(md_url),
    regexp = " is not a JSON file"
  )

  # Read from an S3 bucket config file
  hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
  config_path <- hub_path$path("hub-config/admin.json")
  config_s3 <- suppressMessages(read_config_file(config_path))

  expect_s3_class(config_s3, "config")
  expect_equal(
    attr(config_s3, "schema_id"),
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json"
  )

  # Error if file does not exist
  config_path <- hub_path$path("README.md")
  expect_error(
    read_config_file(config_path),
    regexp = "does not exist"
  )
})
