#' Coerce a config list to a config class object
#'
#' @param x a list representation of the contents a `tasks.json` config file.
#' Often the output of [read_config()] or
#' [read_config_file()].
#'
#' @return a config list object with superclass `<config>`.
#' @export
#'
#' @examples
#' config_tasks <- read_config(
#'   hub_path = system.file("testhubs/simple", package = "hubUtils")
#' )
#' as_config(config_tasks)
as_config <- function(x) {
  x$schema_version <- schema_id <- validate_schema_url_prefix(
    x$schema_version,
    property_name = "schema_version",
    call = rlang::current_env()
  )

  validate_schema_id(schema_id, call = rlang::current_env())
  validate_config_properties(schema_id, x, call = rlang::current_env())

  attr(x, "schema_id") <- schema_id
  class(x) <- c("config", "list")

  return(x)
}

validate_config_properties <- function(schema_id, config_list,
                                       call = rlang::caller_env()) {
  schema <- hubUtils::get_schema(schema_id)
  # validate the properties of a config object against a schema object
  schema_properties <- jsonlite::fromJSON(schema)$properties |> names()
  config_properties <- names(config_list)
  invalid_properties <- setdiff(config_properties, schema_properties)
  if (length(invalid_properties) > 0L) {
    cli::cli_abort(
      c(
        "x" = "Invalid properties in {.arg config_list}: {.val {invalid_properties}}",
        "!" = "Must be members of {.val {schema_properties}}"
      ),
      call = call
    )
  }
  return(TRUE)
}


validate_schema_id <- function(schema_id, property_name = "schema_version",
                               branch = "main", call = rlang::caller_env()) {
  if (is.null(schema_id)) {
    cli::cli_abort("No {.field {property_name}} property found in {.arg config_list}.")
  }
  validate_schema_url_prefix(schema_id,
    property_name = property_name,
    call = call
  )

  schema_version <- hubUtils::extract_schema_version(schema_id)
  valid_versions <- hubUtils::get_schema_valid_versions(branch = branch)

  if (schema_version %in% valid_versions) {
    invisible(schema_version)
  } else {
    cli::cli_abort(
      "{.val {schema_version}} is not a valid schema version.
            Current valid schema version{?s} {?is/are}: {.val {valid_versions}}.
            For more details, visit {.url https://github.com/hubverse-org/schemas}",
      call = call
    )
  }
  invisible(TRUE)
}

validate_schema_url_prefix <- function(schema_url, property_name = "schema_version",
                                       call = rlang::caller_env()) {
  check_prefix <- grepl(
    "https://raw.githubusercontent.com/(hubverse-org|Infectious-Disease-Modeling-Hubs)/schemas/main/",
    schema_url,
    fixed = FALSE
  )
  if (!check_prefix) {
    cli::cli_abort(
      c("x" = "Invalid {.field {property_name}} property. Should start with:
              {.val https://raw.githubusercontent.com/hubverse-org/schemas/main/}"),
      call = call
    )
  }
  if (grepl("Infectious-Disease-Modeling-Hubs", schema_url, fixed = TRUE)) {
    # update the schema url if they have an old one
    cli::cli_alert_info(
      "Updating superseded URL {.var Infectious-Disease-Modeling-hubs} to {.var hubverse-org}"
    )
    schema_url <- sub(
      "Infectious-Disease-Modeling-Hubs", "hubverse-org",
      schema_url,
      fixed = TRUE
    )
  }
  return(invisible(schema_url))
}
