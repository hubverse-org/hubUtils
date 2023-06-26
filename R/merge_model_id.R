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
#' @describeIn merge_model_id merge `team_abbr` and `model_abbr` into a single
#' `model_id` column.
#' @examples
#' hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
#' tbl <- hub_con %>%
#'     dplyr::filter(output_type == "quantile", location == "US") %>%
#'     dplyr::collect() %>%
#'     dplyr::filter(forecast_date == max(forecast_date))
#'
merge_model_id <- function(tbl, sep = "-") {
    # check all required columns present
    if (!all(c("model_abbr", "team_abbr") %in% names(tbl))) {
        missing_cols <- c("model_abbr", "team_abbr")[
            !c("model_abbr", "team_abbr") %in% names(tbl)
        ]
        cli::cli_abort(c(
            "x" = "Cannot create {.arg model_id} column.",
            "!" = "Required column{?s} {.val {missing_cols}} missing from {.arg tbl}."
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

#' @export
#' @describeIn merge_model_id split `model_id` column into separate `team_abbr`
#' and `model_abbr` columns.
split_model_id <- function(tbl, sep = "-") {

    # check required column present
    if (!c("model_id") %in% names(tbl)) {
        cli::cli_abort(c(
            "x" = "Cannot split {.arg model_id} column.",
            "!" = "Required column {.val model_id} missing from {.arg tbl}."
        ))
    }
    # create model_abbr team_abbr columns
    if (any(c("model_abbr", "team_abbr") %in% names(tbl))) {
        existing_cols <- c("model_abbr", "team_abbr")[
            !c("model_abbr", "team_abbr") %in% names(tbl)
        ]
        cli::cli_alert_warning("Overwritting current {.val {existing_cols}} column{?s}.")
    }
    tbl[, "model_abbr"] <- gsub(paste0("^.*", sep), "", tbl$model_id)
    tbl[, "team_abbr"] <- gsub(paste0(sep, ".*$"), "", tbl$model_id)

    # remove model_id column
    tbl[, "model_id"] <- NULL

    col_order <- names(tbl)[!names(tbl) %in% c("team_abbr", "model_abbr")]
    tbl <- tbl[, c("team_abbr", "model_abbr", col_order)]

    return(tbl)
}
