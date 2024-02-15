test_that("simple example hub configured correctly", {
  expect_true(
    all(
      unlist(
        suppressMessages(
          validate_hub_config(
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
  expect_true(
    all(
      unlist(
        suppressMessages(
          validate_hub_config(
            hub_path = system.file("testhubs/flusight",
              package = "hubUtils"
            )
          )
        )
      )
    )
  )
})
