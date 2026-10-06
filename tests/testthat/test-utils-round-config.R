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
    get_round_task_id_names(
      config_tasks,
      round_id = c("2022-10-01", "2022-10-22")
    ),
    error = TRUE
  )
})

test_that("get_round_output_type_names works", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_output_type_names(config_tasks, round_id = "2022-10-22")
  )
})

test_that("get_round_output_type_names fails correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_output_type_names(
      config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01"
    ),
    error = TRUE
  )
  expect_snapshot(
    get_round_output_type_names(
      config_tasks,
      round_id = c("2022-10-01", "2022-10-22")
    ),
    error = TRUE
  )
})

test_that("get_round_config works", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_identical(
    get_round_config(config_tasks, round_id = "2022-10-22"),
    config_tasks$rounds[[2]]
  )
})

test_that("get_round_config fails correctly", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_config(
      config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01"
    ),
    error = TRUE
  )
  expect_snapshot(
    get_round_config(
      config_tasks,
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
    get_round_model_tasks(
      config_tasks,
      round_id = c("2022-10-01", "2022-10-22")
    ),
    error = TRUE
  )
})

test_that("round accessors report conditions against `call`", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  wrapper <- function(fn) {
    fn(config_tasks, round_id = 1, call = rlang::current_env())
  }
  accessors <- list(
    get_round_config,
    get_round_model_tasks,
    get_round_task_id_names,
    get_round_output_type_names
  )
  for (fn in accessors) {
    expect_error_named(
      wrapper(fn),
      "wrapper",
      "`round_id` must be a single string, not a number."
    )
  }
})
