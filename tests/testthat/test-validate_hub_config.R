test_that("correct hub validates successfully", {
  expect_true(
    validate_hub_config(hub_path = system.file(
      "testhubs/simple/",
      package = "hubUtils"
    )) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )
})

test_that("Hub with config errors fails validation", {
  val <- validate_hub_config(
    hub_path = testthat::test_path(
      "testdata", "error_hub"
    )
  ) %>%
    suppressWarnings()

  expect_false(all(unlist(val)))

  expect_equal(
    attr(val, "config_dir"),
    fs::path("testdata/error_hub/hub-config")
  )

  expect_equal(
    attr(val, "schema_url"),
    "https://github.com/Infectious-Disease-Modeling-Hubs/schemas/tree/main/v2.0.0"
  )

  expect_equal(
    attr(val, "schema_version"),
    "v2.0.0"
  )
})
