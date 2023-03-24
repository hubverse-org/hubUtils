#' Create a `task_ids` class object.
#'
#' @param ... objects of class `task_id` create using function [`create_task_id()`]
#'
#' @return a named list of class `task_ids`.
#' @export
#'
#' @examples
#' create_task_ids(
#'   create_task_id("origin_date",
#'     required = NULL,
#'     optional = c(
#'       "2023-01-02",
#'       "2023-01-09",
#'       "2023-01-16"
#'     )
#'   ),
#'   create_task_id("scenario_id",
#'     required = NULL,
#'     optional = c(
#'       "A-2021-03-28",
#'       "B-2021-03-28"
#'     )
#'   ),
#'   create_task_id("location",
#'     required = "US",
#'     optional = c("01", "02", "04", "05", "06")
#'   ),
#'   create_task_id("target",
#'     required = "inc hosp",
#'     optional = NULL
#'   ),
#'   create_task_id("horizon",
#'     required = 1L,
#'     optional = 2:4
#'   )
#' )
create_task_ids <- function(...) {
  items <- list(...)

  check_item_classes(items, "task_id")

  schema_id <- check_schema_ids(items)

  items <- purrr::list_flatten(items)
  check_property_names_unique(items)

  structure(list(items),
    class = c("task_ids", "list"),
    names = "task_ids",
    n = length(items),
    schema_id = schema_id
  )
}

check_property_names_unique <- function(x, call = rlang::caller_env()) {
  x_names <- names(x)

  if (any(duplicated(x_names))) {
    duplicate_idx <- which(duplicated(x_names))

    cli::cli_abort(c(
      "!" = "{.arg names} must be unique across all items.",
      "x" = "{cli::qty(length(duplicate_idx))} Item{?s}
          {.val {duplicate_idx}} with {.arg name} {.val {x_names[duplicate_idx]}}
          {cli::qty(length(duplicate_idx))} {?is/are} duplicate{?s}."
    ),
    call = call
    )
  }
}
