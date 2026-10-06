#' Get task ID names for a given round
#'
#' @inheritParams get_round_idx
#' @return a character vector of task ID names
#' @export
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_round_task_id_names(config_tasks, round_id = "2022-10-08")
#' get_round_task_id_names(config_tasks, round_id = "2022-10-15")
get_round_task_id_names <- function(
  config_tasks,
  round_id,
  call = rlang::current_env()
) {
  get_round_model_tasks(config_tasks, round_id, call = call) |>
    mt_task_id_names()
}

mt_task_id_names <- function(model_tasks) {
  purrr::map(model_tasks, ~ names(.x[["task_ids"]])) |>
    unlist() |>
    unique()
}

#' Get output type names for a given round
#'
#' @inheritParams get_round_idx
#' @return a character vector of output type names
#' @export
#' @examples
#' hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_round_output_type_names(config_tasks, round_id = "2022-10-22")
get_round_output_type_names <- function(
  config_tasks,
  round_id,
  call = rlang::current_env()
) {
  get_round_model_tasks(config_tasks, round_id, call = call) |>
    mt_output_type_names()
}

mt_output_type_names <- function(model_tasks) {
  purrr::map(model_tasks, ~ names(.x[["output_type"]])) |>
    unlist() |>
    unique()
}

#' Get the model tasks for a given round
#'
#' @inheritParams get_round_idx
#' @return a list representation of model tasks for a given round.
#' @export
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_round_model_tasks(config_tasks, round_id = "2022-10-08")
#' get_round_model_tasks(config_tasks, round_id = "2022-10-15")
get_round_model_tasks <- function(
  config_tasks,
  round_id,
  call = rlang::current_env()
) {
  get_round_config(config_tasks, round_id, call = call)[["model_tasks"]]
}

#' Get the configuration of a given round
#'
#' @inheritParams get_round_idx
#' @return a list representation of the round's element in the `rounds`
#' property of the tasks config.
#' @export
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- read_config(hub_path, "tasks")
#' get_round_config(config_tasks, round_id = "2022-10-08")
get_round_config <- function(
  config_tasks,
  round_id,
  call = rlang::current_env()
) {
  round_idx <- get_round_idx(config_tasks, round_id, call = call)
  config_tasks[["rounds"]][[round_idx]]
}
