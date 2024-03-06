test_that("check check_deprecated_schema using config_version works", {
  expect_snapshot(check_deprecated_schema(config_version = "v1.0.0"))
  expect_false(check_deprecated_schema(config_version = "v2.0.0"))
})

test_that("check check_deprecated_schema using config works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config <- read_config(hub_path)
  expect_false(check_deprecated_schema(config = config))
})

test_that("check check_deprecated_schema fails correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config <- read_config(hub_path)
  expect_snapshot(check_deprecated_schema(config), error = TRUE)
  expect_snapshot(
    check_deprecated_schema(c("v1.0.0", "v2.0.0")),
    error = TRUE
  )
})
