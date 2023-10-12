test_that("validate_model_metadata_schema works", {
  expect_true(
    suppressMessages(
      validate_model_metadata_schema(
        hub_path = system.file(
          "testhubs/simple/",
          package = "hubUtils"
        )
      )
    )
  )

  out_error <- suppressWarnings(
    validate_model_metadata_schema(
      hub_path = testthat::test_path(
        "testdata", "error_hub"
      )
    )
  )
  expect_false(out_error)
  expect_snapshot(str(attr(out_error, "errors")))
})
