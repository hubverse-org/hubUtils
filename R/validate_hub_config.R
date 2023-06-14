#' Validate Hub config files against Infectious Disease Modeling Hubs schema.
#'
#' Validate the `admin.json` and `tasks.json` Hub config files in a single call.
#' @param config_dir Defaults to `NULL` which assumes all config files are in
#'   the `hub-config` directory in the root of hub directory. Argument
#'   `config_dir` can be used to override default by providing a path to the
#'    directory containing the config files to be validated. Config directory must
#'    contain a `admin.json` and `tasks.json` file.
#' @inheritParams validate_config
#'
#' @return Returns a list of the results of validation, one for each `hub-config`
#' file validated. A value of `TRUE` for a given file indicates that validation
#' was successful.
#' A value of `FALSE` for a given file indicates that validation errors were
#' detected. Details of errors will be appended as a data.frame to an `errors` attribute.
#'   To access the errors table for a given element use `attr(x, "errors")`
#'   where `x` is the any element of the output of the function that is `FALSE`.
#'   You can print a more concise and easier to view version of an errors table with
#'   [view_config_val_errors()].
#' @export
#' @seealso [view_config_val_errors()]
#' @family functions supporting config file validation
#'
#' @examples
#' validate_hub_config(
#'   hub_path = system.file(
#'     "testhubs/simple/",
#'     package = "hubUtils"
#'   )
#' )
validate_hub_config <- function(hub_path = ".",
                                config_dir = NULL, schema_version = "from_config",
                                branch = "main") {
  if (!is.null(config_dir)) {
    config_paths <- list(
      tasks = fs::path(config_dir, "tasks", ext = "json"),
      admin = fs::path(config_dir, "admin", ext = "json")
    )
  } else {
    config_paths <- list(
      tasks = NULL,
      admin = NULL
    )
  }

  validations <- purrr::map2(
    .x = names(config_paths),
    .y = config_paths,
    ~ validate_config(
      hub_path = hub_path,
      config = .x,
      config_path = .y,
      schema_version = schema_version,
      branch = branch
    )
  ) %>%
    purrr::set_names(names(config_paths)) %>%
    suppressMessages() %>%
    suppressWarnings()



  # Throw error if schema urls do not resolve to the same schema version directory.
  # No point showing report of errors detected if they are not related to the
  # same schema version.
  schema_url_dirnames <- purrr::map_chr(
    validations,
    ~ dirname(attr(.x, "schema_url"))
  )
  if (!do.call(`==`, as.list(schema_url_dirnames))) {
    msg <- paste0(
      "{.field ",
      names(schema_url_dirnames),
      ".json} schema version: {.url ",
      schema_url_dirnames,
      "}"
    ) %>%
      stats::setNames(rep("*", length(schema_url_dirnames)))

    cli::cli_abort(c(
      x = "Config files validating against different schema versions.",
      msg,
      "!" = "Ensure the `schema_version` properties in all config files
            refer to the same schema version to proceed."
    ))
  }

  # Issue warning if validation errors detected in any of the config files.
  # Else, signal success.
  error_idx <- purrr::map_lgl(
    validations,
    ~ isFALSE(.x)
  )
  if (any(error_idx)) {
    cli::cli_warn(c(
      "x" = "Errors detected in {.path {
      fs::path(names(error_idx)[error_idx], ext = 'json')}}
            config file{?s}.",
      "i" = "Use {.code view_config_val_errors()} on the output of
            {.code validate_hub_config} to review errors."
    ))
  } else {
    cli::cli_alert_success(
      "Hub correctly configured!
         Both {.path admin.json} and {.path tasks.json} valid."
    )
  }

  config_dir_path <- ifelse(
    is.null(config_dir),
    fs::path(hub_path, "hub-config"),
    config_dir
  )

  attr(validations, "config_dir") <- config_dir_path
  attr(validations, "schema_version") <- purrr::map_chr(
    validations,
    ~ attr(.x, "schema_version")
  ) %>%
    unique()
  attr(validations, "schema_url") <- gsub(
    "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/",
    "https://github.com/Infectious-Disease-Modeling-Hubs/schemas/tree/",
    unique(schema_url_dirnames),
    fixed = TRUE
  )

  return(validations)
}
