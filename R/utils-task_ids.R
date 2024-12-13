#' Subset a vector of column names to only include task IDs
#'
#' @param x character vector of column names
#'
#' @return a character vector of task ID names
#' @export
#'
#' @examples
#' x <- c(
#'   "origin_date", "horizon", "target_date",
#'   "location", "output_type", "output_type_id", "value"
#' )
#' subset_task_id_names(x)
subset_task_id_names <- function(x) {
  checkmate::assert_character(x)
  setdiff(x, std_colnames)
}
