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
get_round_task_id_names <- function(config_tasks, round_id) {
  get_round_model_tasks(config_tasks, round_id) %>%
    purrr::map(~ names(.x[["task_ids"]])) %>%
    unlist() %>%
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
get_round_model_tasks <- function(config_tasks, round_id) {
  round_idx <- get_round_idx(
    config_tasks,
    round_id
  )
  purrr::pluck(
    config_tasks,
    "rounds",
    round_idx,
    "model_tasks"
  )
}
