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
  ) %>%
    purrr::map(~ names(.x[[1]][["task_ids"]])) %>%
    unlist() %>%
    unique()
}

