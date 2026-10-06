test_that("get_derived_task_ids_config returns hub level setting", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_equal(get_derived_task_ids_config(config_tasks), "target_end_date")
  # The round has no round level setting
  expect_equal(
    get_derived_task_ids_config(config_tasks, round_id = "2022-10-22"),
    "target_end_date"
  )

  # Neither the hub nor the round has a setting
  config_tasks <- read_config(
    system.file("testhubs/simple", package = "hubUtils")
  )
  expect_null(get_derived_task_ids_config(config_tasks))
  expect_null(get_derived_task_ids_config(
    config_tasks,
    round_id = "2022-10-01"
  ))
})

test_that("get_derived_task_ids_config returns round level setting", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  config_tasks[["rounds"]][[1]][["derived_task_ids"]] <- "horizon"

  expect_equal(
    get_derived_task_ids_config(config_tasks, round_id = "2022-10-22"),
    "horizon"
  )
  expect_equal(get_derived_task_ids_config(config_tasks), "target_end_date")
})

test_that("get_derived_task_ids_config fails correctly", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_derived_task_ids_config(config_tasks, round_id = "random_round_id"),
    error = TRUE
  )
})

test_that("get_config_derived_task_ids is an alias", {
  expect_identical(get_config_derived_task_ids, get_derived_task_ids_config)
})

test_that("get_derived_task_ids_config reports conditions against `call`", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  wrapper <- function(round_id) {
    get_derived_task_ids_config(
      config_tasks,
      round_id,
      call = rlang::current_env()
    )
  }
  expect_error_named(
    wrapper(round_id = 1),
    "wrapper",
    "`round_id` must be a single string, not a number."
  )
})
