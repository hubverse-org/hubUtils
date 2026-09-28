test_that("get_round_value_sets_config works", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    str(get_round_value_sets_config(config_tasks, round_id = "2022-10-22"))
  )

  # The v4 flusight hub has required task ID values
  hub_path <- system.file("testhubs/v4/flusight", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(
    str(
      get_round_value_sets_config(
        config_tasks,
        round_id = "2023-05-08",
        required_vals_only = TRUE
      )
    )
  )
})

test_that("get_round_value_sets_config pins round_id", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  value_sets <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-29"
  )
  expect_identical(value_sets[[1]]$task_ids$origin_date, "2022-10-29")
  expect_named(
    value_sets[[1]]$task_ids,
    c("origin_date", "target", "horizon", "location", "age_group")
  )
})

test_that("get_round_value_sets_config keeps round_id task ID values", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  config_tasks$rounds[[1]]$round_id_from_variable <- FALSE
  config_tasks$rounds[[1]]$round_id <- "round-1"

  value_sets <- get_round_value_sets_config(config_tasks, round_id = "round-1")
  expect_identical(
    value_sets[[1]]$task_ids$origin_date,
    unlist(
      config_tasks$rounds[[1]]$model_tasks[[1]]$task_ids$origin_date,
      use.names = FALSE
    )
  )
})

test_that("get_round_value_sets_config sets derived task IDs to NA", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  value_sets <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-22",
    derived_task_ids = "target_end_date"
  )
  expect_identical(
    purrr::map(value_sets, \(x) x$task_ids$target_end_date),
    list(NA, NA, NA)
  )
})

test_that("get_round_value_sets_config sets omitted task IDs to NA", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  config_tasks$rounds[[1]]$model_tasks[[1]]$task_ids$horizon <- NULL

  value_sets <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-22"
  )
  expect_identical(value_sets[[1]]$task_ids$horizon, NA)
  expect_named(
    value_sets[[1]]$task_ids,
    get_round_task_id_names(config_tasks, "2022-10-22")
  )
})

test_that("get_round_value_sets_config subsets and forces output types", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  value_sets <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-22",
    output_types = "mean"
  )
  expect_identical(
    purrr::map(value_sets, "output_type_ids"),
    list(purrr::set_names(list()), purrr::set_names(list()), list(mean = NA))
  )

  # mean is optional, so it has no required values unless forced
  required <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-22",
    required_vals_only = TRUE,
    output_types = "mean"
  )
  expect_length(required[[3]]$output_type_ids, 0L)
  forced <- get_round_value_sets_config(
    config_tasks,
    round_id = "2022-10-22",
    required_vals_only = TRUE,
    force_output_types = TRUE,
    output_types = "mean"
  )
  expect_identical(forced[[3]]$output_type_ids, list(mean = NA))
})

test_that("get_round_value_sets_config fails correctly", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config_tasks <- read_config(hub_path)

  expect_snapshot(
    get_round_value_sets_config(
      config_tasks,
      round_id = "2022-10-22",
      output_types = c("mean", "median")
    ),
    error = TRUE
  )
  expect_snapshot(
    value_sets <- get_round_value_sets_config(
      config_tasks,
      round_id = "2022-10-22",
      derived_task_ids = c("target_end_date", "random_task_id")
    )
  )

  # The v4 flusight hub has required task ID values
  hub_path <- system.file("testhubs/v4/flusight", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  expect_snapshot(
    get_round_value_sets_config(
      config_tasks,
      round_id = "2023-05-08",
      derived_task_ids = "location"
    ),
    error = TRUE
  )
  # A derived task ID left out of the first modeling task is still named
  config_tasks_omitted <- config_tasks
  config_tasks_omitted$rounds[[1]]$model_tasks[[1]]$task_ids$location <- NULL
  expect_snapshot(
    get_round_value_sets_config(
      config_tasks_omitted,
      round_id = "2023-05-08",
      derived_task_ids = "location"
    ),
    error = TRUE
  )
})

test_that("get_round_value_sets_config reports conditions against `call`", {
  hub_path <- system.file("testhubs/v4/flusight", package = "hubUtils")
  config_tasks <- read_config(hub_path)
  wrapper <- function(...) {
    get_round_value_sets_config(
      config_tasks,
      round_id = "2023-05-08",
      ...,
      call = rlang::current_env()
    )
  }
  expect_snapshot(wrapper(output_types = "cdf"), error = TRUE)
  expect_snapshot(wrapper(derived_task_ids = "location"), error = TRUE)
  expect_snapshot(value_sets <- wrapper(derived_task_ids = "random_task_id"))
})
