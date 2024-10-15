#' Get and compare hub config schema versions
#'
#' @param config List representation of the JSON config file.
#' @inherit extract_schema_version return
#'
#' @export
#' @describeIn get_version_config Get schema version from config list representation.
#' @examples
#' config <- read_config_file(
#'   system.file("config", "tasks.json", package = "hubUtils")
#' )
#' get_version_config(config)
get_version_config <- function(config) {
    schema_version <- config$schema_version
    if (is.null(schema_version)) {
        cli::cli_abort(c("x" = "No {.field schema_version} property found in {.arg config}."))
    }
    extract_schema_version(config$schema_version)
}

#' @inheritParams read_config_file
#' @export
#' @describeIn get_version_config Get schema version from config file at specific path.
#'
#' @examples
#' config_path <- system.file("config", "tasks.json", package = "hubUtils")
#' get_version_file(config_path)
get_version_file <- function(config_path) {
    checkmate::assert_file_exists(config_path)
    read_config_file(config_path) |>
        get_version_config()
}

#' @inheritParams read_config
#' @export
#' @describeIn get_version_config Get schema version from config file at specific path.
#'
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' get_version_hub(hub_path)
#' get_version_hub(hub_path, "admin")
get_version_hub <- function(hub_path, config = c("tasks", "admin")) {
    config <- rlang::arg_match(config)
    read_config(hub_path, config) |>
        get_version_config()
}
