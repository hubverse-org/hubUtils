#' Subset a `model_out_tbl` or submission `tbl`.
#'
#' @param model_out_tbl A `model_out_tbl` or submission `tbl` object. Must inherit
#' from class `data.frame`.
#' @return * `subset_task_id_cols`: an object of the same class as `model_out_tbl`
#' which contains only task ID columns.
#' @export
#' @describeIn subset_task_id_cols subset a `model_out_tbl` or submission
#' `tbl` to only include task_id columns
#'
#' @examples
#' model_out_tbl_path <- system.file("testhubs", "v4", "simple",
#'   "model-output", "hub-baseline", "2022-10-15-hub-baseline.parquet",
#'   package = "hubUtils"
#' )
#' model_out_tbl <- arrow::read_parquet(model_out_tbl_path)
#' subset_task_id_cols(model_out_tbl)
#' subset_std_cols(model_out_tbl)
subset_task_id_cols <- function(model_out_tbl) {
  if (!inherits(model_out_tbl, "data.frame")) {
    cli::cli_abort(
      "{.arg model_out_tbl} must inherit from class {.cls data.frame}"
    )
  }
  task_id_cols <- subset_task_id_names(names(model_out_tbl))
  model_out_tbl[, task_id_cols, drop = FALSE]
}
#' @return * `subset_std_cols`: an object of the same class as `model_out_tbl`
#' which contains only hubverse standard columns (i.e. columns that are not
#' task_id columns).
#' @export
#' @describeIn subset_task_id_cols subset a `model_out_tbl` or submission `tbl`
#' to only include hubverse standard columns (i.e. columns that are not task_id
#' columns)
subset_std_cols <- function(model_out_tbl) {
  if (!inherits(model_out_tbl, "data.frame")) {
    cli::cli_abort(
      "{.arg model_out_tbl} must inherit from class {.cls data.frame}"
    )
  }
  std_cols <- intersect(names(model_out_tbl), std_colnames)
  model_out_tbl[, std_cols, drop = FALSE]
}
