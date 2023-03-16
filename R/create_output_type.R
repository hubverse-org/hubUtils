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
                                     branch = "main") {
  rlang::check_required(value_type)
  rlang::check_required(is_required)

  if (!rlang::is_logical(is_required, n = 1L)) {
    cli::cli_abort(c(
      "x" = "Argument {.arg is_required} must be {.cls logical} and have length 1."
    ))
  }
  output_type <- rlang::arg_match(output_type)


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

  output_type_schema <- get_schema_output_type(schema,
    output_type = output_type
  )

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
    stats::setNames(output_type)
}


#' Create a distribution `output_type` element
#'
#' Create a list representation of a `quantile`, `cdf`, `categorical` or `sample`
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
#' @return a named list representing a `quantile`, `cdf`, `categorical` or `sample` output type.
#' @export
#' @describeIn create_output_type_quantile Create a list representation of a `quantile`
#' output type.
#'
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
#' create_output_type_categorical(
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

#' @describeIn create_output_type_quantile Create a list representation of a `categorical`
#' output type.
#' @export
create_output_type_categorical <- function(required, optional, value_type,
                                           schema_version = "latest",
                                           branch = "main") {
  create_output_type_dist(
    output_type = "categorical", required = required, optional = optional,
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
                                      "quantile", "cdf", "categorical",
                                      "sample"
                                    ),
                                    required, optional,
                                    value_type, value_minimum = NULL,
                                    value_maximum = NULL, schema_version = "latest",
                                    branch = "main") {
  rlang::check_required(value_type)
  rlang::check_required(required)
  rlang::check_required(optional)
  output_type <- rlang::arg_match(output_type)


  schema <- download_schema(schema_version, branch)
  output_type_schema <- get_schema_output_type(schema, output_type)

  # Check and create type_id
  if (output_type == "cdf") {
    purrr::walk(
      c("required", "optional"),
      ~ check_oneof_input(
        input = get(.x),
        property = .x,
        output_type_schema
      )
    )
  } else {
    purrr::walk(
      c("required", "optional"),
      ~ check_array_input(
        input = get(.x),
        property = .x,
        output_type_schema
      )
    )
  }

  check_prop_not_all_null(required, optional)
  check_prop_type_const(required, optional)
  check_prop_dups(required, optional)

  type_id <- list(type_id = list(
    required = required,
    optional = optional
  ))

  # Check and create value
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
    stats::setNames(output_type)
}

check_array_input <- function(input, property = c("required", "optional"),
                              output_type_schema) {
  array_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "type_id",
    "properties", property
  )

  if (is.null(input)) {
    property_types <- array_schema[["type"]]
    if (!"null" %in% property_types) {
      cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be NULL."))
    } else {
      return()
    }
  }
  if (!is.atomic(input) | is.pairlist(input)) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} must be an atomic vector."))
  }

  if (is.factor(input)) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be of class {.cls factor}."))
  }
  if (any(names(array_schema) == "maxItems")) {
    max_items <- array_schema[["maxItems"]]
    is_invalid <- length(input) > max_items
    if (is_invalid) {
      cli::cli_abort(c(
        "x" = "Argument {.arg {property}} must be of length equal to or less than
                {.val {max_items}} but is of length {.val {length(input)}}."
      ))
    }
  }
  if (any(names(array_schema) == "minItems")) {
    min_items <- array_schema[["minItems"]]
    is_invalid <- length(input) < min_items
    if (is_invalid) {
      cli::cli_abort(c(
        "x" = "Argument {.arg {property}} must be of length equal to or greater
                than {.val {min_items}} but is of length {.val {length(input)}}."
      ))
    }
  }

  # Array item validation
  items_schema <- array_schema[["items"]]

  input_type <- typeof(input)
  item_types <- json_datatypes[items_schema[["type"]]]
  item_formats <- items_schema[["format"]]

  if (!is.null(item_formats) &&
    item_formats == "date" &&
    anyNA(as.Date(input, format = "%Y-%m-%d"))
  ) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} must be valid ISO 8601
                         date format (YYYY-MM-DD)."))
  }

  if (!input_type %in% item_types) {
    cli::cli_abort(c(
      "x" = "Argument {.arg {property}} is of type {.cls {input_type}}.",
      "!" = "Must be {?/one of} {.cls {item_types}}."
    ))
  }

  if (any(names(items_schema) == "maximum")) {
    item_max <- items_schema[["maximum"]]
    is_invalid <- input > item_max
    if (any(is_invalid)) {
      cli::cli_abort(c(
        "!" = "All values in argument {.arg {property}} must be equal to or less
                than {.val {item_max}}.",
        "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} greater."
      ))
    }
  }

  if (any(names(items_schema) == "minimum")) {
    item_min <- items_schema[["minimum"]]
    is_invalid <- input < item_min
    if (any(is_invalid)) {
      cli::cli_abort(c(
        "!" = "All values in argument {.arg {property}} must be equal to or greater
                than {.val {item_min}}.",
        "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} less."
      ))
    }
  }

  if (any(names(items_schema) == "enum")) {
    if (any(!input %in% items[["enum"]])) {
      invalid_values <- input[!input %in% items[["enum"]]]
      cli::cli_abort(c(
        "!" = "Values in argument {.arg {property}} must be members in
                set {.val {items[['enum']]}}.",
        "x" = "Value{?s} {.val {invalid_values}} not valid."
      ))
    }
  }

  if (any(names(items_schema) == "minLength")) {
    is_invalid <- stringr::str_length(input) < items_schema[["minLength"]]
    if (any(is_invalid)) {
      cli::cli_abort(c(
        "!" = "The minimum number of characters allowed for values in
                argument {.arg {property}} is {.val {items_schema[['minLength']]}}.",
        "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                fewer characters than allowed."
      ))
    }
  }

  if (any(names(items_schema) == "maxLength")) {
    is_invalid <- stringr::str_length(input) > items_schema[["maxLength"]]
    if (any(is_invalid)) {
      cli::cli_abort(c(
        "!" = "The maximum number of characters allowed for values in
                argument {.arg {property}} is {.val {items_schema[['maxLength']]}}.",
        "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                more characters than allowed"
      ))
    }
  }


  if (any(names(items_schema) == "multipleOf")) {
    is_invalid <- input %% items_schema[["multipleOf"]] != 0L
    if (any(is_invalid)) {
      cli::cli_abort(c(
        "!" = "Values in argument {.arg {property}} must be multiples of
                {.val {items_schema[['multipleOf']]}}.",
        "x" = "{cli::qty(sum(is_invalid))} Value{?s}
                {.val {input[is_invalid]}} {cli::qty(sum(is_invalid))} {?is/are} not."
      ))
    }
  }
}


check_oneof_input <- function(input, property = c("required", "optional"),
                              output_type_schema) {
  array_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "type_id",
    "properties", property
  )

  if (is.null(input)) {
    property_types <- array_schema[["type"]]
    if (!"null" %in% property_types) {
      cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be NULL."))
    } else {
      return()
    }
  }
  if (!is.atomic(input) | is.pairlist(input)) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} must be an atomic vector."))
  }

  if (is.factor(input)) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be of class {.cls factor}."))
  }

  oneof_schema <- array_schema[["items"]][["oneOf"]]

  names(oneof_schema) <- json_datatypes[
    purrr::map_chr(
      oneof_schema,
      ~ .x$type
    )
  ]


  item_types <- c("character", "double", "integer")
  input_type <- typeof(input)
  if (!input_type %in% item_types) {
    cli::cli_abort(c(
      "x" = "Argument {.arg {property}} is of type {.cls {input_type}}.",
      "!" = "Must be {?/one of} {.cls {item_types}}."
    ))
  }

  if (typeof(input) == "character") {
    items_schema <- oneof_schema[["character"]]
    if (!any((grepl(items_schema[["pattern"]], input)))) {
      cli::cli_abort(c(
        "x" = "Values of argument {.arg {property}} must match regex pattern
             {.val {items_schema[['pattern']]}}.",
        "!" = 'Values {.val {!(grepl(items_schema[["pattern"]], input))}} do not.'
      ))
    }

    is_too_long <- stringr::str_length(input) > items_schema[["maxLength"]]
    if (any(is_too_long)) {
      cli::cli_abort(c(
        "!" = "The maximum number of characters allowed for values in
                argument {.arg {property}} is {.val {items_schema[['maxLength']]}}.",
        "x" = "Value{?s} {.val {input[is_too_long]}} {?has/have}
                more characters than allowed"
      ))
    }

    is_too_short <- stringr::str_length(input) < items_schema[["minLength"]]
    if (any(is_too_short)) {
      cli::cli_abort(c(
        "!" = "The minimum number of characters allowed for values in
                argument {.arg {property}} is {.val {items_schema[['minLength']]}}.",
        "x" = "Value{?s} {.val {input[is_too_short]}} {?has/have}
                fewer characters than allowed."
      ))
    }
  }

  if (typeof(input) %in% c("double", "integer")) {
    items_schema <- oneof_schema[["double"]]
    item_min <- items_schema[["minimum"]]
    is_too_small <- input < item_min
    if (any(is_too_small)) {
      cli::cli_abort(c(
        "!" = "All values in argument {.arg {property}} must be greater
                than {.val {item_min}}.",
        "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} equal to or less."
      ))
    }
  }
}

check_value_type <- function(property, value, output_type_schema) {
  property_schema <- purrr::pluck(
    output_type_schema,
    "properties", "value",
    "properties", property
  )

  property_type <- typeof(value[[property]])
  property_value <- value[[property]]

  # Check property type
  if (any(names(property_schema) == "type")) {
    schema_types <- json_datatypes[property_schema[["type"]]]
    if (!property_type %in% schema_types) {
      cli::cli_abort(c(
        "x" = "Argument {.arg value_{property}} is of type {.cls {property_type}}.",
        "!" = "Must be {?/one of} {.cls {schema_types}}."
      ))
    }
  } else {
    if (any(names(property_schema) == "enum")) {
      schema_types <- typeof(property_schema[["enum"]])
      if (!property_type %in% schema_types) {
        cli::cli_abort(c(
          "x" = "Argument {.arg value_{property}} is of type {.cls {property_type}}.",
          "!" = "Must be {?/one of} {.cls {schema_types}}."
        ))
      }
    } else if (any(names(property_schema) == "const")) {
      schema_types <- typeof(property_schema[["const"]])
      if (!property_type %in% schema_types) {
        cli::cli_abort(c(
          "x" = "Argument {.arg value_{property}} is of type {.cls {property_type}}.",
          "!" = "Must be {?/one of} {.cls {schema_types}}."
        ))
      }
    }
  }
  # Check property length
  input_length <- length(value[[property]])

  if (input_length != 1) {
    cli::cli_abort(c(
      "x" = "Argument {.arg value_{property}} must be length {.val {1}},
          not {.val {input_length}}."
    ))
  }

  # Check property values
  if (any(names(property_schema) == "enum")) {
    property_enum <- property_schema[["enum"]]
    if (!property_value %in% property_enum) {
      cli::cli_abort(c(
        "x" = "Argument {.arg value_{property}} value is invalid.",
        "!" = "Must be {?/one of} {.val {property_enum}}.",
        "i" = "Actual value is {.val {property_value}}"
      ))
    }
  }

  if (any(names(property_schema) == "const")) {
    property_const <- property_schema[["const"]]
    if (property_value != property_const) {
      cli::cli_abort(c(
        "x" = "Argument {.arg value_{property}} value is invalid.",
        "!" = "Must be {.val {property_const}}.",
        "i" = "Actual value is {.val {property_value}}"
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
