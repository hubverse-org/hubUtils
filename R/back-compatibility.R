#' Get the name of the output type id column based on the schema version
#'
#' Version can be provided either directly through the `config_version` argument
#' or extracted from a `config_tasks` object.
#' @inheritParams check_deprecated_schema
#' @inheritParams get_round_idx
#'
#' @return character string of the name of the output type id column
#' @export
#'
#' @examples
#' get_config_tid("v1.0.0")
#' get_config_tid("v2.0.0")
get_config_tid <- function(config_version, config_tasks) {
  tid_check <- check_deprecated_schema( # nolint: object_usage_linter
    config_version = config_version,
    config = config_tasks,
    valid_version = "v2.0.0",
    hubutils_version = "0.0.0.9010"
  )
  if (tid_check) "type_id" else "output_type_id"
}
