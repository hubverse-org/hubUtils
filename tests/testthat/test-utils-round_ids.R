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
  # flusight rounds have two modeling tasks sharing the round ID task ID (#303)
  expect_identical(anyDuplicated(get_round_ids(config_tasks)), 0L)
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

test_that("get_round_idx reports conditions against `call`", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  wrapper <- function(config_tasks, round_id) {
    get_round_idx(config_tasks, round_id, call = rlang::current_env())
  }
  expect_error_named(
    wrapper(config_tasks, "random_round_id"),
    "wrapper",
    "`round_id` must be one of"
  )
  expect_error_named(
    wrapper(config_tasks, c("2022-10-01", "2022-10-08")),
    "wrapper",
    "`round_id` must be a single string, not a character vector."
  )
  expect_error_named(
    wrapper(config_tasks, 1),
    "wrapper",
    "`round_id` must be a single string, not a number."
  )
  expect_error_named(
    wrapper(config_tasks),
    "wrapper",
    "`round_id` is absent but must be supplied."
  )
  expect_error_named(
    wrapper(c("random", "character", "vector"), "2022-10-01"),
    "wrapper",
    "`config_tasks` must be a list, not a character vector."
  )
})

test_that("get_round_ids rejects a data frame as `config_tasks`", {
  expect_error_named(
    get_round_ids(data.frame(round_id = "2022-10-01")),
    "get_round_ids",
    "`config_tasks` must be a list, not a data frame."
  )
})

test_that("get_round_ids reports conditions against `call`", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  wrapper <- function(config_tasks, flatten = "all") {
    get_round_ids(config_tasks, flatten, call = rlang::current_env())
  }
  expect_error_named(
    wrapper(config_tasks, flatten = "random"),
    "wrapper",
    "`flatten` must be one of"
  )
  expect_error_named(
    wrapper(c("random", "character", "vector")),
    "wrapper",
    "`config_tasks` must be a list, not a character vector."
  )
})
