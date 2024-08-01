#' Convert model output to a `model_out_tbl` class object.
#'
#' @param tbl a `data.frame` or `tibble` of model output data returned from a query
#' to a `<hub_connection>` object.
#' @param model_id_col character string. If a `model_id` column does not
#' already exist in `tbl`, the `tbl` column name containing `model_id` data.
#' Alternatively, if both a `team_abbr` and a `model_abbr` column exist, these will
#' be merged automatically to create a single `model_id` column.
#' @param output_type_col character string. If an `output_type` column does not
#' already exist in `tbl`, the `tbl` column name containing `output_type` data.
#' @param output_type_id_col character string. If an `output_type_id` column does not
#' already exist in `tbl`, the `tbl` column name containing `output_type_id` data.
#' @param value_col character string. If a `value` column does not
#' already exist in `tbl`, the `tbl` column name containing `value` data.
#' @param sep character string. Character used as separator when concatenating
#' `team_abbr` and `model_abbr` column values into a single `model_id` string. Only
#' applicable if `model_id` column not present and `team_abbr` and `model_abbr` columns are.
#' @param trim_to_task_ids logical. Whether to trim `tbl` to task ID columns only. Task ID
#' columns can be specified by providing a `<hub_connection>` class object to `hub_con` or
#' manually through `task_id_cols`.
#' @param hub_con a `<hub_connection>` class object. Only used if
#' `trim_to_task_ids = TRUE` and tasks IDs should be determined from the hub config.
#' @param task_id_cols a character vector of column names. Only used if
#' `trim_to_task_ids = TRUE` to manually specify task ID columns to retain.
#' Overrides `hub_con` argument if provided.
#' @param remove_empty Logical. Whether to remove columns containing only `NA`.
#'
#' @return A `model_out_tbl` class object.
#' @export
#'
#' @examples
#' if (requireNamespace("hubData", quietly = TRUE)) {
#'   library(dplyr)
#'   hub_path <- system.file("testhubs/flusight", package = "hubUtils")
#'   hub_con <- hubData::connect_hub(hub_path)
#'   hub_con %>%
#'     filter(output_type == "quantile", location == "US") %>%
#'     collect() %>%
#'     filter(forecast_date == max(forecast_date)) %>%
#'     as_model_out_tbl()
#'}
as_model_out_tbl <- function(tbl, model_id_col = NULL, output_type_col = NULL,
                             output_type_id_col = NULL, value_col = NULL, sep = "-",
                             trim_to_task_ids = FALSE, hub_con = NULL,
                             task_id_cols = NULL, remove_empty = FALSE) {
  checkmate::assert_data_frame(tbl)
  tbl <- tibble::as_tibble(tbl)

  tbl <- rename_columns(tbl,
    model_id_col = model_id_col,
    output_type_col = output_type_col,
    output_type_id_col = output_type_id_col,
    value_col = value_col
  )

  if (!"model_id" %in% names(tbl)) {
    cli::cli_alert_warning("{.arg model_id} column missing. Attempting to create automatically.")
    tbl <- model_id_merge(tbl, sep = sep)
  }

  if (trim_to_task_ids) {
    tbl <- trim_tbl_to_task_ids(
      tbl = tbl,
      task_id_cols = task_id_cols,
      hub_con = hub_con
    )
  }

  if (remove_empty) {
    # Remove any non std_colnames columns that only contain NAs
    tbl <- remove_model_out_tbl_empty(tbl)
  }

  tbl <- std_col_order_model_out_tbl(tbl)

  structure(tbl,
    class = c("model_out_tbl", class(tbl))
  ) %>%
    validate_model_out_tbl()
}

#' Validate a `model_out_tbl` object.
#'
#' @param tbl a `model_out_tbl` S3 class object.
#'
#' @return If valid, returns a `model_out_tbl` class object. Otherwise, throws an
#' error.
#' @export
#'
#' @examples
#' if (requireNamespace("hubData", quietly = TRUE)) {
#'   library(dplyr)
#'   hub_path <- system.file("testhubs/flusight", package = "hubUtils")
#'   hub_con <- hubData::connect_hub(hub_path)
#'   md_out <- hub_con %>%
#'     filter(output_type == "quantile", location == "US") %>%
#'     collect() %>%
#'     filter(forecast_date == max(forecast_date)) %>%
#'     as_model_out_tbl()
#'
#'   validate_model_out_tbl(md_out)
#' }
validate_model_out_tbl <- function(tbl) {
  if (!all(std_colnames %in% names(tbl))) {
    cli::cli_abort(
      c(
        "x" = "Standard column{?s} {.val
              {std_colnames[!std_colnames %in% names(tbl)]}}
              missing from {.arg tbl}.",
        "!" = "Valid {.cls model_out_tbl} objects must contain standard
              columns {.val {std_colnames}}"
      )
    )
  }
  check_std_coltypes(tbl)

  if (nrow(tbl) == 0) {
    cli::cli_warn(c("!" = "{.arg tbl} has zero rows."))
  }

  return(tbl)
}

# --- Unexported Utilities ----
rename_columns <- function(tbl, model_id_col, output_type_col, output_type_id_col,
                           value_col, call = rlang::caller_env()) {
  old_names <- names(tbl)

  if (!is.null(model_id_col)) {
    model_id_col <- validate_col_input(model_id_col, call = call)
    tbl <- rename_col(tbl, model_id_col, old_names, call)
  }
  if (!is.null(output_type_col)) {
    output_type_col <- validate_col_input(output_type_col, call = call)
    tbl <- rename_col(tbl, output_type_col, old_names, call)
  }
  if (!is.null(output_type_id_col)) {
    output_type_id_col <- validate_col_input(output_type_id_col, call = call)
    tbl <- rename_col(tbl, output_type_id_col, old_names, call)
  }
  if (!is.null(value_col)) {
    value_col <- validate_col_input(value_col, call = call)
    tbl <- rename_col(tbl, value_col, old_names, call)
  }
  return(tbl)
}

validate_col_input <- function(x, call = rlang::caller_env()) {
  if (!is.character(x)) {
    cli::cli_abort("{.arg {rlang::caller_arg(x)}} must be a {.cls character} string
                       instead of {.cls {typeof(x)}}",
      call = call
    )
  }
  if (length(x) > 1L) {
    cli::cli_warn("{.arg {rlang::caller_arg(x)}} must be character vector of
                       length {.val {1L}} not length {.val {length(x)}}.
                      Only element 1 ({.val {x[1]}}) used, the rest ignored.",
      call = call
    )
    x <- x[1]
  }
  return(x)
}

rename_col <- function(x, col_name, old_names, call) {
  arg_name <- rlang::caller_arg(col_name)
  if (!col_name %in% names(x)) {
    cli::cli_abort(
      c(
        "x" = "{.arg {arg_name}} value {.val {col_name}}
                       not a valid column name in {.arg x}",
        "!" = "Must be one of {.val {old_names}}"
      ),
      call = call
    )
  } else {
    new_col_name <- gsub("_col", "", arg_name)
    names(x)[names(x) == col_name] <- new_col_name
  }
  return(x)
}

trim_tbl_to_task_ids <- function(tbl, task_id_cols, hub_con,
                                 call = rlang::caller_env()) {
  if (is.null(task_id_cols) && is.null(hub_con)) {
    cli::cli_abort(
      c(
        "x" = "Cannot trim to task IDs when both
                  {.arg task_id_cols} and {.arg hub_con} are NULL",
        "!" = "Please supply appropriate input to either
                {.arg task_id_cols} or {.arg hub_con}."
      ),
      call = call
    )
  }

  if (is.null(task_id_cols)) {
    if (!inherits(hub_con, "hub_connection")) {
      cli::cli_abort("{.arg hub_con} must be a valid object of
                                   class {.cls hub_connection}",
        call = call
      )
    }
    task_id_cols <- get_task_id_names(attr(hub_con, "config_tasks"))
  }

  # Ensure only task_id_cols present in table are subset
  if (!all(task_id_cols %in% names(tbl))) {
    cli::cli_alert_warning(
      "{.arg task_id_cols} value{?s} {.val
                  {task_id_cols[!task_id_cols %in% names(tbl)]}
                  } not a valid {.arg tbl} column name. Ignored."
    )
  }
  task_id_cols <- task_id_cols[task_id_cols %in% names(tbl)]

  return(tbl[, c(task_id_cols, std_colnames)])
}

remove_model_out_tbl_empty <- function(tbl) {
  non_na_cols <- purrr::map_lgl(tbl, ~ !all(is.na(.x)))
  non_na_cols[names(non_na_cols) %in% std_colnames] <- TRUE

  tbl[, non_na_cols]
}

std_col_order_model_out_tbl <- function(tbl) {
  tbl[
    ,
    c(
      std_colnames[1],
      names(tbl)[!names(tbl) %in% std_colnames],
      std_colnames[-1]
    )
  ]
}

check_std_coltypes <- function(tbl, call = rlang::caller_env()) {
  test_datatype <- function(x, data_type) {
    !any(purrr::map_lgl(
      data_type,
      ~ get(paste0("is.", .x))(x)
    ))
  }

  error_df <- tibble::tibble(
    colname = names(std_col_datatypes),
    correct_datatype = purrr::map_chr(std_col_datatypes, ~ paste(.x, collapse = "/")),
    actual_datatype = purrr::map_chr(
      tbl[, names(std_col_datatypes)],
      ~ class(.x)
    ),
    is_wrong_datatype = purrr::map2_lgl(
      .x = tbl[, names(std_col_datatypes)],
      .y = std_col_datatypes,
      function(x, y) {
        test_datatype(x = x, data_type = y)
      }
    ),
    n_correct_datatypes = lengths(std_col_datatypes)
  )

  if (any(error_df$is_wrong_datatype)) {
    error_df <- error_df[error_df$is_wrong_datatype, ]

    compose_error_msg <- function(i) {
      paste0(
        "Column {.arg {error_df$colname[", i, "]}} should be ",
        "{cli::qty(error_df$n_correct_datatypes[", i, "])} {?one of }",
        "{.cls {error_df$correct_datatype[", i, "]}},",
        " not {.cls {error_df$actual_datatype[", i, "]}}."
      )
    }

    error_msg <- c("x" = "{cli::qty(nrow(error_df))} Wrong datatype{?s} detected in standard column{?s}:")

    for (i in seq_len(nrow(error_df))) {
      error_msg <- c(error_msg, "!" = compose_error_msg(i))
    }
    cli::cli_abort(error_msg, call = call)
  }
  invisible(tbl)
}
