#' Create a point estimate output type object of class `output_type_item`
#'
#' Create a representation of a `mean` or `median` output type as a list object of
#' class `output_type_item`. This can be combined with
#' additional `output_type_item` objects using function [`create_output_type()`] to
#' create an `output_type` object for a given model_task.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' @param is_required Logical. Is the output type required?
#' @param value_type Character string. The data type of the output_type values.
#' @param value_minimum Numeric. The exclusive minimum of output_type values.
#' @param value_maximum Numeric. The exclusive maximum of output_type values.
#'
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#' @return a named list of class `output_type_item` representing a `mean` or
#' `median` output type.
#' @inheritParams create_task_id
#' @export
#' @describeIn create_output_type_mean Create a list representation of a `mean`
#' output type.
#' @seealso [create_output_type()]
#' @examples
#' create_output_type_mean(
#'   is_required = TRUE,
#'   value_type = "double",
#'   value_minimum = 0L
#' )
#' create_output_type_median(
#'   is_required = FALSE,
#'   value_type = "integer"
#' )
create_output_type_mean <- function(is_required, value_type, value_minimum = NULL,
                                    value_maximum = NULL, schema_version = "latest",
                                    branch = "main") {
  create_output_type_point(
    output_type = "mean", is_required = is_required,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}

#' @export
#' @describeIn create_output_type_mean Create a list representation of a `median`
#' output type.
create_output_type_median <- function(is_required, value_type, value_minimum = NULL,
                                      value_maximum = NULL, schema_version = "latest",
                                      branch = "main") {
  create_output_type_point(
    output_type = "median", is_required = is_required,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}


create_output_type_point <- function(output_type = c("mean", "median"),
                                     is_required, value_type, value_minimum = NULL,
                                     value_maximum = NULL, schema_version = "latest",
                                     branch = "main", call = rlang::caller_env()) {
  rlang::check_required(value_type)
  rlang::check_required(is_required)

  if (!rlang::is_logical(is_required, n = 1L)) {
    cli::cli_abort(c(
      "x" = "Argument {.arg is_required} must be {.cls logical} and have length 1."
    ))
  }
  output_type <- rlang::arg_match(output_type)
  # Get output type id property according to config schema version
  # TODO: remove back-compatibility with schema versions < v2.0.0 when support
  # retired
  config_tid <- get_config_tid(
    config_version = get_schema_version_latest(schema_version, branch)
  )

  schema <- download_schema(schema_version, branch)

  # create output_type_id
  if (is_required) {
    output_type_id <- list(output_type_id = list(
      required = NA_character_,
      optional = NULL
    ))
  } else {
    output_type_id <- list(output_type_id = list(
      required = NULL,
      optional = NA_character_
    ))
  }

  # TODO: Remove when support for versions < 2.0.0 retired
  names(output_type_id) <- config_tid

  output_type_schema <- get_schema_output_type(schema,
    output_type = output_type
  )

  value_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "value",
    "properties"
  )

  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()


  purrr::walk(
    names(value),
    ~ check_input(
      input = value[[.x]],
      property = .x,
      value_schema,
      parent_property = "value",
      scalar = TRUE,
      call = call
    )
  )

  structure(
    list(c(output_type_id, list(value = value))),
    class = c("output_type_item", "list"),
    names = output_type,
    schema_id = schema$`$id`
  )
}


#' Create a distribution output type object of class `output_type_item`
#'
#' Create a representation of a `quantile`, `cdf`, `pmf` or `sample` output
#' type as a list object of class `output_type_item`. This can be combined with
#' additional `output_type_item`s using function [`create_output_type()`] to
#' create an `output_type` object for a given model_task.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' output type.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' @param required Atomic vector of required `output_type` values. Can be NULL if
#'  all values are optional.
#' @param optional Atomic vector of optional `output_type` values. Can be NULL if
#' all values are required.
#' @inheritParams create_task_id
#' @inheritParams create_output_type_mean
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#'
#' @return a named list of class `output_type_item` representing a `quantile`,
#' `cdf`, `pmf` or `sample` output type.
#' @export
#' @describeIn create_output_type_quantile Create a list representation of a `quantile`
#' output type.
#' @seealso [create_output_type()]
#' @examples
#' create_output_type_quantile(
#'   required = c(0.25, 0.5, 0.75),
#'   optional = c(
#'     0.1, 0.2, 0.3, 0.4, 0.6,
#'     0.7, 0.8, 0.9
#'   ),
#'   value_type = "double",
#'   value_minimum = 0
#' )
#' create_output_type_cdf(
#'   required = c(10, 20),
#'   optional = NULL,
#'   value_type = "double"
#' )
#' create_output_type_cdf(
#'   required = NULL,
#'   optional = c("EW202240", "EW202241", "EW202242"),
#'   value_type = "double"
#' )
#' create_output_type_pmf(
#'   required = NULL,
#'   optional = c("low", "moderate", "high", "extreme"),
#'   value_type = "double"
#' )
#' create_output_type_sample(
#'   required = 1:10, optional = 11:15,
#'   value_type = "double"
#' )
create_output_type_quantile <- function(required, optional,
                                        value_type, value_minimum = NULL,
                                        value_maximum = NULL,
                                        schema_version = "latest",
                                        branch = "main") {
  create_output_type_dist(
    output_type = "quantile", required = required, optional = optional,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}

#' @describeIn create_output_type_quantile Create a list representation of a `cdf`
#' output type.
#' @export
create_output_type_cdf <- function(required, optional,
                                   value_type,
                                   schema_version = "latest",
                                   branch = "main") {
  create_output_type_dist(
    output_type = "cdf", required = required, optional = optional,
    value_type = value_type, value_minimum = 0L,
    value_maximum = 1L, schema_version = schema_version,
    branch = branch
  )
}

#' @describeIn create_output_type_quantile Create a list representation of a `pmf`
#' output type.
#' @export
create_output_type_pmf <- function(required, optional, value_type,
                                   schema_version = "latest",
                                   branch = "main") {
  create_output_type_dist(
    output_type = "pmf", required = required, optional = optional,
    value_type = value_type, value_minimum = 0L,
    value_maximum = 1L, schema_version = schema_version,
    branch = branch
  )
}

#' @describeIn create_output_type_quantile Create a list representation of a `sample`
#' output type.
#' @export
create_output_type_sample <- function(required, optional, value_type,
                                      value_minimum = NULL, value_maximum = NULL,
                                      schema_version = "latest",
                                      branch = "main") {
  create_output_type_dist(
    output_type = "sample", required = required, optional = optional,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}


create_output_type_dist <- function(output_type = c(
                                      "quantile", "cdf", "pmf",
                                      "sample"
                                    ),
                                    required, optional,
                                    value_type, value_minimum = NULL,
                                    value_maximum = NULL, schema_version = "latest",
                                    branch = "main", call = rlang::caller_env()) {
  rlang::check_required(value_type)
  rlang::check_required(required)
  rlang::check_required(optional)
  output_type <- rlang::arg_match(output_type)
  # Get output type id property according to config schema version
  # TODO: remove back-compatibility with schema versions < v2.0.0 when support
  # retired
  config_tid <- get_config_tid(
    config_version = get_schema_version_latest(schema_version, branch)
    )

  schema <- download_schema(schema_version, branch)
  output_type_schema <- get_schema_output_type(schema, output_type)
  output_type_id_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    config_tid,
    "properties"
  )

  # Check and create output_type_id
  if (output_type == "cdf") {
    purrr::walk(
      c("required", "optional"),
      ~ check_oneof_input(
        input = get(.x),
        property = .x,
        output_type_id_schema,
        call = call
      )
    )
  } else {
    purrr::walk(
      c("required", "optional"),
      ~ check_input(
        input = get(.x),
        property = .x,
        output_type_id_schema,
        parent_property = config_tid,
        call = call
      )
    )
  }

  check_prop_not_all_null(required, optional)
  check_prop_type_const(required, optional)
  check_prop_dups(required, optional)

  output_type_id <- list(output_type_id = list(
    required = required,
    optional = optional
  ))

  # TODO: Remove when support for versions < 2.0.0 retired
  names(output_type_id) <- config_tid

  # Check and create value
  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()

  value_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "value",
    "properties"
  )

  purrr::walk(
    names(value),
    ~ check_input(
      input = value[[.x]],
      property = .x,
      value_schema,
      parent_property = "value",
      scalar = TRUE,
      call = rlang::caller_env(n = 5)
    )
  )

  structure(
    list(c(output_type_id, list(value = value))),
    class = c("output_type_item", "list"),
    names = output_type,
    schema_id = schema$`$id`
  )
}
