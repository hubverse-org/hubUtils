#' Check whether a config file is using a deprecated schema
#'
#'  Function compares the current schema version in a config file to a valid version,
#'  If config file version deprecated compared to valid version, the function
#'  issues a lifecycle warning to prompt user to upgrade.
#'
#' @param config_version Character string of the schema version.
#' @param config List representation of config file.
#' @param valid_version Character string of minimum valid schema version.
#' @param hubutils_version The version of the hubUtils package in which deprecation of
#'  the schema version below `valid_version` is introduced.
#'
#' @return Invisibly, `TRUE` if the schema version is deprecated, `FALSE` otherwise.
#' Primarily used for the side effect of issuing a lifecycle warning.
#' @export
check_deprecated_schema <- function(config_version, config, valid_version = "v2.0.0",
                                    hubutils_version = "0.0.0.9010") {
  checkmate::assert_string(valid_version)
  checkmate::assert_string(hubutils_version)
  version_source <- rlang::check_exclusive(config_version, config)
  config_version <- switch(version_source,
    config = {
      checkmate::assert_list(config)
      checkmate::assert_choice("schema_version", names(config))
      extract_schema_version(config$schema_version)
    },
    config_version = {
      checkmate::assert_string(config_version)
      config_version
    }
  )

  deprecated <- config_version < valid_version

  if (deprecated) {
    deprecate_schema_warn(config_version, valid_version, hubutils_version)
  }
  invisible(deprecated)
}

deprecate_schema_warn <- function(config_version, valid_version, hubutils_version) {
  what <- cli::format_inline(
    "Hub configured using schema version {.field {config_version}}.
    Support for schema earlier than {.field {valid_version}}"
  )
  details <- cli::format_inline(
    "Please upgrade Hub config files to conform to, at minimum, version
    {.field {valid_version}} as soon as possible."
  )
  lifecycle::deprecate_warn(
    hubutils_version,
    I(what),
    details = details,
    env = rlang::caller_env(),
    user_env = .GlobalEnv
  )
}

extract_schema_version <- function(schema_version_url) {
  stringr::str_extract(
    schema_version_url,
    "v([0-9]\\.){2}[0-9](\\.[0-9]+)?"
  )
}
