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
#' If supplied, it will override hub configuration setting. Multiple formats can be supplied to `connect_hub` but only a single file format can be supplied to `connect_mod_out`.
#' @inheritParams create_hub_schema
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
#' hub_con <- connect_hub(hub_path, output_type_id_datatype = "character")
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
#' hub_path <- s3_bucket("hubverse/hubutils/testhubs/simple/")
#' hub_con <- connect_hub(hub_path)
#' hub_con
#' }
connect_hub <- function(hub_path,
                        file_format = c("csv", "parquet", "arrow"),
                        output_type_id_datatype = c(
                          "auto", "character",
                          "double", "integer",
                          "logical", "Date"
                        ),
                        partitions = list(model_id = arrow::utf8())) {
  UseMethod("connect_hub")
}


#' @export
connect_hub.default <- function(hub_path,
                                file_format = c("csv", "parquet", "arrow"),
                                output_type_id_datatype = c(
                                  "auto", "character",
                                  "double", "integer",
                                  "logical", "Date"
                                ),
                                partitions = list(model_id = arrow::utf8())) {
  rlang::check_required(hub_path)
  output_type_id_datatype <- rlang::arg_match(output_type_id_datatype)

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
    file_format <- rlang::arg_match(file_format, multiple = TRUE)
  }
  hub_name <- config_admin$name

  # Only keep file formats of which files actually exist in model_output_dir.
  file_format <- check_file_format(model_output_dir, file_format)

  if (length(file_format) == 0L) {
    dataset <- list()
  } else {
    dataset <- open_hub_datasets(
      model_output_dir,
      file_format,
      config_tasks,
      output_type_id_datatype = output_type_id_datatype,
      partitions = partitions
    )
  }
  if (inherits(dataset, "UnionDataset")) {
    file_system <- purrr::map_chr(
      dataset$children,
      ~ class(.x$filesystem)[1]
    ) %>%
      unique()
  } else {
    file_system <- class(dataset$filesystem)[1]
    if (file_system == "NULL") file_system <- "local"
  }
  file_format <- get_file_format_meta(dataset, model_output_dir, file_format)
  # warn of any discrepancies between expected files in dir and successfully opened
  # files in dataset
  warn_unopened_files(file_format, dataset, model_output_dir)

  structure(dataset,
    class = c("hub_connection", class(dataset)),
    hub_name = hub_name,
    file_format = file_format,
    file_system = file_system,
    hub_path = hub_path,
    model_output_dir = model_output_dir,
    config_admin = config_admin,
    config_tasks = config_tasks
  )
}

#' @export
connect_hub.SubTreeFileSystem <- function(hub_path,
                                          file_format = c("csv", "parquet", "arrow"),
                                          output_type_id_datatype = c(
                                            "auto",
                                            "character",
                                            "double",
                                            "integer",
                                            "logical",
                                            "Date"
                                          ),
                                          partitions = list(model_id = arrow::utf8())) {
  rlang::check_required(hub_path)
  output_type_id_datatype <- rlang::arg_match(output_type_id_datatype)

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
    file_format <- rlang::arg_match(file_format, multiple = TRUE)
  }
  hub_name <- config_admin$name

  # Only keep file formats of which files actually exist in model_output_dir.
  file_format <- check_file_format(model_output_dir, file_format)

  if (length(file_format) == 0L) {
    dataset <- list()
  } else {
    dataset <- open_hub_datasets(
      model_output_dir,
      file_format,
      config_tasks,
      output_type_id_datatype = output_type_id_datatype,
      partitions = partitions
    )
  }

  if (inherits(dataset, "UnionDataset")) {
    file_system <- purrr::map_chr(
      dataset$children,
      ~ class(.x$filesystem$base_fs)[1]
    ) %>%
      unique()
  } else {
    file_system <- class(dataset$filesystem$base_fs)[1]
    if (file_system == "NULL") file_system <- hub_path$url_scheme
  }
  file_format <- get_file_format_meta(dataset, model_output_dir, file_format)
  # warn of any discrepancies between expected files in dir and successfully opened
  # files in dataset
  warn_unopened_files(file_format, dataset, model_output_dir)

  structure(dataset,
    class = c("hub_connection", class(dataset)),
    hub_name = hub_name,
    file_format = file_format,
    file_system = file_system,
    hub_path = hub_path$base_path,
    model_output_dir = model_output_dir$base_path,
    config_admin = config_admin,
    config_tasks = config_tasks
  )
}

open_hub_dataset <- function(model_output_dir,
                             file_format = c("csv", "parquet", "arrow"),
                             config_tasks,
                             output_type_id_datatype = c(
                               "auto", "character",
                               "double", "integer",
                               "logical", "Date"
                             ),
                             partitions = list(model_id = arrow::utf8())) {
  file_format <- rlang::arg_match(file_format)
  schema <- create_hub_schema(config_tasks,
    partitions = partitions,
    output_type_id_datatype = output_type_id_datatype
  )

  switch(file_format,
    csv = arrow::open_dataset(
      model_output_dir,
      format = "csv",
      partitioning = "model_id",
      col_types = schema,
      unify_schemas = FALSE,
      strings_can_be_null = TRUE,
      factory_options = list(exclude_invalid_files = TRUE)
    ),
    parquet = arrow::open_dataset(
      model_output_dir,
      format = "parquet",
      partitioning = "model_id",
      schema = schema,
      unify_schemas = FALSE,
      factory_options = list(exclude_invalid_files = TRUE)
    ),
    arrow = arrow::open_dataset(
      model_output_dir,
      format = "arrow",
      partitioning = "model_id",
      schema = schema,
      unify_schemas = FALSE,
      factory_options = list(exclude_invalid_files = TRUE)
    )
  )
}

open_hub_datasets <- function(model_output_dir,
                              file_format = c("csv", "parquet", "arrow"),
                              config_tasks,
                              output_type_id_datatype = c(
                                "auto", "character",
                                "double", "integer",
                                "logical", "Date"
                              ),
                              partitions = list(model_id = arrow::utf8()),
                              call = rlang::caller_env()) {
  if (length(file_format) == 1L) {
    open_hub_dataset(
      model_output_dir,
      file_format,
      config_tasks,
      output_type_id_datatype,
      partitions = partitions
    )
  } else {
    cons <- purrr::map(
      file_format,
      ~ open_hub_dataset(
        model_output_dir,
        .x,
        config_tasks,
        output_type_id_datatype,
        partitions = partitions
      )
    )

    arrow::open_dataset(cons)
  }
}

get_file_format <- function(config_admin,
                            file_format = c("csv", "parquet", "arrow"),
                            call = rlang::caller_env()) {
  config_file_format <- config_admin[["file_format"]]

  if (!rlang::is_missing(file_format)) {
    file_format <- rlang::arg_match(file_format)

    if (!file_format %in% config_file_format) {
      cli::cli_abort(
        c(
          "x" = "{.arg file_format} value {.val {file_format}} is not a valid
                file format available for this hub.",
          "!" = "Must be {?/one of}: {.val {config_file_format}}."
        ),
        call = call
      )
    }

    return(file_format)
  }

  if (length(config_file_format) == 0L) {
    cli::cli_abort(
      c(
        "x" = "{.arg file_format} value could not be extracted from config
            file {.field admin.json}.",
        "!" = "Use argument {.arg file_format} to specify a file format
            or contact hub maintainers for assistance."
      ),
      call = call
    )
  }

  return(config_file_format)
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
model_output_dir_path.SubTreeFileSystem <- function(hub_path, config_admin,
                                                    call = rlang::caller_env()) {
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

get_file_format_meta <- function(dataset, model_output_dir, file_format) {
  # Get number of files per file format successfully opened in dataset
  n_open <- lengths(list_dataset_files(dataset))
  if (is.null(names(n_open))) {
    return(NULL)
  }
  # to avoid confusion override renaming of arrow file format to ipc by arrow
  # package
  names(n_open)[names(n_open) == "ipc"] <- "arrow"

  # Ensure that entire file formats which should have been included aren't missing
  # from the dataset
  if (any(!file_format %in% names(n_open))) {
    n_open[setdiff(file_format, names(n_open))] <- 0
  }
  # Get number of files per file format that should be in the dataset that exist
  # in model out dir
  n_in_dir <- purrr::map_int(
    names(n_open),
    ~ file_format_n(model_output_dir, .x)
  )

  rbind(n_open, n_in_dir)
}

check_file_format <- function(model_output_dir, file_format,
                              call = rlang::caller_env(), error = FALSE) {
  dir_file_formats <- get_dir_file_formats(model_output_dir)
  valid_file_format <- file_format[file_format %in% dir_file_formats]

  if (length(valid_file_format) == 0L && error) {
    cli::cli_abort("No files of file format{?s}
                   {.val {file_format}}
                   found in model output directory.",
      call = call
    )
  }
  if (length(valid_file_format) == 0L) {
    cli::cli_warn("No files of file format{?s}
                   {.val {file_format}}
                   found in model output directory.",
      call = call
    )
  }
  valid_file_format
}

file_format_n <- function(model_output_dir, file_format) {
  checkmate::assert_string(file_format)
  UseMethod("file_format_n")
}

file_format_n.default <- function(model_output_dir, file_format) {
  length(
    fs::dir_ls(
      model_output_dir,
      recurse = TRUE,
      glob = paste0("*.", file_format)
    )
  )
}

file_format_n.SubTreeFileSystem <- function(model_output_dir, file_format) {
  sum(fs::path_ext(model_output_dir$ls(recursive = TRUE)) == file_format)
}


warn_unopened_files <- function(x, dataset, model_output_dir) {
  x <- as.data.frame(x)
  unopened_file_formats <- purrr::map_lgl(x, ~ .x[1] < .x[2])
  if (any(unopened_file_formats)) {
    dataset_files <- list_dataset_files(dataset)

    unopened_files <- purrr::map(
      purrr::set_names(names(x)[unopened_file_formats]),
      ~ list_dir_files(model_output_dir, file_format)
    ) %>%
      # check dir files against files opened in dataset
      purrr::imap(
        ~ .x[!.x %in% dataset_files[[.y]]]
      ) %>%
      purrr::list_simplify() %>%
      purrr::set_names("x")

    cli::cli_warn(
      c(
        "!" = "{cli::qty(length(unopened_files))} The following potentially
        invalid model output file{?s} not opened successfully.",
        sprintf("{.path %s}", unopened_files)
      )
    )
    invisible(FALSE)
  }
  invisible(TRUE)
}


list_dir_files <- function(model_output_dir, file_format = NULL) {
  checkmate::assert_string(file_format, null.ok = TRUE)
  UseMethod("list_dir_files")
}


list_dir_files.default <- function(model_output_dir, file_format = NULL) {
  if (is.null(file_format)) {
    file_format <- "*"
  }
  fs::dir_ls(
    model_output_dir,
    recurse = TRUE,
    glob = paste0("*.", file_format)
  )
}

list_dir_files.SubTreeFileSystem <- function(model_output_dir, file_format = NULL) {
  all_files <- model_output_dir$ls(recursive = TRUE)
  if (is.null(file_format)) {
    return(all_files)
  }
  all_files[fs::path_ext(all_files) == file_format]
}

list_dataset_files <- function(dataset) {
  UseMethod("list_dataset_files")
}

list_dataset_files.default <- function(dataset) {
  stats::setNames(
    list(dataset$files),
    dataset$format$type
  )
}

list_dataset_files.UnionDataset <- function(dataset) {
  stats::setNames(
    purrr::map(dataset$children, ~ .x$files),
    purrr::map_chr(dataset$children, ~ .x$format$type)
  )
}

get_dir_file_formats <- function(model_output_dir) {
  all_ext <- list_dir_files(model_output_dir) %>%
    fs::path_ext() %>%
    unique()

  intersect(all_ext, c("csv", "parquet", "arrow"))
}
