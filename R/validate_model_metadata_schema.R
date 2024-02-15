#' Validate model-metadata-schema config file
#'
#' @inherit validate_config params return
#' @details
#' Checks that a `model-metadata-schema.json` config file exists in `hub-config`,
#' can be successfully parsed and contains at least either a `model_id` property or
#' both `team_abbr` and `model_abbr` properties.
#'
#' @export
#'
#' @examples
#' validate_model_metadata_schema(
#'   hub_path = system.file(
#'     "testhubs/simple/",
#'     package = "hubUtils"
#'   )
#' )
validate_model_metadata_schema <- function(hub_path = ".") {
  if (!(requireNamespace("jsonvalidate"))) {
    cli::cli_abort(
      "Package {.pkg jsonvalidate} must be installed to use {.fn validate_config}.
      Please install it to continue.
      Alternatively, to be able to use all packages required for hub maintainer functionality,
      re-install {.pkg hubUtils} using argument {.code dependencies = TRUE}")
  }
  checkmate::assert_directory_exists(hub_path)
  config_path <- fs::path(hub_path, "hub-config",
    "model-metadata-schema",
    ext = "json"
  )
  # check config file to be checked exists and is correct extension
  checkmate::assert_file_exists(config_path, extension = "json")

  schema <- try(
    jsonvalidate::json_validator(
      config_path,
      engine = "ajv"
    ),
    silent = TRUE
  )

  if (inherits(schema, "try-error")) {
    cli::cli_abort(
      c(
        "x" = "Parsing error detected in {.path model-metadata-schema.json}",
        "!" = attr(schema, "condition")$message
      )
    )
  }

  validation <- TRUE
  attr(validation, "config_path") <- config_path
  attr(validation, "schema_version") <- NULL
  attr(validation, "schema_url") <- NULL

  properties <- read_config(hub_path, "model-metadata-schema") %>%
    purrr::pluck("properties") %>%
    names()

  if (
    isFALSE(
      "model_id" %in% properties ||
        all(c("model_abbr", "team_abbr") %in% properties)
    )
  ) {
    errors_tbl <- data.frame(
      instancePath = "",
      schemaPath = "properties",
      keyword = "required",
      message = "must have required properties: either 'model_id' or both 'team_abbr' and 'model_abbr'.",
      schema = "",
      data = cli::format_inline("{properties}")
    )

    validation[] <- FALSE
    attr(validation, "errors") <- errors_tbl
  }
  if (validation) {
    cli::cli_alert_success(
      "Successfully validated config file {.file {config_path}}"
    )
  } else {
    cli::cli_warn(
      "Schema errors detected in config file {.file {config_path}}"
    )
  }
  return(validation)
}
