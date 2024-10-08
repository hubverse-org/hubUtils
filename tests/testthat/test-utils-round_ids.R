test_that("get_round_ids works correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(get_round_ids(config_tasks))
  expect_snapshot(get_round_ids(config_tasks, flatten = "model_task"))
  expect_snapshot(get_round_ids(config_tasks, flatten = "task_id"))
  expect_snapshot(get_round_ids(config_tasks, flatten = "none"))
  expect_snapshot(get_round_ids(config_tasks, flatten = "random"), error = TRUE)

  hub_path <- system.file("testhubs/flusight", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(get_round_ids(config_tasks))
  expect_snapshot(get_round_ids(config_tasks, flatten = "model_task"))
  expect_snapshot(get_round_ids(config_tasks, flatten = "task_id"))
  expect_snapshot(get_round_ids(config_tasks, flatten = "none"))
})

test_that("get_round_idx works correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(get_round_idx(config_tasks, "2022-10-01"))
  expect_snapshot(get_round_idx(config_tasks, "2022-10-29"))
  expect_snapshot(get_round_idx(config_tasks), error = TRUE)

  hub_path <- system.file("testhubs/flusight", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(get_round_idx(config_tasks, round_id = "2023-01-02"))
  expect_snapshot(get_round_idx(config_tasks), error = TRUE)
})
