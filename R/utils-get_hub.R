#' Get hub configuration fields
#'
#' @inheritParams read_config
#' @inheritParams get_round_idx
#'
#' @return * `get_hub_timezone`: The timezone of the hub
#' @export
#'
#' @examples
#' hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
#' get_hub_timezone(hub_path)
#' get_hub_model_output_dir(hub_path)
#' get_hub_file_formats(hub_path)
#' get_hub_file_formats(hub_path, "2022-12-12")
#' @describeIn get_hub_timezone Get the hub timezone
get_hub_timezone <- function(hub_path) {
  config_admin <- read_config(hub_path, "admin")
  config_admin$timezone
}
#' @return * `get_hub_model_output_dir`: The model output directory name
#' @export
#' @describeIn get_hub_timezone Get the model output directory name
get_hub_model_output_dir <- function(hub_path) {
  config_admin <- read_config(hub_path, "admin")
  model_output_dir <- config_admin$model_output_dir
  if (is.null(model_output_dir)) "model-output" else model_output_dir
}
#' @return * `get_hub_file_formats`: character vector accepted hub or round level
#' file formats. If `round_id` is `NULL` or the round does not have a round level
#' `file_format` setting, returns the hub level `file_format` setting.
#' @export
#' @describeIn get_hub_timezone Get the hub or round level file formats
get_hub_file_formats <- function(hub_path, round_id = NULL) {
  config_admin <- read_config(hub_path, "admin")
  if (is.null(round_id)) {
    return(config_admin$file_format)
  }
  config_tasks <- read_config(hub_path, "tasks")
  round_idx <- get_round_idx(config_tasks, round_id)
  file_formats <- config_tasks[["rounds"]][[round_idx]]$file_format
  if (!is.null(file_formats)) {
    return(file_formats)
  }
  config_admin$file_format
}
#' @return * `get_hub_derived_task_ids`: character vector of hub or round level derived
#' task ID names. If `round_id` is `NULL` or the round does not have a round level
#' `derived_tasks_ids` setting, returns the hub level `derived_tasks_ids` setting.
#' @export
#' @describeIn get_hub_timezone Get the hub or round level `derived_tasks_ids`
get_hub_derived_task_ids <- function(hub_path, round_id = NULL) {
  config_tasks <- read_config(hub_path)
  derived_task_ids_hub <- config_tasks$derived_task_ids
  if (is.null(round_id)) {
    return(derived_task_ids_hub)
  }
  round_idx <- get_round_idx(config_tasks, round_id)
  derived_tasks_ids_round <- config_tasks[["rounds"]][[
    round_idx
  ]]$derived_task_ids
  if (!is.null(derived_tasks_ids_round)) {
    return(derived_tasks_ids_round)
  }
  derived_task_ids_hub
}
