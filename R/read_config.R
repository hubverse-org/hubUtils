#' Read a hub config file into R
#'
#' @param hub_path Either a character string path to a local Modeling Hub directory,
#' a character string of a URL to a GitHub repository
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
#' # Read config file from a GitHub hub repository
#' github_url <- "https://github.com/hubverse-org/example-simple-forecast-hub"
#' read_config(github_url)
#' read_config(github_url, "admin")
#' @examplesIf asNamespace("hubUtils")$not_rcmd_check() && requireNamespace("arrow", quietly = TRUE)
#' # Read config file from AWS S3 bucket hub
#' hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
#' read_config(hub_path, "admin")
read_config <- function(hub_path,
                        config = c("tasks", "admin", "model-metadata-schema"),
                        silent = TRUE) {
  UseMethod("read_config")
}


#' @export
#' @importFrom jsonlite read_json
#' @importFrom fs path
read_config.default <- function(hub_path,
                                config = c("tasks", "admin", "model-metadata-schema"),
                                silent = TRUE) {
  config <- rlang::arg_match(config)
  config_path <- path("hub-config", config, ext = "json")
  if (is_url(hub_path)) {
    if (is_github_url(hub_path)) {
      hub_path <- convert_to_raw_github_url(hub_path)
    }
    path <- paste(hub_path, config_path, sep = "/") |>
      sanitize_url()
    if (!is_valid_url(path)) {
      cli::cli_abort(
        "URL {.path {path}} is invalid or unreachable."
      )
    }
  } else {
    path <- path(hub_path, config_path)
    if (!fs::file_exists(path)) {
      cli::cli_abort(
        "Config file {.field {config}} does not exist at path {.path { path }}."
      )
    }
  }
  read_config_file(path, silent = silent)
}

#' @export
read_config.SubTreeFileSystem <- function(hub_path,
                                          config = c(
                                            "tasks", "admin",
                                            "model-metadata-schema"
                                          ),
                                          silent = TRUE) {
  config <- rlang::arg_match(config)

  base_path <- path("hub-config", config, ext = "json")

  if (!paste0(config, ".json") %in% basename(hub_path$ls("hub-config"))) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { base_path }}."
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

  base_fs <- hub_path$base_path
  path_url <- create_s3_url(base_fs, base_path)

  read_config_file(path_url, silent = silent)
}

#' Read a JSON config file from a path
#'
#' @param config_path Either a character string of a path to a local JSON config
#' file, a character string of the URL to a JSON config file (e.g on GitHub) or
#' an object of class `<SubTreeFileSystem>` created using functions
#' [arrow::s3_bucket()] and associated methods for creating paths to JSON config
#'  files within the bucket.
#' @inherit read_config return params
#' @export
#'
#' @examples
#' # Read local config file
#' read_config_file(system.file("config", "tasks.json", package = "hubUtils"))
#' # Read config file from URL
#' url <- paste0(
#'   "https://raw.githubusercontent.com/hubverse-org/",
#'   "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
#' )
#' read_config_file(url)
#' @examplesIf asNamespace("hubUtils")$not_rcmd_check() && requireNamespace("arrow", quietly = TRUE)
#' # Read config file from AWS S3 bucket hub
#' hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
#' config_path <- hub_path$path("hub-config/admin.json")
#' read_config_file(config_path)
read_config_file <- function(config_path, silent = TRUE) {
  UseMethod("read_config_file")
}

#' @export
read_config_file.default <- function(config_path, silent = TRUE) {
  checkmate::assert_character(config_path, len = 1)
  if (is_url(config_path)) {
    if (!is_valid_url(config_path)) {
      cli::cli_abort(
        "URL {.path {config_path}} is invalid or unreachable."
      )
    }
  } else {
    checkmate::assert_file_exists(config_path)
  }
  read_json_config(config_path, silent = silent)
}

#' @export
read_config_file.SubTreeFileSystem <- function(config_path, silent = TRUE) {
  base_fs <- config_path$base_fs$base_path
  base_path <- config_path$base_path
  path_url <- create_s3_url(base_fs, base_path)

  if (!is_valid_url(path_url)) {
    cli::cli_abort(
      "S3 config file {.path {path_url}} does not exist."
    )
  }
  read_json_config(path_url, silent = silent)
}

#' Read a JSON config file into R and convert to a config object
#'
#' @param path character string. Can be a path to a local JSON
#' config, or a URL to a JSON config file, including a URL to file in an s3 hub.
#' @return The contents of the config file as an R list. If possible, the output is
#' further converted to a `<config>` class object before returning.
#' @importFrom jsonlite fromJSON
#' @noRd
read_json_config <- function(path, silent = TRUE) {
  if (fs::path_ext(path) != "json") {
    cli::cli_abort(
      "Config file {.path {path}} is not a JSON file."
    )
  }
  config <- jsonlite::fromJSON(
    path,
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
  if (grepl("model-metadata-schema", path)) {
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
