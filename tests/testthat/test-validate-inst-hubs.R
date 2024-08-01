test_that("simple example hub configured correctly", {
  skip_if_not_installed("hubAdmin")
  expect_true(
    all(
      unlist(
        suppressMessages(
          hubAdmin::validate_hub_config(
            hub_path = system.file("testhubs/simple",
              package = "hubUtils"
            )
          )
        )
      )
    )
  )
})

test_that("flusight example hub configured correctly", {
  skip_if_not_installed("hubAdmin")
  expect_true(
    all(
      unlist(
        suppressMessages(
          hubAdmin::validate_hub_config(
            hub_path = system.file("testhubs/flusight",
              package = "hubUtils"
            )
          )
        )
      )
    )
  )
})
