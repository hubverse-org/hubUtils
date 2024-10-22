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

test_that("version comparison utilities work on config", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  expect_true(
    version_equal("v3.0.0", config = config)
  )
  expect_false(
    version_equal("v2.0.0", config = config)
  )
  expect_false(
    version_gt("v3.0.0", config = config)
  )
  expect_true(
    version_gte("v3.0.0", config = config)
  )
  expect_true(
    version_lte("v3.0.0", config = config)
  )
  expect_false(
    version_lt("v3.0.0", config = config)
  )
})

test_that("version comparison utilities work on schema_version", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  schema_version <- config$schema_version
  expect_true(
    version_equal("v3.0.0", schema_version = schema_version)
  )
  expect_false(
    version_equal("v2.0.0", schema_version = schema_version)
  )
  expect_false(
    version_gt("v3.0.0", schema_version = schema_version)
  )
  expect_true(
    version_gte("v3.0.0", schema_version = schema_version)
  )
  expect_true(
    version_lte("v3.0.0", schema_version = schema_version)
  )
  expect_false(
    version_lt("v3.0.0", schema_version = schema_version)
  )
})

test_that("version comparison utilities work on config file", {
  config_path <- system.file("config", "tasks.json", package = "hubUtils")
  expect_true(
    version_equal("v3.0.0", config_path = config_path)
  )
  expect_false(
    version_equal("v2.0.0", config_path = config_path)
  )
  expect_false(
    version_gt("v3.0.0", config_path = config_path)
  )
  expect_true(
    version_gte("v3.0.0", config_path = config_path)
  )
  expect_true(
    version_lte("v3.0.0", config_path = config_path)
  )
  expect_false(
    version_lt("v3.0.0", config_path = config_path)
  )
})


test_that("version comparison utilities work on hub", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  expect_false(
    version_equal("v3.0.0", hub_path = hub_path)
  )
  expect_true(
    version_equal("v2.0.0", hub_path = hub_path)
  )
  expect_false(
    version_gt("v2.0.0", hub_path = hub_path)
  )
  expect_true(
    version_gte("v2.0.0", hub_path = hub_path)
  )
  expect_true(
    version_lte("v2.0.0", hub_path = hub_path)
  )
  expect_false(
    version_lt("v2.0.0", hub_path = hub_path)
  )
})

test_that("version comparison utilities fail correctly", {
  config_path <- system.file("config", "tasks.json", package = "hubUtils")
  hub_path <- system.file("testhubs/simple", package = "hubUtils")

  expect_snapshot(version_lt("v2.0.0"), error = TRUE)
  expect_snapshot(version_lt("v2.0.0", config = NULL), error = TRUE)
  expect_snapshot(
    version_lt("v2.0.0",
      hub_path = hub_path,
      config_path = config_path
    ),
    error = TRUE
  )

  expect_snapshot(
    version_lt("x2.0.0", config = config),
    error = TRUE
  )
})

test_that("version comparisons interpret pkg versions correctly", {
  schema_version <- "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.11/tasks-schema.json"
  expect_true(
    version_gt("v3.0.2", schema_version = schema_version)
  )
  expect_true(
    version_gte("v3.0.2", schema_version = schema_version)
  )
  expect_false(
    version_lte("v3.0.2", schema_version = schema_version)
  )
  expect_false(
    version_lt("v3.0.2", schema_version = schema_version)
  )
  expect_false(
    version_equal("v3.0.0", schema_version = schema_version)
  )
  expect_true(
    version_equal("v3.0.11", schema_version = schema_version)
  )
})
