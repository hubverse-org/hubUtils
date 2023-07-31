#' Coerce data.frame/tibble column data types to hub schema data types.
#'
#' @param tbl a model output data.frame/tibble
#' @inheritParams create_hub_schema
#'
#' @return `tbl` with column data types coerced to hub schema data types.
#' @export
coerce_to_hub_schema <- function(tbl, config_tasks) {
    tbl_schema <- create_hub_schema(
        config_tasks,
        partitions = NULL,
        r_schema = TRUE
    )
    tbl_schema <- tbl_schema[names(tbl)]

    # Coerce data types according to hub schema
    tbl[, ] <- purrr::map2(
        .x = names(tbl_schema),
        .y = tbl_schema,
        ~ get(paste0("as.", .y))(tbl[[.x]])
    )
    tbl
}
