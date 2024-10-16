#' Get hub config schema versions
#'
#' @param config A `<config>` class object. Usually the output of `read_config` or `read_config_file`.
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
#' @param config_type Character vector specifying the type of config file to read.
#' One of "tasks" or "admin". Default is "tasks".
#' @export
#' @describeIn get_version_config Get schema version from config file at specific path.
#'
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' get_version_hub(hub_path)
#' get_version_hub(hub_path, "admin")
get_version_hub <- function(hub_path, config_type = c("tasks", "admin")) {
  config_type <- rlang::arg_match(config_type)
  read_config(hub_path, config_type) |>
    get_version_config()
}

## COMPARE VERSION NUMBERS -----------------------------------------------------
#' Compare hub config `schema_version`s to specific version numbers from
#' a variety of sources
#'
#' @param config A `<config>` class object. Usually the output of `read_config` or `read_config_file`.
#' @param version Character string. Version number to compare against, must be in
#' the format `"v#.#.#"`.
#' @param schema_version Character string. A config `schema_version` property to
#' compare against.
#' @return `TRUE` or `FALSE` depending on how the schema version compares to the
#' version number specified.
#'
#' @export
#' @inheritParams read_config_file
#' @inheritParams read_config
#' @export
#' @describeIn version_equal Check whether a schema version property is equal
#' to a specific version number.
#'
#' @examples
#' # Actual version "v2.0.0"
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' # Actual version "v3.0.0"
#' config_path <- system.file("config", "tasks.json", package = "hubUtils")
#' config <- read_config_file(config_path)
#' schema_version <- config$schema_version
#' # Check whether schema_version equal to v3.0.0
#' version_equal("v3.0.0", config = config)
#' version_equal("v3.0.0", config_path = config_path)
#' version_equal("v3.0.0", hub_path = hub_path)
#' version_equal("v3.0.0", schema_version = schema_version)
version_equal <- function(version, config = NULL, config_path = NULL,
                          hub_path = NULL, schema_version = NULL) {
  validate_version_format(version)
  comp_version <- get_comp_version(config, config_path, hub_path, schema_version)
  comp_version == version
}

#' @inheritParams read_config_file
#' @export
#' @describeIn version_equal Check whether a schema version property is equal to
#' or greater than a specific version number.
#'
#' @examples
#' # Check whether schema_version equal to or greater than v3.0.0
#' version_gte("v3.0.0", config = config)
#' version_gte("v3.0.0", config_path = config_path)
#' version_gte("v3.0.0", hub_path = hub_path)
#' version_gte("v3.0.0", schema_version = schema_version)
version_gte <- function(version, config = NULL, config_path = NULL,
                        hub_path = NULL, schema_version = NULL) {
  validate_version_format(version)
  comp_version <- get_comp_version(config, config_path, hub_path, schema_version)
  comp_version >= version
}

#' @inheritParams read_config_file
#' @export
#' @describeIn version_equal Check whether a schema version property is greater
#' than a specific version number.
#'
#' @examples
#' # Check whether schema_version greater than v3.0.0
#' version_gt("v3.0.0", config = config)
#' version_gt("v3.0.0", config_path = config_path)
#' version_gt("v3.0.0", hub_path = hub_path)
#' version_gt("v3.0.0", schema_version = schema_version)
version_gt <- function(version, config = NULL, config_path = NULL,
                       hub_path = NULL, schema_version = NULL) {
  validate_version_format(version)
  comp_version <- get_comp_version(config, config_path, hub_path, schema_version)
  comp_version > version
}

#' @inheritParams read_config_file
#' @export
#' @describeIn version_equal Check whether a schema version property is equal to
#' or less than a specific version number.
#'
#' @examples
#' # Check whether schema_version equal to or less than v3.0.0
#' version_lte("v3.0.0", config = config)
#' version_lte("v3.0.0", config_path = config_path)
#' version_lte("v3.0.0", hub_path = hub_path)
#' version_lte("v3.0.0", schema_version = schema_version)
version_lte <- function(version, config = NULL, config_path = NULL,
                        hub_path = NULL, schema_version = NULL) {
  validate_version_format(version)
  comp_version <- get_comp_version(config, config_path, hub_path, schema_version)
  comp_version <= version
}

#' @inheritParams read_config_file
#' @export
#' @describeIn version_equal Check whether a schema version property is less
#' than a specific version number.
#'
#' @examples
#' # Check whether schema_version less than v3.0.0
#' version_lt("v3.0.0", config = config)
#' version_lt("v3.0.0", config_path = config_path)
#' version_lt("v3.0.0", hub_path = hub_path)
#' version_lt("v3.0.0", schema_version = schema_version)
version_lt <- function(version, config = NULL, config_path = NULL,
                       hub_path = NULL, schema_version = NULL) {
  validate_version_format(version)
  comp_version <- get_comp_version(config, config_path, hub_path, schema_version)
  comp_version < version
}

# Get the schema version from the provided argument
get_comp_version <- function(config, config_path, hub_path, schema_version,
                             call = rlang::caller_env()) {
  non_null_args <- list(config, config_path, hub_path, schema_version) |>
    purrr::set_names(
      c(
        "config", "config_path", "hub_path",
        "schema_version"
      )
    ) |>
    purrr::map_lgl(~ !is.null(.x))

  arg_names <- names(non_null_args)[non_null_args]

  if (sum(non_null_args) != 1) {
    abort_msg <- c("x" = "Exactly one of {.arg config}, {.arg config_path}, or
              {.arg hub_path} must be provided.")
    if (length(arg_names) > 0) {
      abort_msg <- c(abort_msg,
        "i" = "Provided arguments: {.arg {arg_names}}."
      )
    } else {
      abort_msg <- c(abort_msg,
        "i" = "None provided."
      )
    }
    cli::cli_abort(abort_msg, call = call)
  }

  switch(arg_names,
    config = get_version_config(config),
    config_path = get_version_file(config_path),
    hub_path = get_version_hub(hub_path),
    schema_version = extract_schema_version(schema_version)
  )
}

validate_version_format <- function(version, call = rlang::caller_env()) {
  checkmate::assert_character(version, len = 1L)
  if (!grepl("^v[0-9]+\\.[0-9]+\\.[0-9]+$", version)) {
    cli::cli_abort(
      c("x" = "Invalid version number format.
              Must be in the format {.val v#.#.#.}"),
      call = call
    )
  }
}
