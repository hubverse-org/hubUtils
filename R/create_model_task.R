#' Create an object of class `model_task`
#'
#' Create an object of class `model_task` representing a model task. Multiple
#' model tasks can be combined using function [`create_model_tasks()`].
#' @param task_ids object of class `model_task`.
#' @param output_type object of class `output_type`.
#' @param target_metadata object of class `target_metadata`.
#'
#' @return a named list of class `model_task`.
#' @export
#' @seealso [create_task_ids()], [create_output_type()], [create_target_metadata()],
#' [`create_model_tasks()`]
#'
#' @examples
#' create_model_task(
#'   task_ids = create_task_ids(
#'     create_task_id("origin_date",
#'       required = NULL,
#'       optional = c(
#'         "2023-01-02",
#'         "2023-01-09",
#'         "2023-01-16"
#'       )
#'     ),
#'     create_task_id("location",
#'       required = "US",
#'       optional = c("01", "02", "04", "05", "06")
#'     ),
#'     create_task_id("horizon",
#'       required = 1L,
#'       optional = 2:4
#'     )
#'   ),
#'   output_type = create_output_type(
#'     create_output_type_mean(
#'       is_required = TRUE,
#'       value_type = "double",
#'       value_minimum = 0L
#'     )
#'   ),
#'   target_metadata = create_target_metadata(
#'     create_target_metadata_item(
#'       target_id = "inc hosp",
#'       target_name = "Weekly incident influenza hospitalizations",
#'       target_units = "rate per 100,000 population",
#'       target_keys = NULL,
#'       target_type = "discrete",
#'       is_step_ahead = TRUE,
#'       time_unit = "week"
#'     )
#'   )
#' )
create_model_task <- function(task_ids, output_type, target_metadata) {
  rlang::check_required(task_ids)
  rlang::check_required(output_type)
  rlang::check_required(target_metadata)

  call <- rlang::current_call()

  purrr::walk(
    c(
      "task_ids",
      "output_type",
      "target_metadata"
    ),
    ~ check_object_class(get(.x), .x,
      call = call
    )
  )

  schema_id <- check_schema_ids(
    list(
      task_ids,
      output_type,
      target_metadata
    ),
    call = call
  )

  check_target_key_valid(target_metadata, task_ids, call)

  structure(
    c(
      task_ids,
      output_type,
      target_metadata
    ),
    class = c("model_task", "list"),
    schema_id = schema_id
  )
}


check_target_key_valid <- function(target_metadata, task_ids,
                                   call = rlang::caller_env()) {
  target_keys <- purrr::map(
    target_metadata[[1]],
    ~ .x[["target_keys"]]
  )

  if (all(purrr::map_lgl(target_keys, ~ is.null(.x)))) {
    return()
  }

  target_keys_names <- purrr::map_chr(target_keys, ~ names(.x)) %>%
    unique()

  task_id_names <- names(task_ids[[1]])

  invalid_target_key_names <- !target_keys_names %in% task_id_names

  if (any(invalid_target_key_names)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_metadata} {.field target_keys names} must
              match valid {.arg task_ids} {.field property names}:
        {.val {task_id_names}}",
        "x" = "{.field target_keys} name{?s}
        {.val {target_keys_names[invalid_target_key_names]}} do{?es/} not."
      ),
      call = call
    )
  }
  purrr::walk(
    target_keys_names,
    ~ check_task_id_target_key_values(.x,
      task_ids,
      target_keys,
      call = call
    )
  )
}


check_object_class <- function(object, class, call = rlang::caller_env()) {
  if (!inherits(object, class)) {
    cli::cli_abort(
      c("x" = "{.arg {class}} must inherit from class {.cls {class}} but does not"),
      call = call
    )
  }
}


check_task_id_target_key_values <- function(target_key_name, task_ids, # nolint: object_length_linter
                                            target_keys, call = rlang::caller_env()) {
  task_id_values <- unlist(task_ids$task_ids[[target_key_name]]) %>%
    unique() %>%
    sort()

  target_key_values <- purrr::map_chr(
    target_keys,
    ~ .x[[target_key_name]]
  ) %>%
    unique() %>%
    sort()


  if (any(task_id_values != target_key_values)) {
    cli::cli_abort(
      c(
        "x" = "{.arg task_ids} {.field {target_key_name}} values must match
              {.arg target_metadata} {.arg target_keys} definitions.",
        ">" = "{.arg target_keys} {.field {target_key_name}} values:
            {.val {target_key_values}}",
        ">" = "{.arg task_ids} {.field {target_key_name}} values:
            {.val {task_id_values}}"
      ),
      call = call
    )
  }
}
