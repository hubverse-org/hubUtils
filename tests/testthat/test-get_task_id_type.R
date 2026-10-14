test_that("get_task_id_values returns unique values across all rounds", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  expect_equal(
    get_task_id_values(config_tasks, "origin_date"),
    c("2022-10-01", "2022-10-08", "2022-10-15", "2022-10-22", "2022-10-29")
  )
  # Required values come before optional values and are not repeated across
  # rounds
  expect_equal(get_task_id_values(config_tasks, "horizon"), 1:4)
  expect_equal(
    get_task_id_values(config_tasks, "target"),
    "wk inc flu hosp"
  )
  # A task ID only some rounds use
  expect_equal(
    get_task_id_values(config_tasks, "age_group"),
    c("65+", "0-5", "6-18", "19-24", "25-64")
  )
})

test_that("get_task_id_values can be restricted to a round", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  expect_equal(
    get_task_id_values(config_tasks, "origin_date", round_id = "2022-10-01"),
    c("2022-10-01", "2022-10-08")
  )
  expect_equal(
    get_task_id_values(config_tasks, "origin_date", round_id = "2022-10-29"),
    c("2022-10-15", "2022-10-22", "2022-10-29")
  )
})

test_that("get_task_id_values collects values from every modeling task", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  mt2 <- config_tasks[["rounds"]][[1]][["model_tasks"]][[1]]
  mt2[["task_ids"]][["sex"]] <- list(required = NULL, optional = c("F", "M"))
  mt2[["task_ids"]][["horizon"]] <- list(required = NULL, optional = 5:6)
  config_tasks[["rounds"]][[1]][["model_tasks"]] <- c(
    config_tasks[["rounds"]][[1]][["model_tasks"]],
    list(mt2)
  )
  expect_equal(get_task_id_values(config_tasks, "sex"), c("F", "M"))
  expect_equal(get_task_id_values(config_tasks, "horizon"), 1:6)
})

test_that("get_task_id_values fails correctly", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  expect_snapshot(get_task_id_values(config_tasks), error = TRUE)
  expect_snapshot(get_task_id_values(config_tasks, "random"), error = TRUE)
  expect_snapshot(get_task_id_values(config_tasks, 1L), error = TRUE)
  # task_id_name is checked before round_id
  expect_snapshot(
    get_task_id_values(config_tasks, round_id = "random"),
    error = TRUE
  )
  # A task ID another round uses is not valid for this round
  expect_snapshot(
    get_task_id_values(config_tasks, "age_group", round_id = "2022-10-01"),
    error = TRUE
  )
  expect_snapshot(
    get_task_id_values(config_tasks, "horizon", round_id = "random"),
    error = TRUE
  )
})

test_that("get_task_id_type detects each data type", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  expect_equal(get_task_id_type(config_tasks, "origin_date"), "Date")
  expect_equal(get_task_id_type(config_tasks, "horizon"), "integer")
  expect_equal(get_task_id_type(config_tasks, "location"), "character")
  expect_equal(
    get_task_id_type(config_tasks, "horizon", round_id = "2022-10-01"),
    "integer"
  )

  set_horizon <- function(values) {
    config_tasks[["rounds"]][[1]][["model_tasks"]][[1]][["task_ids"]][[
      "horizon"
    ]] <- list(required = NULL, optional = values)
    config_tasks
  }
  expect_equal(
    get_task_id_type(set_horizon(c(0.5, 1)), "horizon", "2022-10-01"),
    "double"
  )
  expect_equal(
    get_task_id_type(set_horizon(c(TRUE, FALSE)), "horizon", "2022-10-01"),
    "logical"
  )
  # Character values that are not all ISO 8601 dates stay character
  not_iso <- list(
    c("2022-10-01", "wk 2"),
    "2022/10/01",
    "2022-10-01 12:00:00",
    "2022-10-01T12:00:00Z",
    "2022-10-01abc",
    "2022-02-30",
    "22-10-01"
  )
  for (values in not_iso) {
    expect_equal(
      get_task_id_type(set_horizon(values), "horizon", "2022-10-01"),
      "character",
      info = values
    )
  }
  # A mix of types across modeling tasks resolves to the type that holds all
  # values
  expect_equal(
    get_task_id_type(set_horizon(c("1", "2")), "horizon"),
    "character"
  )
})

test_that("get_task_id_type returns NA when a task ID has no values", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  config_tasks[["rounds"]][[1]][["model_tasks"]][[1]][["task_ids"]][[
    "age_group"
  ]] <- list(required = NULL, optional = NULL)

  expect_null(
    get_task_id_values(config_tasks, "age_group", round_id = "2022-10-01")
  )
  expect_identical(
    get_task_id_type(config_tasks, "age_group", round_id = "2022-10-01"),
    NA_character_
  )
  # Values in another round are enough to determine the type
  expect_equal(get_task_id_type(config_tasks, "age_group"), "character")
})

test_that("get_task_id_type reports conditions against `call`", {
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  wrapper <- function(task_id_name, round_id = NULL) {
    get_task_id_type(
      config_tasks,
      task_id_name,
      round_id,
      call = rlang::current_env()
    )
  }
  expect_error_named(
    wrapper(1L),
    "wrapper",
    "`task_id_name` must be a single string, not an integer."
  )
  expect_error_named(
    wrapper(),
    "wrapper",
    "`task_id_name` is absent but must be supplied."
  )
  expect_error_named(
    get_task_id_type("config", "horizon"),
    "get_task_id_type",
    "`config_tasks` must be a list, not a string."
  )
  expect_error_named(
    get_task_id_values(list(), "horizon"),
    "get_task_id_values",
    "`config_tasks` defines no task IDs."
  )
  expect_error_named(
    get_task_id_values(mtcars, "horizon"),
    "get_task_id_values",
    "`config_tasks` must be a list, not a data frame."
  )
  expect_error_named(
    wrapper("horizon", round_id = 1),
    "wrapper",
    "`round_id` must be a single string, not a number."
  )
  expect_error_named(
    get_task_id_type(config_tasks, "random"),
    "get_task_id_type",
    "`task_id_name` must be one of"
  )
})
