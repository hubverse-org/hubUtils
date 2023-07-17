# Function compares the current schema version in a config file to a valid version
# If config file version deprecated compared to valid version, returns `TRUE`
# and issues a lifecycle warning to prompt user to upgrade.
# Else, returns `FALSE`
check_deprecated_schema <- function(config_version, config, valid_version = "v2.0.0",
                                    hubUtils_version) {
  config_version <- switch(
      rlang::check_exclusive(config_version, config),
    config = extract_schema_version(config$schema_version),
    config_version = config_version
  )
  deprecated <- config_version < valid_version

  if (deprecated) {
    deprecate_schema_warn(config_version, valid_version, hubUtils_version)
  }
  invisible(deprecated)
}

deprecate_schema_warn <- function(config_version, valid_version, hubUtils_version) {
  what <- cli::format_inline(
    "Hub configured using schema version {.field {config_version}}.
    Support for schema earlier than {.field {valid_version}}"
  )
  details <- cli::format_inline(
    "Please upgrade Hub config files to conform to, at minimum, version
    {.field {valid_version}} as soon as possible."
  )
  lifecycle::deprecate_warn(
    hubUtils_version,
    I(what),
    details = details,
    user_env = .GlobalEnv
  )
}
