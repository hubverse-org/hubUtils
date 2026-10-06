#' Get hub task IDs
#'
#' @inheritParams get_round_idx
#'
#' @return a character vector of all unique task ID names across all rounds.
#' @export
#'
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_task_id_names(config_tasks)
get_task_id_names <- function(config_tasks) {
  purrr::map(
    config_tasks[["rounds"]],
    ~ .x[["model_tasks"]]
  ) |>
    purrr::map(~ names(.x[[1]][["task_ids"]])) |>
    unlist() |>
    unique()
}

#' Get hub or round level derived task IDs
#'
#' `get_config_derived_task_ids()` is an alias of
#' `get_derived_task_ids_config()`.
#'
#' @inheritParams get_round_idx
#'
#' @return a character vector of hub or round level derived task ID names.
#' If `round_id` is `NULL` or the round does not have a round level
#' `derived_task_ids` setting, returns the hub level `derived_task_ids`
#' setting.
#' @seealso [get_hub_derived_task_ids()] to get derived task IDs from a hub
#' path.
#' @export
#'
#' @examples
#' hub_path <- system.file("testhubs/v4/flusight", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_derived_task_ids_config(config_tasks)
#' get_derived_task_ids_config(config_tasks, round_id = "2023-05-08")
get_derived_task_ids_config <- function(
  config_tasks,
  round_id = NULL,
  call = rlang::current_env()
) {
  derived_task_ids_hub <- config_tasks[["derived_task_ids"]]
  if (is.null(round_id)) {
    return(derived_task_ids_hub)
  }
  round_config <- get_round_config(config_tasks, round_id, call = call)
  round_config[["derived_task_ids"]] %||% derived_task_ids_hub
}

#' @rdname get_derived_task_ids_config
#' @export
get_config_derived_task_ids <- get_derived_task_ids_config
