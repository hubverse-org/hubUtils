#' Is config list representation using v3.0.0 schema?
#'
#' @param config List representation of the JSON config file.
#'
#' @return Logical, whether the config list representation is using v3.0.0 schema.
#' @export
#'
#' @examples
#' config <- read_config_file(
#'   system.file("config", "tasks.json", package = "hubUtils")
#' )
#' is_v3_config(config)
is_v3_config <- function(config) {
  checkmate::assert_list(config)
  extract_schema_version(config$schema_version) == "v3.0.0"
}

#' Is config file using v3.0.0 schema?
#'
#' @param config_path Path to the config file.
#'
#' @return Logical, whether the config file is using v3.0.0 schema.
#' @export
#'
#' @examples
#' config_path <- system.file("config", "tasks.json", package = "hubUtils")
#' is_v3_config_file(config_path)
is_v3_config_file <- function(config_path) {
  checkmate::assert_file_exists(config_path)
  config <- read_config_file(config_path)
  extract_schema_version(config$schema_version) == "v3.0.0"
}

#' Is hub configured using v3.0.0 schema?
#'
#' @inheritParams read_config
#'
#' @return Logical, whether the hub is configured using v3.0.0 schema.
#' @export
#'
#' @examples
#' is_v3_hub(hub_path = system.file("testhubs", "flusight", package = "hubUtils"))
is_v3_hub <- function(hub_path, config = c("tasks", "admin")) {
  config <- rlang::arg_match(config)
  read_config(hub_path, config = config) %>%
    is_v3_config()
}
