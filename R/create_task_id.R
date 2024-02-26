#' #' Create an object of class `task_id`
#'
#' Create a representation of a task ID item as a list object of
#' class `task_id`. This can be combined with
#' additional `task_id` objects using function [`create_task_ids()`] to
#' create a `task_ids` class object for a given model_task.
#' Such building blocks can ultimately be combined and then written out as or
#' appended to `tasks.json` Hub config files.
#' @param name character string, Name of task_id to create.
#' @param required Atomic vector of required task_id values. Can be `NULL` if all
#'   values are optional.
#' @param optional Atomic vector of optional task_id values. Can be `NULL` if all
#'   values are required.
#' @param schema_version Character string specifying the json schema version to
#'   be used for validation. The default value `"latest"` will use the latest version
#'   available in the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#'   Alternatively, a specific version of a schema (e.g. `"v0.0.1"`)  can be
#'   specified.
#' @details `required` and `optional` vectors for standard task_ids defined in a Hub schema
#' must match data types and formats specified in the schema. For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file)
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
#' Task_ids that represent dates must be supplied as character strings in ISO 8601
#' date format (YYYY-MM-DD). If working with date objects, please convert to character
#' (e.g. using `as.character()`) before supplying as arguments.
#'
#' Task_ids not present in the schema are allowed as additional properties but the
#' user is responsible for providing values of the correct data type.
#'
#' @inheritParams validate_config
#' @seealso [create_task_ids()]
#' @return a named list of class `task_id` representing a task ID.
#' @export
#'
#' @examples
#' create_task_id("horizon", required = 1L, optional = 2:4)
create_task_id <- function(name, required, optional,
                           schema_version = "latest", branch = "main") {
  checkmate::assert_character(name, len = 1L)
  rlang::check_required(required)
  rlang::check_required(optional)
  call <- rlang::current_env()

  schema <- download_tasks_schema(schema_version, branch)

  task_ids_schema <- get_schema_task_ids(schema)
  schema_task_ids <- names(task_ids_schema$properties)

  name <- match_element_name(
    name,
    schema_task_ids,
    element = "task_id"
  )

  if (name %in% schema_task_ids) {
    task_id_schema <- purrr::pluck(
      task_ids_schema,
      "properties",
      name,
      "properties"
    )

    purrr::walk(
      c("required", "optional"),
      function(.x) {
        check_input(
          input = get(.x),
          property = .x,
          task_id_schema,
          parent_property = NULL,
          call = call
        )
      }
    )
  }

  check_prop_not_all_null(required, optional)
  check_prop_type_const(required, optional)
  check_prop_dups(required, optional)

  structure(
    list(list(
      required = required,
      optional = optional
    )),
    class = c("task_id", "list"),
    names = name,
    schema_id = schema$`$id`
  )
}

get_schema_task_ids <- function(schema) {
  purrr::pluck(
    schema,
    "properties", "rounds",
    "items", "properties", "model_tasks",
    "items", "properties", "task_ids"
  )
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

  if (length(prop_types) != 1L && !"NULL" %in% prop_types) {
    cli::cli_abort(c(
      "x" = "Arguments {.arg required} and {.arg optional}
              must be of same type.",
      "i" = "{.arg required} is {.cls {typeof(required)}}",
      "i" = "{.arg optional} is {.cls {typeof(optional)}}"
    ))
  }
}
