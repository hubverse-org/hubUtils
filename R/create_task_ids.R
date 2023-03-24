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

  collect_items(..., item_class = "task_id", output_class = "task_ids",
                flatten = TRUE)
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


collect_items <- function(...,
                          item_class = c("task_id",
                                              "output_type_item",
                                              "target_metadata_item"),
                          output_class = c("task_ids",
                                           "output_type",
                                           "target_metadata"),
                          flatten = TRUE,
                          call = rlang::caller_env()) {

  item_class <- rlang::arg_match(item_class)
  output_class <- rlang::arg_match(output_class)

  items <- list(...)

  check_item_classes(items, item_class, call = call)

  schema_id <- check_schema_ids(items, call = call)

  if (flatten) {
    items <- purrr::list_flatten(items)
  }
  if (item_class == "target_metadata_item") {
    check_target_metadata_properties_unique(items, property = "target_id",
                                            call = call)
    check_target_metadata_properties_unique(items, property = "target_name",
                                            call = call)
  } else {
    check_property_names_unique(items, call = call)
  }

  structure(list(items),
            class = c(output_class, "list"),
            names = output_class,
            n = length(items),
            schema_id = schema_id
  )
}
