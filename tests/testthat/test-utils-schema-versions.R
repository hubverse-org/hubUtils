test_that("get_version_* utilities works", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  expect_equal(
    get_version_config(config),
    "v3.0.0"
  )

  config_path <- system.file("config", "tasks.json", package = "hubUtils")
  expect_equal(
    get_version_file(config_path),
    "v3.0.0"
  )

  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  expect_equal(
    get_version_hub(hub_path),
    "v2.0.0"
  )
  expect_equal(
    get_version_hub(hub_path, "admin"),
    "v2.0.0"
  )
})

test_that("get_version_config fails when no schema version present", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  config$schema_version <- NULL
  expect_error(
    get_version_config(config),
    regexp = "No .* found in"
  )
})
