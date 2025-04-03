#' Transform between output types
#'
#' Transform between output types for each unique combination of task IDs for each
#' model. Conversion must be from a single initial output type to one or more
#' to output types, and the resulting output will only contain the to
#' output types. See details for supported conversions.
#'
#' @param model_out_tbl an object of class `model_out_tbl` containing predictions
#'    with a single, unique value in the `output_type` column.
#' @param to a named list indicating the desired output types and associated
#'   output type IDs. List item name and value pairs may be as follows:
#'   - `mean`: `NA` (no associated output type ID)
#'   - `median`: `NA` (no associated output type ID)
#'   - `quantile`: a numeric vector of probability levels OR a dataframe of
#'     probability levels and the task ID variables they depend upon.
#'     (See examples section for an example of each.)
#'
#' @details Currently, only `"sample"` can be converted to `"mean"`, `"median"`,
#' or `"quantile"`
#'
#' @examples
#' # We illustrate the conversion between output types using normal distributions
#' ex_quantiles <- c(0.25, 0.5, 0.75)
#' model_out_tbl <- expand.grid(
#'   stringsAsFactors = FALSE,
#'   group1 = c(1,2),
#'   model_id = "A",
#'   output_type = "sample",
#'   output_type_id = 1:100
#' ) |>
#' dplyr::mutate(value = rnorm(200, mean = group1))
#'
#' # Output type conversions with vector `to` elements
#' convert_output_type(model_out_tbl,
#'   to = list("quantile" = ex_quantiles, "median" = NA))
#'
#' # Output type conversion with dataframe `to` element
#' # Output type ID values (quantile levels) are determined by group1 value
#' quantile_levels <- rbind(
#'  data.frame(group1 = 1, output_type_id = 0.5),
#'  data.frame(group1 = 2, output_type_id = c(0.25, 0.5, 0.75))
#' )
#' convert_output_type(model_out_tbl,
#'   to = list("quantile" = quantile_levels))
#'
#' @return object of class `model_out_tbl` containing (only) predictions of the
#'   to output_type(s) for each unique combination of task IDs for each model
#'
#' @export
#' @importFrom rlang .data
convert_output_type <- function(model_out_tbl, to) {
  # validations
  to_output_type <- names(to)
  validated_inputs <- validate_conversion_inputs(model_out_tbl, to_output_type, to)
  model_out_tbl <- validated_inputs[["model_out_tbl"]]
  to <- validated_inputs[["to"]]

  to_output_type |>
    purrr::map(convert_single_output_type, to, model_out_tbl) |>
    purrr::list_rbind() |>
    as_model_out_tbl()
}

#' Convert single output type
#' @noRd
#' @importFrom rlang .data
convert_single_output_type <- function(to_output_type, to, model_out_tbl) {
  model_out_cols <- colnames(model_out_tbl)
  task_id_cols <- subset_task_id_names(model_out_cols)
  grouped_model_outputs <- dplyr::group_by(model_out_tbl, dplyr::across(dplyr::all_of(c("model_id", task_id_cols))))
  to_output_type_id <- to[[to_output_type]]

  if (to_output_type %in% c("mean", "median")) {
    otid_cols <- "output_type_id"
    transform_fun <- match.fun(to_output_type)
    transform_args <- list(x = quote(.data[["value"]]))
  } else if (to_output_type == "quantile") {
    otid_cols <- "output_type_id"
    transform_fun <- stats::quantile
    transform_args <- list(
      x = quote(.data[["value"]]),
      probs = quote(unique(.data[["output_type_id"]])),
      names = FALSE
    )
  }

  # if overlapping columns, join grouped_model_outputs with to_output_type_id
  # else, cross-join to avoid warnings (vector to_output_type_id elements
  #   are coerced to data frames during validation)
  join_cols <- task_id_cols[task_id_cols %in% colnames(to_output_type_id)]
  if (length(join_cols) > 0) {
    grouped_model_outputs <- grouped_model_outputs |>
      dplyr::select(-c("output_type", "output_type_id")) |>
      dplyr::left_join(
        to_output_type_id,
        by = join_cols,
        relationship = "many-to-many"
      )
  } else {
    grouped_model_outputs <- grouped_model_outputs |>
      dplyr::select(-c("output_type", "output_type_id")) |>
      dplyr::cross_join(to_output_type_id)
  }

  # compute prediction values, clean up included columns
  grouped_model_outputs |>
    dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols, otid_cols)))) |>
    dplyr::reframe(value = do.call(transform_fun, args = transform_args)) |>
    dplyr::mutate(
      output_type = to_output_type,
      .before = "output_type_id"
    ) |>
    dplyr::select(dplyr::all_of(model_out_cols))
}

#' Validate inputs to convert_output_types
#' @noRd
validate_conversion_inputs <- function(model_out_tbl, to_output_type, to) {
  # check model_out_tbl contains the "model_id" column
  # otherwise, coercion to model_out_tbl will fail
  model_out_cols <- colnames(model_out_tbl)
  if (!("model_id" %in% model_out_cols)) {
    cli::cli_abort(c("Provided {.arg model_output_tbl} must contain the column {.val {'model_id'}}"))
  }
  # check only one initial_output_type is provided
  initial_output_type <- unique(model_out_tbl$output_type)
  if (length(initial_output_type) != 1L) {
    cli::cli_abort(
      c("!" = "Provided {.arg model_out_tbl} may only contain one output type.",
        "x" = "Found {length(initial_output_type)} output types: {.val {initial_output_type}}."
        )
    )
  }
  valid_conversions <- list(
    "sample" = c("mean", "median", "quantile")
  )
  # check initial_output_type is supported
  valid_initial_output_type <- initial_output_type %in% names(valid_conversions)
  if (!valid_initial_output_type) {
    cli::cli_abort(c(
      "Transformation of {.arg output_type} {.val {initial_output_type}} is not supported",
      i = "{.arg model_out_tbl} may only contain one of types {.val {names(valid_conversions)}}"
    ))
  }
  # check to_output_type is supported
  invalid_to_output_type <- setdiff(to_output_type, valid_conversions[[initial_output_type]])
  if (length(invalid_to_output_type) > 0) {
    cli::cli_abort(c(
      "Forecasts of {.arg output_type} {.val {initial_output_type}} cannot be converted to
      {.val {invalid_to_output_type}}",
      i = "{.arg to_output_type} values must be one of {.val {valid_conversions[[initial_output_type]]}}"
    ))
  }

  # check to and coerce vectors to data frames
  validated_to_output <- purrr::map(
    .x = to_output_type,
    ~ validate_to_output(
      to_output_type = .x,
      to_otid = to[[.x]],
      task_id_cols = subset_task_id_names(model_out_cols)
    )
  )
  names(validated_to_output) <- to_output_type

  list(
    model_out_tbl = as_model_out_tbl(model_out_tbl),
    to = validated_to_output
  )
}


#' Validate the to output type id values for a single to output type
#' @noRd
validate_to_output <- function(to_output_type, to_otid, task_id_cols) {
  # coerce vector to_otid elements to data frame for joining
  if (is.atomic(to_otid)) {
    to_otid <- data.frame(output_type_id = to_otid)
  }

  if (to_output_type %in% c("mean", "median") && !is.na(to_otid$output_type_id)) {
    cli::cli_abort(c(
      "{.arg to} is incompatible with {.arg to_output_type}",
      i = "{.arg to} should be {.val NA}"
    ))
  } else {
    req_to_otid_cols <- "output_type_id"
    if (!all(req_to_otid_cols %in% names(to_otid))) {
      cli::cli_abort(c(
        "{.arg to} did not contain the required column {.val {req_to_otid_cols}}"
      ))
    }

    # joining_columns must be part of task_ids
    join_by_cols <- names(to_otid)[!(names(to_otid) %in% req_to_otid_cols)]
    invalid_cols <- join_by_cols[!(join_by_cols %in% task_id_cols)]
    if (length(invalid_cols) > 0L) {
      cli::cli_abort(c(
        "x" = "an element of {.arg to} included {length(invalid_cols)} task ID{?s} that
               {?was/were} not present in {.arg model_out_tbl}: {.val {invalid_cols}}"
      ))
    }

    if (to_output_type == "quantile") {
      if (!is.numeric(to_otid$output_type_id)) {
        cli::cli_abort(c(
          "elements of {.arg to} should be numeric",
          i = "elements of {.arg to} represent quantiles
                  of the predictive distribution"
        ))
      }
      if (any(to_otid$output_type_id < 0) || any(to_otid$output_type_id > 1)) {
        cli::cli_abort(c(
          "elements of {.arg to} should be between 0 and 1",
          i = "elements of {.arg to} represent quantiles
                  of the predictive distribution"
        ))
      }
    }

    to_otid
  }
}
