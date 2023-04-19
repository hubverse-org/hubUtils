test_that("version from file handled successfully", {
  expect_equal(
    get_config_schema_version(
      system.file(
        "testhubs/simple/hub-config/tasks.json",
        package = "hubUtils"
      )
    ),
    "v0.0.1"
  )

  expect_error(
    get_config_schema_version(
      testthat::test_path("testdata", "empty.json")
    )
  )
})


test_that("Schema URL created successfully", {
  schema_url <- get_schema_url("tasks", "v0.0.1")
  expect_true(valid_url(schema_url))
  expect_equal(
    schema_url,
    "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"
  )
})

test_that("Invalid branches fail successfully", {
  expect_error(get_schema_url("tasks", "v0.0.1", branch = "random-branch"),
    regexp = "is not a valid branch in schema repository"
  )
})

test_that("Valid json schema versions detected successfully", {
  expect_equal(
    get_schema_valid_versions(branch = "hubUtils-test"),
    c("v0.0.0.8", "v0.0.0.9")
  )
})


test_that("Config validated successfully", {
  expect_true(suppressMessages(validate_config(
    hub_path = system.file(
      "testhubs/simple/",
      package = "hubUtils"
    ),
    config = "tasks"
  )))
})


test_that("Config errors detected successfully", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_false(out)
})



test_that("Dynamic config errors detected successfully by custom R validation", {
  config_path <- testthat::test_path("testdata", "tasks-errors-rval.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_false(out)
})


test_that("NULL target keys validated successfully", {
  config_path <- testthat::test_path("testdata", "tasks_null_rval.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_true(out)
})
