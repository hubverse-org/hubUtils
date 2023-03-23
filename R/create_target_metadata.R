

#' Create a `target_metadata` class object.
#'
#' @param ... objects of class `target_metadata_item`
#'
#' @return a named list of class `target_metadata`.
#' @export
#'
#' @examples
#' create_target_metadata(
#'   create_target_metadata_item(
#'     target_id = "inc hosp",
#'     target_name = "Weekly incident influenza hospitalizations",
#'     target_units = "rate per 100,000 population",
#'     target_keys = list(target = "inc hosp"),
#'     target_type = "discrete",
#'     is_step_ahead = TRUE,
#'     time_unit = "week"
#'   ),
#'   create_target_metadata_item(
#'     target_id = "inc death",
#'     target_name = "Weekly incident influenza deaths",
#'     target_units = "rate per 100,000 population",
#'     target_keys = list(target = "inc hosp"),
#'     target_type = "discrete",
#'     is_step_ahead = TRUE,
#'     time_unit = "week"
#'   )
#' )
create_target_metadata <- function(...) {
  items <- list(...)

  is_wrong_class <- purrr::map_lgl(
    items,
    ~ !inherits(.x, "target_metadata_item")
  )

  if (any(is_wrong_class)) {
    cli::cli_abort(
      c(
        "!" = "All items supplied must inherit from class {.cls target_metadata_item}",
        "x" = "{cli::qty(sum(is_wrong_class))} Item{?s} {.val {which(is_wrong_class)}}
        {cli::qty(sum(is_wrong_class))} do{?es/} not."
      )
    )
  }

  target_ids <- purrr::map_chr(
    items,
    ~ .x[["target_id"]]
  )

  if (any(duplicated(target_ids))) {
    duplicate_idx <- which(duplicated(target_ids))

    cli::cli_abort(c(
      "!" = "{.arg target_id}s must be unique across all
          {.arg target_metadata_item}s.",
      "x" = "{cli::qty(length(duplicate_idx))} {.arg target_metadata_item}{?s}
          {.val {duplicate_idx}} with {.arg target_id} value {.val {target_ids[duplicate_idx]}}
          {cli::qty(length(duplicate_idx))} {?is/are} duplicate{?s}."
    ))
  }

  structure(list(items),
    class = c("target_metadata", "list"),
    names = "target_metadata",
    n = length(items)
  )
}
