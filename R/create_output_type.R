#' Create a point estimate `output_type` element
#'
#' Create a list representation of a `mean` or `median` output type.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' @param is_required Logical. Is the output type required?
#' @param value_type Character string. The data type of the output_type values.
#' @param value_minimum Numeric. The exclusive minimum of output_type values.
#' @param value_maximum Numeric. The exclusive maximum of output_type values.
#'
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#' @return a named list representing a `mean` or `median` output type.
#' @inheritParams create_task_id
#' @export
#' @describeIn create_output_type_mean Create a list representation of a `mean`
#' output type.
#' @examples
#' create_output_type_mean(is_required = TRUE,
#'                         value_type = "double",
#'                         value_minimum = 0L)
#' create_output_type_median(is_required = FALSE,
#'                          value_type = "integer")
create_output_type_mean <- function(is_required, value_type, value_minimum = NULL,
                                    value_maximum = NULL, schema_version = "latest",
                                    branch = "main") {
    create_output_type_point(
        property = "mean", is_required = is_required,
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
        property = "median", is_required = is_required,
        value_type = value_type, value_minimum = value_minimum,
        value_maximum = value_maximum, schema_version = schema_version,
        branch = branch
    )
}


create_output_type_point <- function(property = c("mean", "median"),
                                     is_required, value_type, value_minimum = NULL,
                                     value_maximum = NULL, schema_version = "latest",
                                     branch = "main") {
  rlang::check_required(value_type)
  rlang::check_required(is_required)

  if (!rlang::is_logical(is_required, n = 1L)) {
    cli::cli_abort(c(
      "x" = "Argument {.arg is_required} must be {.cls logical} and have length 1."
    ))
  }
  property <- rlang::arg_match(property)


  schema <- download_schema(schema_version, branch)

  # create type_id
  if (is_required) {
    type_id <- list(type_id = list(
      required = NA_character_,
      optional = NULL
    ))
  } else {
    type_id <- list(type_id = list(
      required = NULL,
      optional = NA_character_
    ))
  }

  output_type_schema <- get_schema_output_type(schema, output_type = "mean")

  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()


  purrr::walk(
    names(value),
    ~ check_value_type(
      .x,
      value,
      output_type_schema
    )
  )

  list(c(type_id, list(value = value))) %>%
    stats::setNames(property)
}


check_value_type <- function(property, value, output_type_schema) {
  schema_types <- json_datatypes[
    purrr::pluck(
      output_type_schema,
      "properties", "value",
      "properties", property, "type"
    )
  ]

  input_type <- typeof(value[[property]])

  if (!input_type %in% schema_types) {
    cli::cli_abort(c(
      "x" = "Argument {.arg value_{property}} is of type {.cls {input_type}}.",
      "!" = "Must be {?/one of} {.cls {schema_types}}."
    ))
  }

  input_length <- length(value[[property]])

  if (input_length != 1) {
      cli::cli_abort(c(
          "x" = "Argument {.arg value_{property}} must be length {.val {1}},
          not {.val {input_length}}."
      ))
  }

  if (property == "type") {
    value_enum <- purrr::pluck(
      output_type_schema,
      "properties", "value",
      "properties", "type", "enum"
    )

    if (!value[[property]] %in% value_enum) {
      cli::cli_abort(c(
        "x" = "Argument {.arg value_type} value is invalid.",
        "!" = "Must be {?/one of} {.val {value_enum}}.",
        "i" = "Actual value is {.val {value[[property]]}}"
      ))
    }
  }
}

get_schema_output_type <- function(schema, output_type) {
  purrr::pluck(
    schema,
    "properties", "rounds",
    "items", "properties", "model_tasks",
    "items", "properties", "output_type",
    "properties", output_type
  )
}


download_schema <- function(schema_version = "latest", branch = "main",
                            format = c("list", "json")) {
  format <- rlang::arg_match(format)

  # Get the latest version available in our GitHub schema repo
  if (schema_version == "latest") {
    schema_version <- get_schema_valid_versions(branch = branch) %>%
      sort() %>%
      utils::tail(1)
  }

  schema_url <- get_schema_url(
    config = "tasks",
    version = schema_version,
    branch = branch
  )

  schema_json <- get_schema(schema_url)

  switch(format,
    list = jsonlite::fromJSON(schema_json,
      simplifyDataFrame = FALSE
    ),
    json = schema_json
  )
}
