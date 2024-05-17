test_that("is_v3_config works", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  expect_true(is_v3_config(config))
})
test_that("is_v3_config_file works", {
  config_path <- system.file("config", "tasks.json", package = "hubUtils")
  expect_true(is_v3_config_file(config_path))
})
test_that("is_v3_hub works", {
  expect_false(
    is_v3_hub(hub_path = system.file(
      "testhubs",
      "flusight",
      package = "hubUtils"
    ))
  )
  expect_false(
    is_v3_hub(
      hub_path = system.file(
        "testhubs",
        "flusight",
        package = "hubUtils"
      ),
      config = "admin"
    )
  )
})
