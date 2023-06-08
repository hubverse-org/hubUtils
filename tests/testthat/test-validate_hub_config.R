test_that("correct hub validates successfully", {
  expect_true(
      validate_hub_config(hub_path = system.file(
      "testhubs/simple/", package = "hubUtils")) %>%
          unlist() %>%
          all() %>%
          suppressMessages()
          )
    expect_true(
        validate_hub_config(config_dir = system.file(
            "testhubs/simple/hub-config",
            package = "hubUtils")) %>%
            unlist() %>%
            all() %>%
            suppressMessages()
    )
})

test_that("Hub with config errors fails validation", {
   val <- validate_hub_config(
        hub_path = testthat::test_path(
            "testdata", "error_hub")) %>%
       suppressWarnings()

    expect_false(all(unlist(val)))

    expect_equal(
        attr(val,"config_dir"),
        "testdata/error_hub/hub-config")

    expect_equal(
        attr(val,"schema_url"),
        "https://github.com/Infectious-Disease-Modeling-Hubs/schemas/tree/main/v0.0.1")

    expect_equal(
        attr(val,"schema_version"),
        "v0.0.1")
})
