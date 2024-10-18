test_that("as_config succeeds with valid config", {
  skip_if_offline()
  config_tasks <- read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  # Remove all attributes to ensure we're testing as_config and not as part of
  # read_config
  attributes(config_tasks) <- attributes(config_tasks)[
    names(attributes(config_tasks)) == "names"
  ]
  expect_snapshot(as_config(config_tasks))
})

test_that("as_config modifies outdated URLs", {
  skip_if_offline()
  orig <- config_tasks <- read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  # Remove all attributes to ensure we're testing as_config and not as part of
  # read_config
  attributes(config_tasks) <- attributes(config_tasks)[
    names(attributes(config_tasks)) == "names"
  ]
  attributes(orig) <- attributes(orig)[
    names(attributes(orig)) == "names"
  ]
  config_tasks$schema_version <- sub(
    "hubverse-org",
    "Infectious-Disease-Modeling-Hubs",
    config_tasks$schema_version
  )
  # a message will be issued that the URL is updated
  expect_message(res <- as_config(config_tasks), "superseded URL")
  # the resulting should be equal to the original
  expect_equal(orig$schema_version, res$schema_version)
})

test_that("invalid schema_id flagged", {
  skip_if_offline()
  config_tasks <- read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  # URL prefix incorrect
  config_tasks$schema_version <- "random_schema_id"
  expect_snapshot(as_config(config_tasks), error = TRUE)

  # Version number invalid
  config_tasks$schema_version <- "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0/tasks-schema.json" # nolint: line_length_linter
  expect_error(
    as_config(config_tasks),
    regexp = "is not a valid schema version. Current valid schema version is:"
  )
})

test_that("invalid config_tasks properties flagged", {
  skip_if_offline()
  config_tasks <- read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  config_tasks$random_property <- "random_value"

  expect_snapshot(as_config(config_tasks), error = TRUE)
})


test_that("missing schema_id flagged", {
  skip_if_offline()
  config_tasks <- read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  # URL prefix incorrect
  config_tasks$schema_version <- NULL
  expect_snapshot(as_config(config_tasks), error = TRUE)
})
