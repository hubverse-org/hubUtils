#' Merge/Split model output tbl `model_id` column
#'
#' @inheritParams as_model_out_tbl
#' @param sep character string. Character used as separator when concatenating
#' `team_abbr` and `model_abbr` values into a single `model_id` string or splitting
#' `model_id` into component `team_abbr` and `model_abbr`. When splitting, if
#' multiple instances of the separator exist in a `model_id` stringing,
#' splitting occurs occurs on the first instance.
#'
#' @return `tbl` with either `team_abbr` and `model_abbr` merged into a single `model_id`
#' column or `model_id` split into columns `team_abbr` and `model_abbr`.
#' @export
#' @describeIn model_id_merge merge `team_abbr` and `model_abbr` into a single
#' `model_id` column.
#' @examples
#' if (requireNamespace("hubData", quietly = TRUE)) {
#'   hub_con <- hubData::connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
#'   tbl <- hub_con %>%
#'     dplyr::filter(output_type == "quantile", location == "US") %>%
#'     dplyr::collect() %>%
#'     dplyr::filter(forecast_date == max(forecast_date))
#'
#'   tbl_split <- model_id_split(tbl)
#'   tbl_split
#'
#'   # Merge model_id
#'   tbl_merged <- model_id_merge(tbl_split)
#'   tbl_merged
#'
#'   # Split / Merge using custom separator
#'   tbl_sep <- tbl
#'   tbl_sep$model_id <- gsub("-", "_", tbl_sep$model_id)
#'   tbl_sep <- model_id_split(tbl_sep, sep = "_")
#'   tbl_sep
#'   tbl_sep <- model_id_merge(tbl_sep, sep = "_")
#'   tbl_sep
#' }
model_id_merge <- function(tbl, sep = "-") {
  # check all required columns present
  if (!all(c("model_abbr", "team_abbr") %in% names(tbl))) {
    missing_cols <- c("model_abbr", "team_abbr")[ # nolint: object_usage_linter
      !c("model_abbr", "team_abbr") %in% names(tbl)
    ]
    cli::cli_abort(c(
      "x" = "Cannot create {.arg model_id} column.",
      "!" = "Required column{?s} {.val {missing_cols}} missing from {.arg tbl}."
    ))
  }

  # Ensure column model_abbr or team_abbr values do not contain any instances of sep.
  sep_exists_ma <- grepl(sep, tbl$model_abbr, fixed = TRUE)
  sep_exists_ta <- grepl(sep, tbl$team_abbr, fixed = TRUE)
  if (any(c(sep_exists_ma, sep_exists_ta))) {
    cli::cli_abort(c(
      "x" = "{.arg model_abbr} and {.arg team_abbr} values must not contain separator
            character {.val {sep}}.",
      "!" = "Values {.val
            {unique(tbl$model_abbr[sep_exists_ma])}} containing separator
            character detected in {.arg model_abbr} rows {.val {which(sep_exists_ma)}}.",
      "!" = "Values {.val
            {unique(tbl$team_abbr[sep_exists_ta])}} containing separator
            character detected in {.arg team_abbr} rows {.val {which(sep_exists_ta)}}."
    ))
  }
  # create model_id column
  if ("model_id" %in% names(tbl)) {
    cli::cli_alert_warning("Overwritting current {.arg model_id} column.")
  }
  tbl$model_id <- paste(tbl[, "team_abbr", drop = TRUE],
    tbl[, "model_abbr", drop = TRUE],
    sep = sep
  )
  # remove model_abbr team_abbr columns
  tbl[, c("model_abbr", "team_abbr")] <- NULL

  col_order <- names(tbl)[names(tbl) != "model_id"]
  tbl <- tbl[, c("model_id", col_order)]

  return(tbl)
}

#' @return a [tibble][tibble::tibble()] with `model_id` column split into separate
#' `team_abbr` and `model_abbr` columns
#' @export
#' @describeIn model_id_merge split `model_id` column into separate `team_abbr`
#' and `model_abbr` columns.
model_id_split <- function(tbl, sep = "-") {
  # check required column present
  if (!c("model_id") %in% names(tbl)) {
    cli::cli_abort(c(
      "x" = "Cannot split {.arg model_id} column.",
      "!" = "Required column {.val model_id} missing from {.arg tbl}."
    ))
  }
  # create model_abbr team_abbr columns
  if (any(c("model_abbr", "team_abbr") %in% names(tbl))) {
    existing_cols <- c("model_abbr", "team_abbr")[ # nolint: object_usage_linter
      !c("model_abbr", "team_abbr") %in% names(tbl)
    ]
    cli::cli_alert_warning("Overwritting current {.val {existing_cols}} column{?s}.")
  }

  # Ensure column model_id values do not contain more than one instance of sep.
  n_sep_gt_1 <- lengths(regmatches(
    tbl$model_id,
    gregexpr(sep, tbl$model_id, fixed = TRUE)
  )) > 1L
  if (any(n_sep_gt_1)) {
    cli::cli_abort(c(
      "x" = "All {.arg model_id} values must only contain a single separator
            character {.val {sep}}.",
      "!" = "Values {.val
            {unique(tbl$model_id[n_sep_gt_1])}} containing more than one separator
            character detected in rows {.val {which(n_sep_gt_1)}}."
    ))
  }


  tbl[, "model_abbr"] <- gsub(paste0("^.*", sep), "", tbl$model_id)
  tbl[, "team_abbr"] <- gsub(paste0(sep, ".*$"), "", tbl$model_id)

  # remove model_id column
  tbl[, "model_id"] <- NULL

  col_order <- names(tbl)[!names(tbl) %in% c("team_abbr", "model_abbr")]
  tbl <- tbl[, c("team_abbr", "model_abbr", col_order)]

  return(tbl)
}
