#' Create an object of class `target_metadata_item`
#'
#' Create a representation of a target_metadata item as a list object of
#' class `target_metadata_item`. This can be combined with
#' additional target_metadata items using function [`create_target_metadata()`] to
#' create a target_metadata object for a given model_task.
#' Such building blocks can ultimately be combined and then written out as or
#' appended to `tasks.json` Hub config files.
#' @param target_id character string. Short description that uniquely identifies
#' the target.
#' @param target_name character string. A longer human readable target description
#' that could be used, for example, as a visualisation axis label.
#' @param target_units character string. Unit of observation of the target.
#' @param target_keys named list or `NULL`. Should be `NULL`, in the case
#' where the target is not specified as a task_id but is specified solely through
#' the `target_id` argument. Otherwise, should be a named list of one or more
#' character strings. The name of each element should match a task_id variable
#' within the same model_tasks object. Each element should be of length 1.
#' Each value, or the combination of values if multiple keys are specified,
#' define a single target value.
#' @param description character string (optional). An optional verbose description
#' of the target that might include information such as definitions of a 'rate' or similar.
#' @param target_type character string. Target statistical data type. Consult the
#' [appropriate version of the hub schema](
#' https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#model-tasks-tasks-json-interactive-schema)
#' for potential values.
#' @param is_step_ahead logical. Whether the target is part of a sequence of values
#' @param time_unit character string. If `is_step_ahead` is `TRUE`, then this
#' argument is required and defines the unit of time steps. if `is_step_ahead` is
#' `FALSE`, then this argument is not required and will be ignored if given.
#' @inheritParams create_task_id
#' @seealso [create_target_metadata()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#' @return a named list of class `target_metadata_item`.
#' @export
#'
#' @examples
#' create_target_metadata_item(
#'   target_id = "inc hosp",
#'   target_name = "Weekly incident influenza hospitalizations",
#'   target_units = "rate per 100,000 population",
#'   target_keys = list(target = "inc hosp"),
#'   target_type = "discrete",
#'   is_step_ahead = TRUE,
#'   time_unit = "week"
#' )
create_target_metadata_item <- function(target_id, target_name, target_units,
                                        target_keys = NULL, description = NULL,
                                        target_type, is_step_ahead, time_unit = NULL,
                                        schema_version = "latest", branch = "main") {
  rlang::check_required(target_id)
  rlang::check_required(target_name)
  rlang::check_required(target_units)
  rlang::check_required(target_keys)
  rlang::check_required(target_type)
  rlang::check_required(is_step_ahead)
  call <- rlang::current_env()

  schema <- download_tasks_schema(schema_version, branch)
  target_metadata_schema <- get_schema_target_metadata(schema)


  if (is.null(description)) {
    property_names <- c(
      "target_id", "target_name", "target_units",
      "target_keys", "target_type", "is_step_ahead"
    )
  } else {
    property_names <- c(
      "target_id", "target_name", "target_units",
      "target_keys", "description", "target_type",
      "is_step_ahead"
    )
  }

  if (is_step_ahead) {
    if (is.null(time_unit)) {
      cli::cli_abort(c(
        "!" = "A value must be provided for {.arg time_unit} when {.arg is_step_ahead}
            is {.val {TRUE}}"
      ))
    }
    property_names <- c(property_names, "time_unit")
  }

  purrr::walk(
    property_names[property_names != "target_keys"],
    function(.x) {
      check_input(
        input = get(.x),
        property = .x,
        target_metadata_schema,
        parent_property = NULL,
        scalar = TRUE,
        call = call
      )
    }
  )

  check_target_keys(target_keys, call = call)

  structure(mget(property_names),
    class = c("target_metadata_item", "list"),
    names = property_names,
    schema_id = schema$`$id`
  )
}

check_target_keys <- function(target_keys, call = rlang::caller_env()) {
  if (is.null(target_keys)) {
    return()
  }

  if (!rlang::is_list(target_keys) || inherits(target_keys, "data.frame")) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} must be a {.cls list} not a
            {.cls {class(target_keys)}}"
      ),
      call = call
    )
  }
  if (!rlang::is_named(target_keys)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} must be a named {.cls list}."
      ),
      call = call
    )
  }

  purrr::walk2(
    target_keys,
    names(target_keys),
    ~ check_target_key_value(
      .x, .y,
      call = call
    )
  )
}


check_target_key_value <- function(target_key, target_key_name,
                                   call = rlang::caller_env()) {
  if (!rlang::is_character(target_key, n = 1)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} element {.field {target_key_name}} must be
            a {.cls character} vector of length {.val {1L}} not a
            {.cls {class(target_key)}} vector of length
            {.val {length(target_key)}}"
      ),
      call = call
    )
  }
}

get_schema_target_metadata <- function(schema) {
  purrr::pluck(
    schema,
    "properties", "rounds",
    "items", "properties", "model_tasks",
    "items", "properties", "target_metadata",
    "items", "properties"
  )
}
