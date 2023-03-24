#' Create a point estimate output type object of class `output_type_item`
#'
#' Create a representation of a `mean` or `median` output type as a list object of
#' class `output_type_item`. This can be combined with
#' additional `output_type_item` objects using function [`create_output_type()`] to
#' create an `output_type` object for a given modelling_task item.
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
        ~ check_input(
            input = value[[.x]],
            property = .x,
            output_type_schema,
            parent_property = "value",
            scalar = TRUE,
            call = rlang::caller_env(n = 5)
        )
    )

    structure(
        list(c(type_id, list(value = value))),
        class = c("output_type_item", "list"),
        names = output_type,
        schema_id = schema$`$id`)
}


#' Create a distribution output type object of class `output_type_item`
#'
#' Create a representation of a `quantile`, `cdf`, `categorical` or `sample` output
#' type as a list object of class `output_type_item`. This can be combined with
#' additional `output_type_item`s using function [`create_output_type()`] to
#' create an `output_type` object for a given modelling_task item.
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
#' `cdf`, `categorical` or `sample` output type.
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
                output_type_schema,
                call = rlang::caller_env(n = 5)
            )
        )
    } else {
        purrr::walk(
            c("required", "optional"),
            ~ check_input(
                input = get(.x),
                property = .x,
                output_type_schema,
                parent_property = "type_id",
                call = rlang::caller_env(n = 5)
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
        ~ check_input(
            input = value[[.x]],
            property = .x,
            output_type_schema,
            parent_property = "value",
            scalar = TRUE,
            call = rlang::caller_env(n = 5)
        )
    )

    structure(
        list(c(type_id, list(value = value))),
        class = c("output_type_item", "list"),
        names = output_type,
        schema_id = schema$`$id`)
}

check_input <- function(input, property, output_type_schema,
                        parent_property,
                        scalar = FALSE,
                        call = rlang::caller_env()) {

    property_name <- property
    if (!is.null(parent_property) && parent_property == "value") {
        property_name <- paste0("value_", property)
    }

    if (is.null(parent_property)) {
        property_schema <- purrr::pluck(
            output_type_schema,
            "properties", property
        )
    } else {
        property_schema <- purrr::pluck(
            output_type_schema,
            "properties",
            parent_property,
            "properties", property
        )
    }

    if (is.null(input)) {
        property_types <- property_schema[["type"]]
        if (!"null" %in% property_types) {
            cli::cli_abort(c("x" = "Argument {.arg {property_name}} cannot be NULL."),
                           call = call
            )
        } else {
            return()
        }
    }
    if (!is.atomic(input) | is.pairlist(input)) {
        cli::cli_abort(c("x" = "Argument {.arg {property_name}} must be an atomic vector."),
                       call = call
        )
    }

    if (is.factor(input)) {
        cli::cli_abort(c("x" = "Argument {.arg {property_name}} cannot be of class
                     {.cls factor}."),
                     call = call
        )
    }

    if (scalar) {
        if (length(input) != 1L) {
            cli::cli_abort(c(
                "x" = "Argument {.arg {property_name}} must be length {.val {1}},
          not {.val {length(input)}}."
            ),
          call = call
            )
        }
    }

    if (any(names(property_schema) == "maxItems")) {
        if (scalar) {
            max_items <- 1
        } else {
            max_items <- property_schema[["maxItems"]]
        }
        is_invalid <- length(input) > max_items
        if (is_invalid) {
            cli::cli_abort(c(
                "x" = "Argument {.arg {property_name}} must be of length equal to or less than
                {.val {max_items}} but is of length {.val {length(input)}}."
            ),
            call = call
            )
        }
    }
    if (any(names(property_schema) == "minItems")) {
        min_items <- property_schema[["minItems"]]
        is_invalid <- length(input) < min_items
        if (is_invalid) {
            cli::cli_abort(c(
                "x" = "Argument {.arg {property_name}} must be of length equal to or greater
                than {.val {min_items}} but is of length {.val {length(input)}}."
            ),
            call = call
            )
        }
    }

    if (any(names(property_schema) == "uniqueItems")) {
        unique_items <- property_schema[["uniqueItems"]]
        if (unique_items & any(duplicated(input))) {
            duplicates <- input[duplicated(input)]
            cli::cli_abort(c(
                "!" = "All values in argument {.arg {property_name}} must be unique.",
                "x" = "{cli::qty(sum(duplicates))} Value{?s} {.val {duplicates}}
        {cli::qty(sum(duplicates))} {?is/are} duplicated."
            ),
        call = call
            )
        }
    }

    # Array item validation
    if (scalar) {
        value_schema <- property_schema
    } else {
        value_schema <- property_schema[["items"]]
    }

    input_type <- typeof(input)
    value_formats <- value_schema[["format"]]
    # Handle situation where type must be missing but can be inferred from `const` or
    # `enum` properties. Clunky but included for back compatibility.
    if (any(names(value_schema) == "type")) {
        value_types <- json_datatypes[value_schema[["type"]]]
    } else {
        if (any(names(value_schema) == "enum")) {
            value_types <- typeof(value_schema[["enum"]])
        } else if (any(names(value_schema) == "const")) {
            value_types <- typeof(value_schema[["const"]])
        } else {
            cli::cli_abort(c(
                "x" = "Invalid schema. Cannot determine appropriate type for argument
        {.arg {property_name}}.
        Please open an issue at
        {.url https://github.com/Infectious-Disease-Modeling-Hubs/schemas/issues}"
            ),
        call = call
            )
        }
    }

    if (!is.null(value_formats) &&
        value_formats == "date" &&
        anyNA(as.Date(input, format = "%Y-%m-%d"))
    ) {
        cli::cli_abort(c("x" = "Argument {.arg {property_name}} must be valid ISO 8601
                         date format (YYYY-MM-DD)."),
                       call = call
        )
    }

    if (!input_type %in% value_types) {
        cli::cli_abort(c(
            "x" = "Argument {.arg {property_name}} is of type {.cls {input_type}}.",
            "!" = "Must be {?/one of} {.cls {value_types}}."
        ),
        call = call
        )
    }

    if (any(names(value_schema) == "maximum")) {
        value_max <- value_schema[["maximum"]]
        is_invalid <- input > value_max
        if (any(is_invalid)) {
            cli::cli_abort(c(
                "!" = "All values in argument {.arg {property_name}} must be equal to or less
                than {.val {value_max}}.",
                "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} greater."
            ),
            call = call
            )
        }
    }

    if (any(names(value_schema) == "minimum")) {
        value_min <- value_schema[["minimum"]]
        is_invalid <- input < value_min
        if (any(is_invalid)) {
            cli::cli_abort(c(
                "!" = "All values in argument {.arg {property_name}} must be equal to or greater
                than {.val {value_min}}.",
                "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} less."
            ),
            call = call
            )
        }
    }

    if (any(names(value_schema) == "enum")) {
        if (any(!input %in% value_schema[["enum"]])) {
            invalid_values <- input[!input %in% value_schema[["enum"]]]
            cli::cli_abort(c(
                "x" = "{.arg {property_name}} {cli::qty(length(invalid_values))}
        value{?s} {?is/are} invalid.",
        "!" = "Must be {cli::qty(if(scalar){1}else{2})} {?one of/member in}
        {.val {value_schema[['enum']]}}.",
        "i" = "Actual value{?s} {?is/are} {.val {invalid_values}}"
            ),
        call = call
            )
        }
    }

    if (any(names(value_schema) == "const")) {
        value_const <- value_schema[["const"]]
        if (any(input != value_const)) {
            cli::cli_abort(c(
                "x" = "Argument {.arg {property_name}} value is invalid.",
                "!" = "Must be {.val {value_const}}.",
                "i" = "Actual value is {.val {input}}"
            ),
            call = call
            )
        }
    }

    if (any(names(value_schema) == "minLength")) {
        is_invalid <- stringr::str_length(input) < value_schema[["minLength"]]
        if (any(is_invalid)) {
            cli::cli_abort(c(
                "!" = "The minimum number of characters allowed for values in
                argument {.arg {property_name}} is {.val {value_schema[['minLength']]}}.",
                "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                fewer characters than allowed."
            ),
            call = call
            )
        }
    }

    if (any(names(value_schema) == "maxLength")) {
        is_invalid <- stringr::str_length(input) > value_schema[["maxLength"]]
        if (any(is_invalid)) {
            cli::cli_abort(c(
                "!" = "The maximum number of characters allowed for values in
                argument {.arg {property_name}} is {.val {value_schema[['maxLength']]}}.",
                "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                more characters than allowed"
            ),
            call = call
            )
        }
    }


    if (any(names(value_schema) == "multipleOf")) {
        is_invalid <- input %% value_schema[["multipleOf"]] != 0L
        if (any(is_invalid)) {
            cli::cli_abort(c(
                "!" = "Values in argument {.arg {property_name}} must be multiples of
                {.val {value_schema[['multipleOf']]}}.",
                "x" = "{cli::qty(sum(is_invalid))} Value{?s}
                {.val {input[is_invalid]}} {cli::qty(sum(is_invalid))} {?is/are} not."
            ),
            call = call
            )
        }
    }
}


check_oneof_input <- function(input, property = c("required", "optional"),
                              output_type_schema,
                              call = rlang::caller_env()) {
    property_schema <- purrr::pluck(
        output_type_schema,
        "properties",
        "type_id",
        "properties", property
    )

    if (is.null(input)) {
        property_types <- property_schema[["type"]]
        if (!"null" %in% property_types) {
            cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be NULL."),
                           call = call)
        } else {
            return()
        }
    }
    if (!is.atomic(input) | is.pairlist(input)) {
        cli::cli_abort(c("x" = "Argument {.arg {property}} must be an atomic vector."),
                       call = call)
    }

    if (is.factor(input)) {
        cli::cli_abort(c("x" = "Argument {.arg {property}} cannot be of class {.cls factor}."),
                       call = call)
    }

    oneof_schema <- property_schema[["items"]][["oneOf"]]

    names(oneof_schema) <- json_datatypes[
        purrr::map_chr(
            oneof_schema,
            ~ .x$type
        )
    ]


    value_types <- c("character", "double", "integer")
    input_type <- typeof(input)
    if (!input_type %in% value_types) {
        cli::cli_abort(c(
            "x" = "Argument {.arg {property}} is of type {.cls {input_type}}.",
            "!" = "Must be {?/one of} {.cls {value_types}}."
        ),
        call = call)
    }

    if (typeof(input) == "character") {
        value_schema <- oneof_schema[["character"]]
        if (!any((grepl(value_schema[["pattern"]], input)))) {
            cli::cli_abort(c(
                "x" = "Values of argument {.arg {property}} must match regex pattern
             {.val {value_schema[['pattern']]}}.",
             "!" = 'Values {.val {!(grepl(value_schema[["pattern"]], input))}} do not.'
            ),
            call = call)
        }

        is_too_long <- stringr::str_length(input) > value_schema[["maxLength"]]
        if (any(is_too_long)) {
            cli::cli_abort(c(
                "!" = "The maximum number of characters allowed for values in
                argument {.arg {property}} is {.val {value_schema[['maxLength']]}}.",
                "x" = "Value{?s} {.val {input[is_too_long]}} {?has/have}
                more characters than allowed"
            ),
            call = call)
        }

        is_too_short <- stringr::str_length(input) < value_schema[["minLength"]]
        if (any(is_too_short)) {
            cli::cli_abort(c(
                "!" = "The minimum number of characters allowed for values in
                argument {.arg {property}} is {.val {value_schema[['minLength']]}}.",
                "x" = "Value{?s} {.val {input[is_too_short]}} {?has/have}
                fewer characters than allowed."
            ),
            call = call)
        }
    }

    if (typeof(input) %in% c("double", "integer")) {
        value_schema <- oneof_schema[["double"]]
        value_min <- value_schema[["minimum"]]
        is_too_small <- input < value_min
        if (any(is_too_small)) {
            cli::cli_abort(c(
                "!" = "All values in argument {.arg {property}} must be greater
                than {.val {value_min}}.",
                "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} equal to or less."
            ),
            call = call)
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
