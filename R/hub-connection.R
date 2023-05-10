#' Connect to model output data.
#'
#' Connect to data in a model output directory through a Modeling Hub or directly.
#' Data can be stored in a local directory or in the cloud on AWS or GCS.
#' @param hub_path Either a character string path to a local Modeling Hub directory
#' or an object of class `<SubTreeFileSystem>` created using functions [s3_bucket()]
#' or [gs_bucket()] by providing a string S3 or GCS bucket name or path to a
#' Modeling Hub directory stored in the cloud.
#' For more details consult the
#' [Using cloud storage (S3, GCS)](https://arrow.apache.org/docs/r/articles/fs.html)
#' in the `arrow` package.
#' The hub must be fully configured with valid `admin.json` and `tasks.json`
#' files within the `hub-config` directory.
#' @param model_output_dir Either a character string path to a local directory
#' containing model output data
#' or an object of class `<SubTreeFileSystem>` created using functions [s3_bucket()]
#' or [gs_bucket()] by providing a string S3 or GCS bucket name or path to a
#' directory containing model output data stored in the cloud.
#' For more details consult the
#' [Using cloud storage (S3, GCS)](https://arrow.apache.org/docs/r/articles/fs.html)
#' in the `arrow` package.
#' @param file_format The file format model output files are stored in.
#' For connection to a fully configured hub, accessed through `hub_path`,
#' `file_format` is inferred from the hub's `file_format` configuration in
#' `admin.json` and is ignored by default.
#' If supplied, it will override hub configuration setting.
#'
#' @return
#' - `connect_hub` returns an S3 object of class `<hub_connection>`.
#' - `connect_mod_out` returns an S3 object of class `<mod_out_connection>`.
#'
#' Both objects are connected to the data in the model-output directory via an
#' Apache arrow `FileSystemDataset` connection.
#' The connection can be used to extract data using `dplyr` custom queries. The
#' `<hub_connection>` class also contains modeling hub metadata.
#' @export
#' @describeIn connect_hub connect to a fully configured Modeling Hub directory.
#' @examples
#' # Connect to a local simple forecasting Hub.
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' # Connect directly to a local `model-output` directory
#' mod_out_path <- system.file("testhubs/simple/model-output", package = "hubUtils")
#' mod_out_con <- connect_model_output(mod_out_path)
#' mod_out_con
#' # Query hub_connection for data
#' library(dplyr)
#' hub_con %>%
#'   filter(
#'     origin_date == "2022-10-08",
#'     horizon == 2
#'   ) %>%
#'   collect()
#' mod_out_con %>%
#'   filter(
#'     origin_date == "2022-10-08",
#'     horizon == 2
#'   ) %>%
#'   collect()
#' # Connect to a simple forecasting Hub stored in an AWS S3 bucket.
#' \dontrun{
#' hub_path <- s3_bucket("hubutils/testhubs/simple/")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' }
connect_hub <- function(hub_path,
                        file_format = c("csv", "parquet", "arrow")) {
  UseMethod("connect_hub")
}


#' @export
connect_hub.default <- function(hub_path,
                                file_format = c("csv", "parquet", "arrow")) {
  rlang::check_required(hub_path)
  if (!dir.exists(hub_path)) {
    cli::cli_abort(c("x" = "Directory {.path {hub_path}} does not exist."))
  }
  if (!dir.exists(fs::path(hub_path, "hub-config"))) {
    cli::cli_abort(c("x" = "{.path hub-config} directory not found in root of Hub."))
  }

  config_admin <- read_config(hub_path, "admin")
  config_tasks <- read_config(hub_path, "tasks")

  model_output_dir <- model_output_dir_path(hub_path, config_admin)

  if (missing(file_format)) {
    file_format <- rlang::missing_arg()
    file_format <- get_file_format(config_admin, file_format)
  } else {
    file_format <- rlang::arg_match(file_format)
  }
  hub_name <- config_admin$name

  dataset <- open_hub_datasets(model_output_dir,
                               file_format,
                               config_tasks)

  structure(dataset,
    class = c("hub_connection", class(dataset)),
    hub_name = hub_name,
    file_format = file_format,
    file_system = dataset$filesystem,
    hub_path = hub_path,
    model_output_dir = model_output_dir,
    config_admin = config_admin,
    config_tasks = config_tasks
  )
}


open_hub_dataset <- function(model_output_dir,
                             file_format = c("csv", "parquet", "arrow"),
                             config_tasks) {

  file_format <- rlang::arg_match(file_format)
  schema <- create_hub_schema(config_tasks, format = file_format)

  switch (file_format,
          csv = arrow::open_dataset(
            model_output_dir, format = "csv",
            partitioning = "model",
            col_types = schema,
            unify_schemas = TRUE,
            factory_options = list(exclude_invalid_files = TRUE)),
          parquet =  arrow::open_dataset(
            model_output_dir, format = "parquet",
            partitioning = "model",
            schema = schema,
            unify_schemas = TRUE,
            factory_options = list(exclude_invalid_files = TRUE)),
          arrow =  arrow::open_dataset(
            model_output_dir, format = "arrow",
            partitioning = "model",
            schema = schema,
            unify_schemas = TRUE,
            factory_options = list(exclude_invalid_files = TRUE))
  )
}

open_hub_datasets <- function(model_output_dir,
                              file_format = c("csv", "parquet", "arrow"),
                              config_tasks) {

  if (length(file_format) == 1L) {

    open_hub_dataset(model_output_dir,
                     file_format,
                     config_tasks)
  } else {
    cons <- purrr::map(file_format,
               ~open_hub_dataset(model_output_dir,
                                 .x,
                                 config_tasks))

    arrow::open_dataset(cons)
  }

}


#' @export
connect_hub.SubTreeFileSystem <- function(hub_path,
                                          file_format = c("csv", "parquet", "arrow")) {
  rlang::check_required(hub_path)

  if (!"hub-config" %in% hub_path$ls()) {
    cli::cli_abort("{.path hub-config} not a directory in bucket
                       {.path {hub_path$base_path}}")
  }

  config_admin <- read_config(hub_path, "admin")
  config_tasks <- read_config(hub_path, "tasks")

  model_output_dir <- model_output_dir_path(hub_path, config_admin)

  if (missing(file_format)) {
    file_format <- rlang::missing_arg()
    file_format <- get_file_format(config_admin, file_format)
  } else {
    file_format <- rlang::arg_match(file_format)
  }
  hub_name <- config_admin$name

  dataset <- open_hub_datasets(model_output_dir,
                               file_format,
                               config_tasks)

  structure(dataset,
    class = c("hub_connection", class(dataset)),
    hub_name = hub_name,
    file_format = file_format,
    file_system = dataset$filesystem$base_fs,
    hub_path = hub_path$base_path,
    model_output_dir = model_output_dir$base_path,
    config_admin = config_admin,
    config_tasks = config_tasks
  )
}

#' @export
#' @describeIn connect_hub connect directly to a `model-output` directory. This
#' function can be used to access data directly from an appropriately set up
#' model output directory which is not part of a fully configured hub.
connect_model_output <- function(model_output_dir,
                                 file_format = c("csv", "parquet", "arrow")) {
  UseMethod("connect_model_output")
}

#' @export
connect_model_output.default <- function(model_output_dir,
                                         file_format = c("csv", "parquet", "arrow")) {
  rlang::check_required(model_output_dir)
  if (!dir.exists(model_output_dir)) {
    cli::cli_abort(c("x" = "Directory {.path {model_output_dir}} does not exist."))
  }
  file_format <- rlang::arg_match(file_format)

  dataset <- arrow::open_dataset(
    model_output_dir,
    format = file_format,
    partitioning = "model",
    unify_schemas = TRUE,
    factory_options = list(exclude_invalid_files = TRUE)
  )

  structure(dataset,
    class = c("mod_out_connection", class(dataset)),
    file_format = file_format,
    file_system = dataset$filesystem,
    model_output_dir = model_output_dir
  )
}

#' @export
connect_model_output.SubTreeFileSystem <- function(model_output_dir,
                                                   file_format = c("csv", "parquet", "arrow")) {
  rlang::check_required(model_output_dir)
  file_format <- rlang::arg_match(file_format)

  dataset <- arrow::open_dataset(
    model_output_dir,
    format = file_format,
    partitioning = "model",
    unify_schemas = TRUE,
    factory_options = list(exclude_invalid_files = TRUE)
  )

  structure(dataset,
    class = c("mod_out_connection", class(dataset)),
    file_format = file_format,
    file_system = dataset$filesystem$base_fs,
    model_output_dir = model_output_dir$base_path
  )
}

#' Print a `<hub_connection>` or `<mod_out_connection>` S3 class object
#'
#' @param x A `<hub_connection>` or `<mod_out_connection>` S3 class object.
#'
#' @param verbose Logical. Whether to print the full structure of the object.
#' Defaults to `FALSE`.
#' @param ... Further arguments passed to or from other methods.
#'
#' @export
#' @describeIn print.hub_connection print a `<hub_connection>` object.
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' print(hub_con)
#' print(hub_con, verbose = TRUE)
#' mod_out_path <- system.file("testhubs/simple/model-output", package = "hubUtils")
#' mod_out_con <- connect_model_output(mod_out_path)
#' print(mod_out_con)
print.hub_connection <- function(x, verbose = FALSE, ...) {
  cli::cli_h2("{.cls {class(x)[1:2]}}")

  print_msg <- NULL


  if (!is.null(attr(x, "hub_path"))) {
    print_msg <- c(print_msg,
      "*" = "hub_name: {.val {attr(x, 'hub_name')}}",
      "*" = "hub_path: {.file {attr(x, 'hub_path')}}"
    )
  }
  if (!is.null(attr(x, "file_format"))) {
    print_msg <- c(print_msg,
      "*" = "file_format: {.val {attr(x, 'file_format')}}"
    )
  }
  if (!is.null(attr(x, "file_system"))) {
    print_msg <- c(print_msg,
      "*" = "file_system: {.val {class(attr(x, 'file_system'))[1]}}"
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

#' @export
#' @describeIn print.hub_connection print a `<mod_out_connection>` object.
print.mod_out_connection <- function(x, verbose = FALSE, ...) {
  cli::cli_h2("{.cls {class(x)[1:2]}}")

  print_msg <- NULL

  if (!is.null(attr(x, "file_format"))) {
    print_msg <- c(print_msg,
      "*" = "file_format: {.val {attr(x, 'file_format')}}"
    )
  }
  if (!is.null(attr(x, "file_system"))) {
    print_msg <- c(print_msg,
      "*" = "file_system: {.val {class(attr(x, 'file_system'))[1]}}"
    )
  }
  print_msg <- c(print_msg,
    "*" = "model_output_dir: {.val {attr(x, 'model_output_dir')}}"
  )

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
  UseMethod("read_config")
}


#' @export
read_config.default <- function(hub_path, config = c("tasks", "admin"),
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

#' @export
read_config.SubTreeFileSystem <- function(hub_path, config = c("tasks", "admin"),
                                          call = rlang::caller_env()) {
  config <- rlang::arg_match(config)
  path <- hub_path$path(fs::path("hub-config", config, ext = "json"))

  if (!paste0(config, ".json") %in% basename(hub_path$ls("hub-config"))) {
    cli::cli_abort(
      "Config file {.field {config}} does not exist at path {.path { path$base_path }}.",
      call = call
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

  jsonlite::fromJSON(path_url,
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

model_output_dir_path <- function(hub_path, config_admin,
                                  call = rlang::caller_env()) {
  UseMethod("model_output_dir_path")
}
#' @export
model_output_dir_path.default <- function(hub_path, config_admin,
                                          call = rlang::caller_env()) {
  model_output_dir <- ifelse(
    is.null(config_admin[["model_output_dir"]]),
    fs::path(hub_path, "model-output"),
    fs::path(hub_path, config_admin[["model_output_dir"]])
  )
  if (!dir.exists(model_output_dir)) {
    cli::cli_abort(
      "Directory {.path {basename(model_output_dir)}} does not exist
      at path {.path { model_output_dir }}.",
      call = call
    )
  }
  model_output_dir
}

#' @export
model_output_dir_path.SubTreeFileSystem <- function(hub_path, config_admin, call = rlang::caller_env()) {
  if (is.null(config_admin[["model_output_dir"]])) {
    model_output_dir <- hub_path$path("model-output")
  } else {
    model_output_dir <- hub_path$path(config_admin[["model_output_dir"]])
  }

  if (!basename(model_output_dir$base_path) %in% hub_path$ls()) {
    cli::cli_abort(
      "Directory {.path {basename(model_output_dir$base_path)}} does not exist
      at path {.path { model_output_dir$base_path }}.",
      call = call
    )
  }
  model_output_dir
}
