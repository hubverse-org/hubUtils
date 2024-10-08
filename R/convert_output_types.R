#' Transform between output types
#'
#' Transform between output types for each unique combination of task IDs for
#' each model. Conversion must be from a single starting output type to one or more
#' new output types, and the resulting output will only contain the new output types.
#' See details for supported conversions.
#'
#' @param model_out_tbl an object of class `model_out_tbl` containing predictions
#'    with a single, unique value in the `output_type` column.
#' @param new_output_type character vector of the desired output type(s) after
#'   transformation. May contain any of the following output types:
#'   `"mean"`, `"median"`, `"quantile"`, `"cdf"`.
#' @param new_output_type_id A named list indicating the desired output type IDs
#'   for each new output type, in which each element is a vector of output type IDs.
#'   If only one new output type is requested, then it may be a single numeric vector
#'   (for `"quantile"` or `"cdf"`) or not required (`"mean"` or `"median"`). See
#'   the examples for an illustration of both cases.
#' @param n_samples `numeric` that specifies the number of samples to use when
#'   calculating output_types from an estimated quantile function. Defaults to `1e4`.
#' @param ... parameters that are passed to `distfromq::make_q_fn`, specifying
#'   details of how to estimate a quantile function from provided quantile levels
#'   and quantile values for `"quantile"` or `"cdf"` output types.
#'
#' @details
#' The following transformations are supported: (i) `"sample"` can be
#' transformed to `"mean"`, `"median"`, `"quantile"`, or `"cdf"`; (ii)
#' `"quantile"` can be transformed to `"mean"`, `"median"`, or `"cdf"`; and
#' (iii) `"cdf"` can be transformed to `"mean"`, `"median"`, or `"quantile"`.
#'
#' For `"quantile"` and `"cdf"` starting output types, we use the following approach:
#'   1. Interpolate and extrapolate from the provided quantiles or probabilities
#'        for each component model to obtain an estimate of the cdf of that distribution.
#'   2. Draw samples from the distribution for each component model. To reduce
#'        Monte Carlo variability, we use quasi-random samples corresponding to
#'        quantiles of the estimated distribution.
#'   3. Calculate the desired quantity (e.g., mean).
#' If the median quantile is provided in the `model_out_tbl` object (i.e., the
#' original output_type is `"median"` and 0.5 is contained in the original
#' output_type_id), the median value is extracted and returned directly.
#'
#' If both `"quantile"` and `"cdf"` output_types are desired, `new_output_type_id`
#' should be a named list, where each element specifies the corresponding
#' `new_output_type_id`. See examples for an illustration.
#'
#' @examples
#' # We illustrate the conversion between output types using normal distributions
#' ex_quantiles <- c(0.25, 0.5, 0.75)
#' model_out_tbl <- expand.grid(
#'   stringsAsFactors = FALSE,
#'   group1 = c(1,2),
#'   model_id = "A",
#'   output_type = "quantile",
#'   output_type_id = ex_quantiles
#' ) %>%
#' dplyr::mutate(value = qnorm(p = output_type_id, mean = group1))
#'
#' convert_output_type(model_out_tbl, new_output_type = "median", new_output_type_id = NA)
#'
#' # Next, we illustrate conversion from samples to quantile and cdf
#' ex_bins <- seq(-2,2,1)
#' ex_quantiles <- c(0.25, 0.5, 0.75)
#' model_out_tbl <- expand.grid(
#'   stringsAsFactors = FALSE,
#'   group1 = c(1,2),
#'   model_id = "A",
#'   output_type = "sample",
#'   output_type_id = 1:100
#' ) %>%
#' dplyr::mutate(value = rnorm(200, mean = group1))
#'
#' convert_output_type(model_out_tbl, new_output_type = c("quantile", "cdf"),
#'    new_output_type_id = list("quantile" = ex_quantiles, "cdf" = ex_bins))
#'
#' @return object of class `model_out_tbl` containing (only) the new output_type(s)
#'   for each unique combination of task IDs for each model
#' @export
#' @importFrom rlang .data
convert_output_type <- function(model_out_tbl, new_output_type,
                                new_output_type_id = NA, n_samples = 1e4, ...) {
  # validations
  starting_output_type <- unique(model_out_tbl$output_type)
  starting_output_type_ids <- unique(model_out_tbl$output_type_id)
  task_id_cols <- get_task_id_cols(model_out_tbl)
  validate_new_output_type(
    starting_output_type, new_output_type,
    new_output_type_id
  )
  # for cdf and quantile functions, get samples
  if (starting_output_type == "cdf") {
    # estimate from samples
    model_out_tbl <- get_samples_from_cdf(model_out_tbl, task_id_cols, n_samples)
  } else if (starting_output_type == "quantile") {
    # if median output desired, and Q50 provided return exact value, otherwise
    # estimate from samples
    if (any(new_output_type != "median") || !(0.5 %in% starting_output_type_ids)) {
      model_out_tbl <- model_out_tbl %>%
        get_samples_from_quantiles(task_id_cols, n_samples) %>%
        rbind(model_out_tbl)
    }
  }
  # transform based on new_output_type
  model_out_tbl_transform <- vector("list", length = length(new_output_type))
  for (i in seq_along(new_output_type)) {
    # first find new_output_type_id
    new_output_type_id_tmp <- new_output_type_id
    if (new_output_type[i] %in% c("mean", "median")) {
      new_output_type_id_tmp <- NA
    } else if (is.list(new_output_type_id)) {
      new_output_type_id_tmp <- new_output_type_id[[new_output_type[i]]]
    }
    # if median output desired, and Q50 provided return exact value
    if (new_output_type[i] == "median" && 0.5 %in% starting_output_type_ids) {
      model_out_tbl_transform[[i]] <- model_out_tbl %>%
        dplyr::filter(
          .data[["output_type"]] != "sample",
          .data[["output_type_id"]] == 0.5
        ) %>%
        dplyr::mutate(
          output_type = new_output_type[i],
          output_type_id = NA
        ) %>%
        as_model_out_tbl()
    } else {  # otherwise calculate new values
      grouped_model_out_tbl <- model_out_tbl %>%
        dplyr::filter(.data[["output_type"]] == "sample") %>%
        dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols))))
      model_out_tbl_transform[[i]] <- grouped_model_out_tbl %>%
        convert_from_sample(new_output_type[i], new_output_type_id_tmp) %>%
        dplyr::ungroup()
    }
  }
  return(dplyr::bind_rows(model_out_tbl_transform))
}

#' @noRd
validate_new_output_type <- function(starting_output_type, new_output_type,
                                     new_output_type_id) {
  # check only one starting_output_type is provided
  if (length(starting_output_type) != 1) {
    cli::cli_abort(c("Only one {.var starting_output_type} may be provided"))
  }
  valid_conversions <- list(
    "sample" = c("mean", "median", "quantile", "cdf"),
    "quantile" = c("mean", "median", "cdf"),
    "cdf" = c("mean", "median", "quantile")
  )
  # check starting_output_type is supported
  valid_starting_output_type <- starting_output_type %in% names(valid_conversions)
  if (!valid_starting_output_type) {
    cli::cli_abort(c(
      "{.var output_type} {.val {starting_output_type}} provided cannot be transformed",
      i = "must be of type {.val sample}, {.val quantile} or {.val cdf}."
    ))
  }
  # check new_output_type is supported
  invalid_new_output_type <- which(!(new_output_type %in% valid_conversions[[starting_output_type]]))
  if (length(invalid_new_output_type) > 0) {
    cli::cli_abort(c(
      "Output type {.val {starting_output_type}} cannot be converted to the specified
      {.val {new_output_type[invalid_new_output_type]}}",
      i = "{.var new_output_type} values must be one of {.val {valid_conversions[[starting_output_type]]}}"
    ))
  }
  # check new_output_type_id
  if (length(new_output_type) == 1) {
    validate_new_output_type_id(new_output_type, new_output_type_id)
  } else if (length(new_output_type > 1)) {
    purrr::map(.x = new_output_type,
               ~ validate_new_output_type_id(new_output_type = .x,
                                             new_output_type_id = new_output_type_id[[.x]]))
  }
}

#' @noRd
validate_new_output_type_id <- function(new_output_type, new_output_type_id) {
  if (new_output_type %in% c("mean", "median") && !all(is.na(new_output_type_id))) {
    cli::cli_abort(c(
      "{.var new_output_type_id} is incompatible with {.var new_output_type}",
      i = "{.var new_output_type_id} should be {.var NA}"
    ))
  } else if (new_output_type == "quantile") {
    new_output_type_id_quantile <- new_output_type_id
    if (!is.numeric(new_output_type_id_quantile)) {
      cli::cli_abort(c(
        "elements of {.var new_output_type_id} should be numeric",
        i = "elements of {.var new_output_type_id} represent quantiles
                of the predictive distribution"
      ))
    }
    if (any(new_output_type_id_quantile < 0) || any(new_output_type_id_quantile > 1)) {
      cli::cli_abort(c(
        "elements of {.var new_output_type_id} should be between 0 and 1",
        i = "elements of {.var new_output_type_id} represent quantiles
                of the predictive distribution"
      ))
    }
  } else if (new_output_type == "cdf") {
    new_output_type_id_cdf <- new_output_type_id
    if (!is.numeric(new_output_type_id_cdf)) {
      cli::cli_abort(c(
        "elements of {.var new_output_type_id} should be numeric",
        i = "elements of {.var new_output_type_id} represent possible
                values of the target variable"
      ))
    }
  }
}

#' @noRd
get_samples_from_quantiles <- function(model_out_tbl, task_id_cols, n_samples, ...) {
  if (!requireNamespace("distfromq")) {
    cli::cli_abort(
      c("x" = "{.pkg distfromq} must be installed to convert {.val cdf} 
                   or {.val quantile} output types.",
        "i" = "Use {.code remotes::install_github('reichlab/distfromq')} to install."
      )
    )
  }

  samples <- model_out_tbl %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols)))) %>%
    dplyr::reframe(
      value = distfromq::make_q_fn(
        ps = as.numeric(.data[["output_type_id"]]),
        qs = .data[["value"]], ...
      )(stats::runif(n_samples, 0, 1))
    ) %>%
    dplyr::ungroup()
  split_samples <- split(samples, f = samples[[task_id_cols]])
  formatted_samples <- split_samples %>%
    purrr::map(.f = function(split_samples) {
      dplyr::mutate(split_samples,
                    output_type = "sample",
                    output_type_id = as.numeric(dplyr::row_number()),
                    .before = "value")
    }) %>%
    purrr::list_rbind() %>%
    as_model_out_tbl()
  return(formatted_samples)
}

#' @noRd
get_samples_from_cdf <- function(model_out_tbl, task_id_cols, n_samples, ...) {
  if (!requireNamespace("distfromq")) {
    cli::cli_abort(
      c("x" = "{.pkg distfromq} must be installed to convert {.val cdf} 
                   or {.val quantile} output types.",
        "i" = "Use {.code remotes::install_github('reichlab/distfromq')} to install."
      )
    )
  }

  samples <- model_out_tbl %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c("model_id", task_id_cols)))) %>%
    dplyr::reframe(
      value = distfromq::make_q_fn(
        ps = .data[["value"]],
        qs = as.numeric(.data[["output_type_id"]]), ...
      )(stats::runif(n_samples, 0, 1))
    ) %>%
    dplyr::ungroup()
  split_samples <- split(samples, f = samples[[task_id_cols]])
  formatted_samples <- split_samples %>%
    purrr::map(.f = function(split_samples) {
      dplyr::mutate(split_samples,
                    output_type = "sample",
                    output_type_id = as.numeric(dplyr::row_number()),
                    .before = "value")
    }) %>%
    purrr::list_rbind() %>%
    as_model_out_tbl()
  return(formatted_samples)
}

#' @noRd
convert_from_sample <- function(grouped_model_out_tbl, new_output_type,
                                new_output_type_id) {
  if (new_output_type == "mean") {
    model_out_tbl_transform <- grouped_model_out_tbl %>%
      dplyr::reframe(
        value = mean(.data[["value"]]),
        output_type_id = new_output_type_id
      )
  } else if (new_output_type == "median") {
    model_out_tbl_transform <- grouped_model_out_tbl %>%
      dplyr::reframe(
        value = mean(.data[["value"]]),
        output_type_id = new_output_type_id
      )
  } else if (new_output_type == "quantile") {
    model_out_tbl_transform <- grouped_model_out_tbl %>%
      dplyr::reframe(
        value = stats::quantile(.data[["value"]], as.numeric(new_output_type_id), names = FALSE),
        output_type_id = new_output_type_id
      )
  } else if (new_output_type == "cdf") {
    model_out_tbl_transform <- grouped_model_out_tbl %>%
      dplyr::reframe(
        value = stats::ecdf(.data[["value"]])(as.numeric(new_output_type_id)),
        output_type_id = new_output_type_id
      )
  }
  # update output_type and output_type_id columns
  model_out_tbl_transform <- model_out_tbl_transform %>%
    dplyr::mutate(output_type = new_output_type) %>%
    as_model_out_tbl()
  return(model_out_tbl_transform)
}
