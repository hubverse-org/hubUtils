#' Coerce data.frame/tibble column data types to hub schema data types.
#'
#' @param tbl a model output data.frame/tibble
#' @param skip_date_coercion Logical. Whether to skip coercing dates. This can be faster,
#' especially for larger `tbl`s.
#' @inheritParams create_hub_schema
#'
#' @return `tbl` with column data types coerced to hub schema data types.
#' @export
coerce_to_hub_schema <- function(tbl, config_tasks, skip_date_coercion = FALSE) {
  tbl_schema <- create_hub_schema(
    config_tasks,
    partitions = NULL,
    r_schema = TRUE
  )
  tbl_schema <- tbl_schema[names(tbl)]

  # Coerce data types according to hub schema
  if (skip_date_coercion) {
    tbl[, ] <- purrr::map2(
      .x = names(tbl_schema),
      .y = tbl_schema,
      ~ if (.y == "Date") {
        tbl[[.x]]
      } else {
        get(paste0("as.", .y))(tbl[[.x]])
      }
    )
  } else {
    tbl[, ] <- purrr::map2(
      .x = names(tbl_schema),
      .y = tbl_schema,
      ~ if (.y == "Date") {
        as.Date(tbl[[.x]], format = "%Y-%m-%d")
      } else {
        get(paste0("as.", .y))(tbl[[.x]])
      }
    )
  }
  tbl
}
