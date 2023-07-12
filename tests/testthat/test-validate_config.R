test_that("version from file handled successfully", {
  expect_equal(
    get_config_schema_version(
      system.file(
        "testhubs/simple/hub-config/tasks.json",
        package = "hubUtils"
      ),
      config = "tasks"
    ),
    "v0.0.1"
  )

  expect_error(
    get_config_schema_version(
      testthat::test_path("testdata", "empty.json"),
      config = "tasks"
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

test_that("Reserved hub variable task id name detected correctly", {
  config_path <- testthat::test_path("testdata", "tasks-errors-rval-reserved.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_false(out)
})

test_that("NULL target keys validated successfully", {
  config_path <- testthat::test_path("testdata", "tasks_null_rval.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_true(out)
})


test_that("Bad schema_version URL errors successfully", {
  config_path <- testthat::test_path("testdata", "schema_version-errors.json")
  expect_error(validate_config(config_path = config_path))
})


test_that("Additional properties error successfully", {
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_false(out)
})


test_that("Duplicate values in individual array error successfully", {
  config_path <- testthat::test_path("testdata", "dup-in-array.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "v2.0.0",
                                          branch = "br-v2.0.0"))
  expect_snapshot(out)
  expect_false(out)
})

test_that("Duplicate values across property error successfully", {
  config_path <- testthat::test_path("testdata", "dup-in-property.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "v2.0.0",
                                          branch = "br-v2.0.0"))
  expect_snapshot(out)
  expect_false(out)
})

test_that("Inconsistent round ID variables across model tasks error successfully", {
  config_path <- testthat::test_path("testdata", "round-id-inconsistent.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_false(out)

  config_path <- testthat::test_path("testdata", "round-id-inconsistent2.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "v2.0.0",
                                          branch = "br-v2.0.0"))
  expect_snapshot(out)
  expect_false(out)
})


test_that("Duplicate round ID values across rounds error successfully", {
  config_path <- testthat::test_path("testdata", "dup-in-round-id.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "v2.0.0",
                                          branch = "br-v2.0.0"))
  expect_snapshot(out)
  expect_false(out)
})
