test_that("is_v3_config works", {
  config <- read_config_file(
    system.file("config", "tasks.json", package = "hubUtils")
  )
  expect_true(is_v3_config(config))

  v3_0_1_config <- config
  v3_0_1_config$schema_version <- gsub("v3.0.0", "v3.0.1", config$schema_version)
  expect_true(is_v3_config(v3_0_1_config))

  v2_0_0_config <- config
  v2_0_0_config$schema_version <- gsub("v3.0.0", "v2.0.0", config$schema_version)
  expect_false(is_v3_config(v2_0_0_config))
})

test_that("is_v3_config_file works", {
  config_path <- system.file("config", "tasks.json", package = "hubUtils")
  expect_true(is_v3_config_file(config_path))

  config_path_v3_0_1 <- test_path("testdata", "v3.0.1-tasks.json")
  expect_true(is_v3_config_file(config_path_v3_0_1))

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
