

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

  collect_items(..., item_class = "target_metadata_item",
                output_class = "target_metadata",
                flatten = FALSE)
}


check_schema_ids <- function(items, call = rlang::caller_env()) {

    schema_ids <- purrr::map_chr(items,
                                 ~ attr(.x, "schema_id"))

    unique_n <- schema_ids %>%
        unique() %>%
        length()

    if (unique_n > 1L) {

        schema_ids <- paste("Item", seq_along(schema_ids), ":", schema_ids)
        names(schema_ids) <- rep("*", length(schema_ids))

        cli::cli_abort(c(
            "!" = "All items supplied must be created against the same Hub schema.",
          "x" = "{.arg schema_id} attributes are not consistent across all items.",
          "Item {.arg schema_id} attributes:",
          schema_ids
        ), call = call)
    }

    unique(schema_ids)
}


check_item_classes <- function(items, class, call = rlang::caller_env()) {

    is_wrong_class <- purrr::map_lgl(
        items,
        ~ !inherits(.x, class)
    )

    if (any(is_wrong_class)) {
        cli::cli_abort(
            c(
                "!" = "All items supplied must inherit from class {.cls {class}}",
                "x" = "{cli::qty(sum(is_wrong_class))} Item{?s} {.val {which(is_wrong_class)}}
        {cli::qty(sum(is_wrong_class))} do{?es/} not."),
        call = call
        )
    }
}

check_target_metadata_properties_unique <- function(items, property,
                                                    call = rlang::caller_env()) {

    item_properties <- purrr::map_chr(
        items,
        ~ .x[[property]]
    )

    if (any(duplicated(item_properties))) {
        duplicate_idx <- which(duplicated(item_properties))

        cli::cli_abort(c(
            "!" = "{.arg {property}}s must be unique across all
          {.arg target_metadata_item}s.",
          "x" = "{cli::qty(length(duplicate_idx))} {.arg target_metadata_item}{?s}
          {.val {duplicate_idx}} with {.arg {property}} value {.val {item_properties[duplicate_idx]}}
          {cli::qty(length(duplicate_idx))} {?is/are} duplicate{?s}."
        ),
        call = call)
    }
}

