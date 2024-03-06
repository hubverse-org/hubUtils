test_that("get_round_task_id_names works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_task_id_names(config_tasks, round_id = "2022-10-01")
  )
  expect_snapshot(
    get_round_task_id_names(config_tasks, round_id = "2022-10-22")
  )
})

test_that("get_round_task_id_names fails correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_task_id_names(
      config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01"
    ),
    error = TRUE
  )
  expect_snapshot(
    get_round_task_id_names(config_tasks,
      round_id = c("2022-10-01", "2022-10-22")
    ),
    error = TRUE
  )
})

test_that("get_round_model_tasks works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_model_tasks(config_tasks, round_id = "2022-10-01")
  )
  expect_snapshot(
    get_round_model_tasks(config_tasks, round_id = "2022-10-22")
  )
})

test_that("get_round_model_tasks fails correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_model_tasks(
      config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01"
    ),
    error = TRUE
  )
  expect_snapshot(
    get_round_model_tasks(config_tasks,
      round_id = c("2022-10-01", "2022-10-22")
    ),
    error = TRUE
  )
})
