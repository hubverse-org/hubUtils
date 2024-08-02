#' Utilities for accessing round ID metadata
#'
#' @param config_tasks a list version of the content's of a hub's `tasks.json`
#' config file, accessed through the `"config_tasks"` attribute of a `<hub_connection>`
#' object or function [read_config()].
#' @param round_id Character string. Round identifier. If the round is set to
#' `round_id_from_variable: true`, IDs are values of the task ID defined in the
#' round's `round_id` property of `config_tasks`.
#' Otherwise should match round's `round_id` value in config. Ignored if hub
#' contains only a single round.
#' @return the integer index of the element in `config_tasks$rounds` that a
#' character round identifier maps to
#' @export
#' @describeIn get_round_idx Get an integer index of the element in
#' `config_tasks$rounds` that a character round identifier maps to.
#' @examples
#' if (requireNamespace("hubData", quietly = TRUE)) {
#'   hub_con <- hubData::connect_hub(system.file("testhubs/simple",
#'                                               package = "hubUtils"))
#'   config_tasks <- attr(hub_con, "config_tasks")
#'   # Get round IDs
#'   get_round_ids(config_tasks)
#'   get_round_ids(config_tasks, flatten = "model_task")
#'   get_round_ids(config_tasks, flatten = "task_id")
#'   get_round_ids(config_tasks, flatten = "none")
#'   # Get round integer index using a round_id
#'   get_round_idx(config_tasks, "2022-10-01")
#'   get_round_idx(config_tasks, "2022-10-29")
#' }
get_round_idx <- function(config_tasks, round_id) {
  checkmate::assert_string(round_id)
  round_id <- rlang::arg_match(round_id,
    values = get_round_ids(config_tasks)
  )
  get_round_ids(config_tasks, flatten = "model_task") %>%
    purrr::map_lgl(~ round_id %in% .x) %>%
    which()
}

#' @param flatten Character. Whether and how much to flatten output.
#'  - `"all"`: Complete flattening.
#'  Returns a character vector of unique round IDs across all rounds.
#'  - `"model_task"`: Flatten model tasks.
#'  Returns a list with an element for each round.
#'  Each round element contains a character vector of unique round IDs
#'  across all round model tasks.
#'  Only applicable if `round_id_from_variable` is `TRUE`.
#'  - `"task_id"`: Flatten task ID.
#'  Returns a nested list with an element for each round.
#'  Each round element contains a list with an element for each model task.
#'  Each model task element contains a character vector of unique round IDs.
#'  across `required` and `optional` properties.
#'  Only applicable if `round_id_from_variable` is `TRUE`
#'  - `"none"`: No flattening.
#'  If `round_id_from_variable` is `TRUE`,
#'  returns a nested list with an element for each round.
#'  Each round element contains a nested element for each model task.
#'  Each model task element contains a nested list of `required` and `optional`
#'  character vectors of round IDs.
#'  If `round_id_from_variable` is `FALSE`,a list with a round ID for each round
#'  is returned.
#' @return a list or character vector of hub round IDs
#' - A character vector is returned only if `flatten = "all"`
#' - A list is returned otherwise (see `flatten` for more details)
#' @describeIn get_round_idx Get a list or character vector of hub round IDs.
#' For each round, if `round_id_from_variable` is `TRUE`, round IDs returned are
#' the values of the task ID defined in the `round_id` property. Otherwise, if
#' `round_id_from_variable` is `FALSE`, the value of the `round_id` property is
#' returned.
#' @export
get_round_ids <- function(config_tasks,
                          flatten = c("all", "model_task", "task_id", "none")) {
  checkmate::assert_list(config_tasks)
  flatten <- rlang::arg_match(flatten)

  round_ids <- purrr::map(
    config_tasks[["rounds"]],
    ~ if (isTRUE(.x[["round_id_from_variable"]])) {
      get_round_ids_from_taskid(.x, flatten)
    } else {
      .x[["round_id"]]
    }
  )
  if (flatten == "all") unlist(round_ids, use.names = FALSE) else round_ids
}

get_round_ids_from_taskid <- function(x, flatten) {
  round_id_task_id <- x[["round_id"]]
  out <- purrr::map(
    x[["model_tasks"]],
    function(.x) {
      .x[["task_ids"]][[round_id_task_id]]
    }
  )
  switch(flatten,
    model_task = unique(unlist(out, use.names = FALSE)),
    task_id = purrr::modify(out, ~ unique(unlist(.x, use.names = FALSE))),
    out
  )
}
