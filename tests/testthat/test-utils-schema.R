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

test_that("get_schema_version_latest works", {
  expect_equal(
    get_schema_version_latest(branch = "hubUtils-test"),
    "v0.0.0.9"
  )
  expect_equal(
    get_schema_version_latest(
      branch = "hubUtils-test",
      schema_version = "v0.0.0.8"
    ),
    "v0.0.0.8"
  )
})

test_that("validate_schema_version works", {
  expect_equal(
    validate_schema_version("v0.0.0.9", branch = "hubUtils-test"),
    "v0.0.0.9"
  )
  expect_snapshot(
    validate_schema_version("v0.0.0.7", branch = "hubUtils-test"),
    error = TRUE
  )
})

test_that("extract_schema_version works", {
  expect_equal(
    extract_schema_version(
      "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v3.0.0/tasks-schema.json"
    ), "v3.0.0"
  )
})
