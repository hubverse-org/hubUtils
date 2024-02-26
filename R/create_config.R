#' Create a `config` class object.
#'
#' Create a representation of a complete `"tasks"` config file as a list object of
#' class `config`. This can be written out to a `tasks.json` file.
#' @param rounds An object of class `rounds` created using function
#' [`create_rounds()`]
#'
#' @return a named list of class `config`.
#' @export
#' @seealso [create_rounds()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://hubdocs.readthedocs.io/en/latest/format/hub-metadata.html#hub-model-task-metadata-tasks-json-file).
#'
#' @examples
#' rounds <- create_rounds(
#'   create_round(
#'     round_id_from_variable = TRUE,
#'     round_id = "origin_date",
#'     model_tasks = create_model_tasks(
#'       create_model_task(
#'         task_ids = create_task_ids(
#'           create_task_id("origin_date",
#'             required = NULL,
#'             optional = c(
#'               "2023-01-02",
#'               "2023-01-09",
#'               "2023-01-16"
#'             )
#'           ),
#'           create_task_id("location",
#'             required = "US",
#'             optional = c("01", "02", "04", "05", "06")
#'           ),
#'           create_task_id("horizon",
#'             required = 1L,
#'             optional = 2:4
#'           )
#'         ),
#'         output_type = create_output_type(
#'           create_output_type_mean(
#'             is_required = TRUE,
#'             value_type = "double",
#'             value_minimum = 0L
#'           )
#'         ),
#'         target_metadata = create_target_metadata(
#'           create_target_metadata_item(
#'             target_id = "inc hosp",
#'             target_name = "Weekly incident influenza hospitalizations",
#'             target_units = "rate per 100,000 population",
#'             target_keys = NULL,
#'             target_type = "discrete",
#'             is_step_ahead = TRUE,
#'             time_unit = "week"
#'           )
#'         )
#'       )
#'     ),
#'     submissions_due = list(
#'       relative_to = "origin_date",
#'       start = -4L,
#'       end = 2L
#'     )
#'   )
#' )
#' create_config(rounds)
create_config <- function(rounds) {
  rlang::check_required(rounds)

  check_object_class(rounds, "rounds")

  structure(
    list(
      schema_version = attr(rounds, "schema_id"),
      rounds = rounds$rounds
    ),
    class = c("config", "list"),
    schema_id = attr(rounds, "schema_id")
  )
}
