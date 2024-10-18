#' Read a hub config file into R
#'
#' @param hub_path Either a character string path to a local Modeling Hub directory
#' or an object of class `<SubTreeFileSystem>` created using functions [arrow::s3_bucket()]
#' or [arrow::gs_bucket()] by providing a string S3 or GCS bucket name or path to a
#' Modeling Hub directory stored in the cloud.
#' For more details consult the
#' [Using cloud storage (S3, GCS)](https://arrow.apache.org/docs/r/articles/fs.html)
#' in the `arrow` package.
#' @param config Type of config file to read. One of `"tasks"`, `"admin"` or
#' `"model-metadata-schema"`. Default is `"tasks"`.
#' @param silent Logical. If `TRUE`, suppress warnings. Default is `FALSE`.
#'
#' @return The contents of the config file as an R list. If possible, the output is
#' further converted to a `<config>` class object before returning. Note that
#' `"model-metadata-schema"` files are never converted to a `<config>` object.
#' @export
#'
#' @examples
#' # Read config files from local hub
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' read_config(hub_path, "tasks")
#' read_config(hub_path, "admin")
#'
#' @examplesIf asNamespace("hubUtils")$not_rcmd_check() && requireNamespace("arrow", quietly = TRUE)
#' # Read config file from AWS S3 bucket hub
#' hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
#' read_config(hub_path, "admin")
read_config <- function(hub_path,
                        config = c("tasks", "admin", "model-metadata-schema"),
                        silent = FALSE) {
  UseMethod("read_config")
}


#' @export
#' @importFrom jsonlite read_json
#' @importFrom fs path
read_config.default <- function(hub_path,
                                config = c("tasks", "admin", "model-metadata-schema"),
                                silent = FALSE) {
  config <- rlang::arg_match(config)
  path <- path(hub_path, "hub-config", config, ext = "json")

  if (!fs::file_exists(path)) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { path }}."
    )
  }
  read_config_file(path, silent = silent)
}

#' @export
#' @importFrom jsonlite fromJSON
read_config.SubTreeFileSystem <- function(hub_path,
                                          config = c(
                                            "tasks", "admin",
                                            "model-metadata-schema"
                                          ),
                                          silent = FALSE) {
  config <- rlang::arg_match(config)
  path <- hub_path$path(path("hub-config", config, ext = "json")) # nolint: object_usage_linter

  if (!paste0(config, ".json") %in% basename(hub_path$ls("hub-config"))) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { path$base_path }}."
    )
  }

  split_base_path <- stringr::str_split(
    hub_path$base_path,
    "/", 2
  ) %>%
    unlist()

  path_url <- glue::glue(
    "https://{split_base_path[1]}.s3.amazonaws.com/{split_base_path[2]}hub-config/{config}.json"
  )

  read_config_file(path_url, silent = silent)
}

#' Read a JSON config file from a path
#'
#' @param config_path Character string. Path to JSON config file.
#'
#' @inherit read_config return params
#' @export
#'
#' @examples
#' read_config_file(system.file("config", "tasks.json", package = "hubUtils"))
read_config_file <- function(config_path, silent = FALSE) {
  config <- jsonlite::fromJSON(
    config_path,
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
  if (grepl("model-metadata-schema", config_path)) {
    return(config)
  }
  tryCatch(
    as_config(config),
    error = function(e) {
      if (!silent) {
        cli::cli_warn(
          "Could not convert to {.cls config}: {e$message}"
        )
      }
      config
    }
  )
}
