#' Get task ID names for a given round
#'
#' @inheritParams expand_model_out_val_grid
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
