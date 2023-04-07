#' Connect to a Modeling Hub
#'
#' Connect to a Modeling Hub of model output directory.
#' @param hub_path Path to a Modeling Hub directory. The hub must be fully
#' configured with valid `admin.json` and `tasks.json` files within the `hub-config`
#' directory.
#' @param model_output_dir Path to the directory containing model output data.
#' This argument can be used to access data directly from an appropriately set up
#' model output directory which is not part of a fully configured hub.
#' @param file_format The file format model output files are stored in.
#' For connection to a fully configured hub, accessed through `hub_path`,
#' `file_format` is inferred from the hub's `file_format` configuration in
#' `admin.json` and is ignored by default.
#' If supplied, it will override hub configuration setting.
#'
#' @return an S3 object of class `<hub-connection>` connected to the data in the
#' model-output directory via an Apache arrow `FileSystemDataset` connection. The
#' connection can be used to extract data using `dplyr` custom queries. The object
#' also contains metadata about the modeling hub.
#' @export
#' @examples
#' # Connect to a simple forecasting Hub.
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' model_output_dir <- system.file("testhubs/simple/model-output", package = "hubUtils")
#' model_output_con <- connect_hub(model_output_dir = model_output_dir)
#' model_output_con
#' # Access data
#' library(dplyr)
#' hub_con %>%
#'   filter(
#'     origin_date == "2022-10-08",
#'     horizon == 2
#'   ) %>%
#'   collect()
#' model_output_con %>%
#'   filter(
#'     origin_date == "2022-10-08",
#'     horizon == 2
#'   ) %>%
#'   collect()
connect_hub <- function(hub_path, model_output_dir = NULL,
                        file_format = c("csv", "parquet", "arrow")) {
  if (rlang::is_missing(hub_path)) {
    rlang::check_required(model_output_dir)
    checkmate::assert_directory_exists(model_output_dir)
    rlang::check_required(file_format)
    file_format <- rlang::arg_match(file_format)
    hub_path <- NULL
    config_tasks <- NULL
    config_admin <- NULL
    hub_name <- NULL
  } else {
    checkmate::assert_directory_exists(hub_path)
    checkmate::assert_directory_exists(fs::path(hub_path, "hub-config"))

    config_tasks <- read_config(hub_path, "tasks")
    config_admin <- read_config(hub_path, "admin")

    if (is.null(config_admin[["model_output_dir"]])) {
      model_output_dir <- fs::path(hub_path, "model-output")
      checkmate::assert_directory_exists(hub_path)
    }
    if (missing(file_format)) {
      file_format <- rlang::missing_arg()
      file_format <- get_file_format(config_admin, file_format)
    } else {
      file_format <- rlang::arg_match(file_format)
    }
    hub_name <- config_admin$name
  }

  dataset <- arrow::open_dataset(
    model_output_dir,
    format = file_format,
    partitioning = "team",
    factory_options = list(exclude_invalid_files = TRUE)
  )


  structure(dataset,
    class = c("hub_connection", class(dataset)),
    hub_name = hub_name,
    file_format = file_format,
    hub_path = hub_path,
    model_output_dir = model_output_dir,
    config_admin = config_admin,
    config_tasks = config_tasks
  )
}

#' Print a `<hub_connection>` S3 class object
#'
#' @param x A `<hub_connection>` S3 class object.
#'
#' @param verbose Logical. Whether to print the full structure of the object.
#' Defaults to `FALSE`.
#' @param ... Further arguments passed to or from other methods.
#'
#' @export
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' print(hub_con)
#' print(hub_con, verbose = TRUE)
print.hub_connection <- function(x, verbose = FALSE, ...) {
  cli::cli_h2("{.cls {class(x)[1:2]}}")

  print_msg <- NULL


  if (!is.null(attr(x, "hub_path"))) {
    print_msg <- c(print_msg,
      "*" = "hub_name: {.val {attr(x, 'hub_name')}}",
      "*" = "hub_path: {.file {attr(x, 'hub_path')}}"
    )
  }
  print_msg <- c(print_msg,
    "*" = "model_output_dir: {.val {attr(x, 'model_output_dir')}}"
  )

  if (!is.null(attr(x, "config_admin"))) {
    print_msg <- c(print_msg,
      "*" = "config_admin: {.path hub-config/admin.json}"
    )
  }
  if (!is.null(attr(x, "config_tasks"))) {
    print_msg <- c(print_msg,
      "*" = "config_tasks: {.path hub-config/tasks.json}"
    )
  }
  cli::cli_bullets(print_msg)

  if (inherits(x, "ArrowObject")) {
    cli::cli_h3("Connection schema")
    x$print()
  }

  if (verbose) {
    utils::str(x)
  }
  invisible(x)
}



read_config <- function(hub_path, config = c("tasks", "admin"),
                        call = rlang::caller_env()) {
  config <- rlang::arg_match(config)
  path <- fs::path(hub_path, "hub-config", config, ext = "json")

  if (!fs::file_exists(path)) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { path }}.",
      call = call
    )
  }

  jsonlite::read_json(path,
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
}

get_file_format <- function(config_admin,
                            file_format = c("csv", "parquet", "arrow"),
                            call = rlang::caller_env()) {
  config_file_format <- config_admin[["file_format"]]

  if (!rlang::is_missing(file_format)) {
    file_format <- rlang::arg_match(file_format)

    if (!file_format %in% config_file_format) {
      cli::cli_abort(c(
        "x" = "{.arg file_format} value {.val {file_format}} is not a valid
                file format available for this hub.",
        "!" = "Must be {?/one of}: {.val {config_file_format}}."
      ),
      call = call
      )
    }

    return(file_format)
  }

  if (length(config_file_format) == 1L) {
    return(config_file_format)
  }
  if (length(config_file_format) == 0L) {
    cli::cli_abort(c(
      "x" = "{.arg file_format} value could not be extracted from config
            file {.field admin.json}.",
      "!" = "Use argument {.arg file_format} to specify a file format
            or contact hub maintainers for assistance."
    ),
    call = call
    )
  }

  if (length(config_file_format) > 1L && rlang::is_missing(file_format)) {
    cli::cli_abort(c(
      "x" = "More than one file formats are available for this hub: {.val {config_file_format}}",
      "!" = "Current {.code hubUtils} functionality only supports connecting
            to model output data in a single format.",
      "i" = "Use argument {.arg file_format} to specify a single file format.
            Only data stored in the specified file_format will be accessible through
            the {.cls hub_connection} object created."
    ),
    call = call
    )
  }
}
