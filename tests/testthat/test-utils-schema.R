test_that("Schema URL created successfully", {
  skip_if_offline()
  schema_url <- get_schema_url("tasks", "v0.0.1")
  expect_true(valid_url(schema_url))
  expect_equal(
    schema_url,
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.1/tasks-schema.json"
  )
})

test_that("Invalid branches fail successfully", {
  skip_if_offline()
  expect_error(
    get_schema_url("tasks", "v0.0.1", branch = "random-branch"),
    regexp = "is not a valid branch in schema repository"
  )
})


test_that("outdated hubUtils will still fetch schema", {
  skip_if_offline()
  url <- "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.3.3/tasks-schema.json"
  # we should attempt to reach github with missing versions (even if they 404)
  expect_error(
    expect_message(get_schema(url), "your version of hubUtils is outdated"),
    "404"
  )
})


test_that("Valid json schema versions detected successfully", {
  skip_if_offline()
  expect_equal(
    get_schema_valid_versions(branch = "hubUtils-test"),
    c("v0.0.0.8", "v0.0.0.9")
  )
})

test_that("get_schema_version_latest works", {
  skip_if_offline()
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
  skip_if_offline()
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
      "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
    ),
    "v3.0.0"
  )
})


test_that("extract_schema_info works", {
  expected <- data.frame(
    branch = c("main", "main", "br-v4.0.0", "multi/slash/path", "main"),
    version = c("v3.0.1", "v2.0.0", "v4.0.0", "v5.0.0", "v6.0.0"),
    config = c(
      "tasks-schema.json",
      "admin-schema.json",
      "tasks-schema.json",
      "tasks-schema.json",
      "target-data-schema.json"
    )
  )
  urls <- c(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json",
    "https://raw.githubusercontent.com/hubverse-org/schemas/br-v4.0.0/v4.0.0/tasks-schema.json",
    "https://raw.githubusercontent.com/hubverse-org/schemas/multi/slash/path/v5.0.0/tasks-schema.json",
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json"
  )
  expect_equal(expected, extract_schema_info(urls))
})


test_that("check extract_schema_version on multidigit versions", {
  expect_equal(
    extract_schema_version(
      "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.11/tasks-schema.json"
    ),
    "v3.0.11"
  )
  expect_equal(
    extract_schema_version(
      "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.20.13.900004/tasks-schema.json"
    ),
    "v3.20.13.900004"
  )
})

test_that("check extract_schema_version on single digit version component", {
  expect_equal(
    extract_schema_version(
      "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json"
    ),
    "v0.0.0.9"
  )
})

test_that("Schema URL for target-data created successfully", {
  schema_url <- get_schema_url("target-data", "v6.0.0")
  expect_equal(
    schema_url,
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json"
  )
})

test_that("get_schema_valid_versions fails gracefully when GitHub API unavailable", {
  local_mocked_bindings(
    gh = function(...) stop("Failed to connect to api.github.com")
  )
  expect_error(
    get_schema_valid_versions(branch = "some-branch"),
    regexp = "Failed to connect to GitHub API"
  )
})
