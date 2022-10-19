#' Get task id values for a given round
#'
#' @param con a `hub_connection` class object.
#' @param task_id Character string.  A task id name.
#' @param round_id Character string.  A round id name. If rounds vary by a variable in hub,
#'   argument is ignored and can be left `NULL` (default).
#' @param flatten Logical. Whether to flatten required & optional task ids into a single
#'  character vector.
#'
#' @return if `flatten = TRUE` (default), a character vector of task id values.
#'   `flatten = FALSE`, a named list containing character vectors of
#'   `required` and `optional` task id values.
#' @export
#' @family hub-metadata
#' @examples
#' con <- connect_hub(system.file("hub_1", package = "hubUtils"))
#' get_task_id_vals(con, task_id = "location")
#' con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))
#' get_task_id_vals(con, round_id = "round-1", task_id = "location")
#' get_task_id_vals(con, round_id = "round-2", task_id = "age_group")
#' get_task_id_vals(con,
#'   round_id = "round-1", task_id = "location",
#'   flatten = FALSE
#' )
get_task_id_vals <- function(con,
                             task_id,
                             round_id = NULL,
                             flatten = TRUE) {
  checkmate::assert_class(con, "hub_connection")
  checkmate::assert_character(round_id, len = 1, null.ok = TRUE)
  checkmate::assert_character(task_id, len = 1)


  # validate inputs
  round_id <- validate_round_ids(con, round_id)
  # trigger validation error as a single task_id is being evaluated.
  task_id <- validate_task_ids(con,
    task_ids = task_id,
    round_id = round_id, val_type = "error"
  )


  # extract task_id values from connection
  values <- con[[round_id]]$model_tasks[[1]]$task_ids[[task_id]]

  # specifically select `required` and `optional` fields to ensure additional
  # metadata like format or units are excluded.
  out <- values[c("required", "optional")]

  # if distinction between required & optional not important,
  # flatten output into single vector
  if (flatten) {
    out <- out |>
      unlist(use.names = FALSE)
  }

  # if present, add format and units as attributes
  out <- structure(out,
    units = values[["units"]],
    format = values[["format"]]
  )

  return(out)
}

#' Get round ids
#'
#' @inheritParams get_task_id_vals
#' @return a character vector of round ids.
#' @export
#' @family hub-metadata
#' @examples
#' con <- connect_hub(system.file("hub_1", package = "hubUtils"))
#' get_round_ids(con)
#' con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))
#' get_round_ids(con)
get_round_ids <- function(con) {
  checkmate::assert_class(con, "hub_connection")
  attr(con, "round_ids")
}

#' Get task ids for a given round_id
#'
#' @inheritParams get_task_id_vals
#'
#' @return A character vector of task ids.
#' @export
#' @family hub-metadata
#' @examples
#' con <- connect_hub(system.file("hub_1", package = "hubUtils"))
#' get_task_ids(con)
#' con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))
#' get_task_ids(con, round_id = "round-1")
#' get_task_ids(con, round_id = "round-2")
get_task_ids <- function(con, round_id = NULL) {
  checkmate::assert_class(con, "hub_connection")
  checkmate::assert_character(round_id, len = 1, null.ok = TRUE)
  validate_round_ids(con, round_id)

  if (attr(con, "task_ids_by_round")) {
    out <- attr(con, "task_id_names")[[round_id]]
  } else {
    out <- attr(con, "task_id_names")
  }
  out
}
