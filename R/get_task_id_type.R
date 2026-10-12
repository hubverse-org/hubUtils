#' Get the data type of a task ID
#'
#' The data type is the simplest R type that represents every value the task
#' ID takes in the config. Character values that are all ISO 8601 dates
#' (`YYYY-MM-DD`) are reported as `"Date"`.
#'
#' @inheritParams get_task_id_values
#'
#' @return a character string, one of `"character"`, `"double"`, `"integer"`,
#' `"logical"` or `"Date"`. `NA` if the task ID's `required` and `optional`
#' values are both `null` in every modeling task in scope, so the config
#' declares no type for it there.
#' @seealso [get_task_id_values()] for the values the type is derived from.
#' @export
#'
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_task_id_type(config_tasks, "origin_date")
#' get_task_id_type(config_tasks, "horizon")
#' get_task_id_type(config_tasks, "location")
get_task_id_type <- function(
  config_tasks,
  task_id_name,
  round_id = NULL,
  call = rlang::current_env()
) {
  values <- get_task_id_values(
    config_tasks,
    task_id_name,
    round_id = round_id,
    call = call
  )
  if (is.null(values)) {
    return(NA_character_)
  }
  get_data_type(values)
}

#' Get the values a task ID takes
#'
#' Collects the `required` and `optional` values of a task ID from every
#' modeling task in the config, or in one round.
#'
#' @inheritParams get_round_idx
#' @param task_id_name character string. The name of a task ID.
#' @param round_id character string. Round identifier. If `NULL`, the default,
#' values are collected across all rounds.
#'
#' @return a vector of the unique values the task ID takes, with the type the
#' values were read from the config as. Dates are character strings. `NULL`
#' if the task ID's `required` and `optional` values are both `null` in every
#' modeling task in scope.
#' @export
#'
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_task_id_values(config_tasks, "origin_date")
#' get_task_id_values(config_tasks, "origin_date", round_id = "2022-10-01")
#' get_task_id_values(config_tasks, "horizon")
get_task_id_values <- function(
  config_tasks,
  task_id_name,
  round_id = NULL,
  call = rlang::current_env()
) {
  check_config_tasks(config_tasks, call = call)
  check_arg_type(task_id_name, rlang::is_string, "a single string", call = call)
  if (is.null(round_id)) {
    model_tasks <- all_model_tasks(config_tasks)
  } else {
    model_tasks <- get_round_model_tasks(config_tasks, round_id, call = call)
  }
  task_id_names <- mt_task_id_names(model_tasks)
  if (is.null(task_id_names)) {
    cli::cli_abort("{.arg config_tasks} defines no task IDs.", call = call)
  }
  task_id_name <- rlang::arg_match(
    task_id_name,
    values = task_id_names,
    error_call = call
  )
  purrr::map(model_tasks, c("task_ids", task_id_name)) |>
    unlist(use.names = FALSE) |>
    unique()
}

#' Determine the R data type of a vector of config values
#'
#' Character values that are all ISO 8601 dates are reported as `"Date"`.
#' @noRd
get_data_type <- function(x) {
  type <- typeof(x)
  if (type == "character" && test_iso_date(x)) {
    type <- "Date"
  }
  type
}

#' Test whether every value of a character vector is an ISO 8601 date
#'
#' The pattern check is needed because `as.Date()` alone also accepts
#' `YYYY/MM/DD`, and ignores trailing characters, such as the time of a
#' date-time string. The conversion check rejects strings that match the
#' pattern but are not calendar dates, such as `"2022-02-30"`.
#' @noRd
test_iso_date <- function(x) {
  length(x) > 0 &&
    all(grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", x)) &&
    !anyNA(as.Date(x, format = "%Y-%m-%d"))
}
