#' Create an `output_type` class object.
#'
#' @param ... objects of class `output_type_item` created using functions from the
#' `create_output_type_*()` family of functions.
#'
#' @return a named list of class `output_type`.
#' @export
#' @seealso [create_output_type_mean()], [create_output_type_median()],
#' [create_output_type_quantile()], [create_output_type_cdf()],
#' [create_output_type_pmf()], [create_output_type_sample()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#' @examples
#' create_output_type(
#'   create_output_type_mean(
#'     is_required = TRUE,
#'     value_type = "double",
#'     value_minimum = 0L
#'   ),
#'   create_output_type_median(
#'     is_required = FALSE,
#'     value_type = "double"
#'   ),
#'   create_output_type_quantile(
#'     required = c(0.25, 0.5, 0.75),
#'     optional = c(
#'       0.1, 0.2, 0.3, 0.4, 0.6,
#'       0.7, 0.8, 0.9
#'     ),
#'     value_type = "double",
#'     value_minimum = 0
#'   )
#' )
create_output_type <- function(...) {
  collect_items(...,
    item_class = "output_type_item", output_class = "output_type",
    flatten = TRUE
  )
}
