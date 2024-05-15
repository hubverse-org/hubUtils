#' Read a hub config file into R
#'
#' @param hub_path Either a character string path to a local Modeling Hub directory
#' or an object of class `<SubTreeFileSystem>` created using functions [hubData::s3_bucket()]
#' or [hubData::gs_bucket()] by providing a string S3 or GCS bucket name or path to a
#' Modeling Hub directory stored in the cloud.
#' For more details consult the
#' [Using cloud storage (S3, GCS)](https://arrow.apache.org/docs/r/articles/fs.html)
#' in the `arrow` package.
#' @param config Name of config file to validate. One of `"tasks"` or `"admin"`.
#'
#' @return The contents of the config as an R list.
#' @export
#'
#' @examples
#' # Read config files from local hub
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' read_config(hub_path, "tasks")
#' read_config(hub_path, "admin")
#' # Read config file from AWS S3 bucket hub
#' hub_path <- hubData::s3_bucket("hubverse/hubutils/testhubs/simple/")
#' read_config(hub_path, "admin")
read_config <- function(hub_path, config = c("tasks", "admin", "model-metadata-schema")) {
  UseMethod("read_config")
}


#' @export
#' @importFrom jsonlite read_json
read_config.default <- function(hub_path,
                                config = c("tasks", "admin", "model-metadata-schema")) {
  config <- rlang::arg_match(config)
  path <- fs::path(hub_path, "hub-config", config, ext = "json")

  if (!fs::file_exists(path)) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { path }}."
    )
  }
  read_config_file(path)
  # jsonlite::read_json(path,
  #   simplifyVector = TRUE,
  #   simplifyDataFrame = FALSE
  # )
}

#' @export
#' @importFrom jsonlite fromJSON
read_config.SubTreeFileSystem <- function(hub_path,
                                          config = c("tasks", "admin", "model-metadata-schema")) {
  config <- rlang::arg_match(config)
  path <- hub_path$path(fs::path("hub-config", config, ext = "json")) # nolint: object_usage_linter

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

  read_config_file(path_url)
  # jsonlite::fromJSON(path_url,
  #   simplifyVector = TRUE,
  #   simplifyDataFrame = FALSE
  # )
}

#' Read a JSON config file from a path
#'
#' @param config_path path to JSON config file
#'
#' @return a list representation of the JSON config file
#' @export
#'
#' @examples
#' read_config_file(system.file("config", "tasks.json", package = "hubUtils"))
read_config_file <- function(config_path) {
  jsonlite::fromJSON(
    config_path,
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
}
