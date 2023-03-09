#' Create a task_id element
#'
#' Create a list representation of a task ID. This can be combined with other building
#' blocks which can then be written as or appended to `tasks.json` Hub config files.
#' @param name character string, Name of task_id to create.
#' @param required Atomic vector of required task_id values. Can be `NULL` if all
#'   values are optional.
#' @param optional Atomic vector of optional task_id values. Can be `NULL` if all
#'   values are required.
#' @details `required` and `optional` vectors for standard task_ids defined in a Hub schema
#' must match data types and formats specified in the schema. For more details consult
#' the [documentation on `tasks.json` Hub config files](https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file)
#'
#' JSON schema data type names differ to those in R. Use the following mappings to
#' create vectors of appropriate data types which will correspond to correct JSON
#' schema data types during config file validation.
#'
#' ```{r, echo = FALSE}
#' knitr::kable(data.frame(json = names(json_datatypes),
#'            R = json_datatypes,
#'            row.names = NULL))
#' ```
#' Values across `required` and `optional` arguments must be unique. `required`
#' and `optional` must be of the same type (unless `NULL`) and both cannot be `NULL`.
#' Task_ids that represent dates must be supplied in ISO 8601
#' date format (YYYY-MM-DD).
#'
#' Task_ids not present in the schema are allowed as additional properties but the
#' user is responsible for providing values of the correct data type.
#'
#' @inheritParams validate_config
#'
#' @return a named list representing a task ID.
#' @export
#'
#' @examples
#' create_task_id("horizon", required = 1L, optional = 2:4)
create_task_id <- function(name, required, optional,
                           schema_version = "latest", branch = "main") {
  checkmate::assert_character(name, len = 1L)
  rlang::check_required(required)
  rlang::check_required(optional)

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
  schema <- jsonlite::fromJSON(schema_json,
    simplifyDataFrame = FALSE
  )

  task_ids <- get_schema_task_ids(schema)

  name <- match_element_name(
    name,
    names(task_ids),
    element = "task_id"
  )

  if (name %in% names(task_ids)) {
    purrr::walk(
      c("required", "optional"),
      ~ check_task_id_input(
        input = get(.x),
        task_id = task_ids[[name]],
        .x
      )
    )
  }

  check_prop_not_all_null(required, optional)
  check_prop_type_const(required, optional)
  check_prop_dups(required, optional)

  list(list(
    required = required,
    optional = optional
  )) %>%
    stats::setNames(name)
}

get_schema_task_ids <- function(schema) {
  schema$properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties
}


match_element_name <- function(name, element_names,
                               element = c("task_id", "output_type")) {
  matched_name <- utils::head(agrep(name, element_names, value = TRUE), 1)
  if (length(matched_name) == 1L && matched_name != name) {
    ask <- utils::askYesNo(ask_msg(name, matched_name, element),
      prompts = "Y/N/C"
    )

    if (is.na(ask)) stop()
    if (element != "task_id" && !ask) stop()

    if (ask) {
      name <- matched_name
    }
  }

  name
}

ask_msg <- function(name, matched_name, element = c("task_id", "output_type")) {
  cli::cli_div()
  cli::cli_text(
    c(
      "Argument {.arg name} value {.val {name}} does not match any
          {.field {element}} names in schema. ",
      "Did you mean {.val {matched_name}}?"
    )
  )

  cli::cli_ul(c(
    "Type {.code Y} to use {.val {matched_name}}.",
    if (element == "task_id") {
      "Type {.code N} to continue with {.val {name}}."
    } else {
      "Type {.code N} or {.code C} to cancel:"
    },
    if (element == "task_id") {
      "Type {.code C} to cancel:"
    } else {
      NULL
    }
  ))
  cli::cli_end()
}


check_task_id_input <- function(input, task_id, property = c(
                                  "required",
                                  "optional"
                                )) {
  property_types <- task_id$properties[[property]]$type

  if (is.null(input)) {
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

  item_types <- json_datatypes[task_id$properties[[property]]$items$type]
  item_formats <- task_id$properties[[property]]$items$format

  if (!is.null(item_formats) &&
    item_formats == "date" &&
    anyNA(as.Date(input, format = "%Y-%m-%d"))
  ) {
    cli::cli_abort(c("x" = "Argument {.arg {property}} must be valid ISO 8601 date format (YYYY-MM-DD)."))
  }

  input_type <- typeof(input)

  if (!input_type %in% item_types) {
    cli::cli_abort(c(
      "x" = "Argument {.arg {property}} is of type {.cls {input_type}}.",
      "!" = "Must be {?/one of} {.cls {item_types}}."
    ))
  }
}

check_prop_not_all_null <- function(required, optional) {
  if (all(is.null(required), is.null(optional))) {
    cli::cli_abort(c("x" = "Both arguments {.arg required} and {.arg optional}
              cannot be NULL."))
  }
}

check_prop_dups <- function(required, optional) {
  duplicates <- duplicated(c(required, optional))

  if (any(duplicates)) {
    cli::cli_abort(
      c(
        "x" = "Values across arguments {.arg required} and {.arg optional}
              must be unique.",
        "!" = "Provided {cli::qty(sum(duplicates))} value{?s}
              {.val {c(required, optional)[duplicates]}}
              {cli::qty(sum(duplicates))} {?is/are} duplicated."
      )
    )
  }
}

check_prop_type_const <- function(required, optional) {
  prop_types <- purrr::map_chr(
    c(required, optional),
    ~ typeof(.x)
  ) %>%
    unique()

  if (length(prop_types) != 1L & !"NULL" %in% prop_types) {
    cli::cli_abort(c(
      "x" = "Arguments {.arg required} and {.arg optional}
              must be of same type.",
      "i" = "{.arg required} is {.cls {typeof(required)}}",
      "i" = "{.arg optional} is {.cls {typeof(optional)}}"
    ))
  }
}
