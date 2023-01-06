test_that("version from file handled successfully", {
  expect_equal(
    get_config_schema_version(
      system.file(
        "testhubs/simple/hub-config/tasks.json",
        package = "hubUtils"
      )
    ),
    "v0.0.0.9"
  )

  expect_error(
    get_config_schema_version(
      testthat::test_path("testdata", "empty.json")
    )
  )
})


test_that("Schema URL created successfully", {
  schema_url <- get_schema_url("tasks", "v0.0.0.9")
  expect_true(valid_url(schema_url))
  expect_equal(
    schema_url,
    "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json"
  )
})

test_that("Valid json schema versions detected successfully", {
  expect_equal(
    get_schema_valid_versions(branch = "hubUtils-test"),
    c("v0.0.0.8", "v0.0.0.9")
  )
})


test_that("Config validated successfully", {
  expect_true(validate_config(
    hub_path =  system.file(
      "testhubs/simple/",
      package = "hubUtils"
    ),
    config = "tasks"))
})


test_that("Config errors detected successfully", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  expect_snapshot(
    validate_config(config_path = config_path, pretty_errors = FALSE)
    )
  expect_false(
    suppressWarnings(
      validate_config(config_path = config_path, pretty_errors = FALSE)
      )
    )
})


test_that("Errors report launch successful", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(validate_config(config_path = config_path))
  set.seed(1)
  skip_on_ci()
  tbl <- launch_pretty_errors_report(validation) %>%
    gt:::render_as_html()
  expect_snapshot(tbl)
})
