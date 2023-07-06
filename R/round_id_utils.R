#' Utilities for accessing round ID metadata
#'
#' @inheritParams expand_model_out_val_grid
#' @export
#' @describeIn get_round_idx Get an integer index of the element in
#' `config_tasks$rounds` that a character round identifier maps to.
#'
#' @examples
#' hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
#' config_tasks <- attr(hub_con, "config_tasks")
#' # Get round IDs
#' get_round_ids(config_tasks)
#' get_round_ids(config_tasks, flatten = FALSE)
# Get round integer index using a round_id
#' get_round_idx(config_tasks, "2022-10-01")
#' get_round_idx(config_tasks, "2022-10-29")
get_round_idx <- function(config_tasks, round_id = NULL) {
  if (is.null(round_id) && length(config_tasks[["rounds"]]) == 1L) {
    1L
  } else {
    round_id <- rlang::arg_match(round_id,
                                 values = get_round_ids(config_tasks)
    )
    get_round_ids(config_tasks, flatten = FALSE) %>%
      purrr::map_lgl(~ round_id %in% .x) %>%
      which()
  }
}

#' @inheritParams expand_model_out_val_grid
#' @param flatten Logical. Whether to flatten output to character vector of
#' round IDs.
#' @describeIn get_round_idx Get a list or character vector of hub round IDs.
#' @export
get_round_ids <- function(config_tasks, flatten = TRUE) {
  round_ids <- purrr::map(
    config_tasks[["rounds"]],
    ~ if (isTRUE(.x[["round_id_from_variable"]])) {
      get_round_ids_from_taskid(.x)
    } else {
      .x[["round_id"]]
    }
  )
  if (flatten) unlist(round_ids) else round_ids
}

get_round_ids_from_taskid <- function(x, flatten = TRUE) {
  round_id_task_id <- x[["round_id"]]
  purrr::map(
    x[["model_tasks"]],
    ~ .x[["task_ids"]][[round_id_task_id]]
  ) %>%
    unlist(use.names = FALSE) %>%
    unique()
}
