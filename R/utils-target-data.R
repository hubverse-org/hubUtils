#' Get target data configuration properties
#'
#' @description
#' Utility functions for extracting properties from target-data.json configuration
#' files (v6.0.0 schema). These functions handle defaults and inheritance patterns
#' for target data configuration.
#'
#' @name target-data-utils
#' @param config_target_data A target-data config object created by
#'   `read_config(hub_path, "target-data")`.
#' @param dataset Character string specifying the dataset type: either
#'   `"time-series"` or `"oracle-output"`. Used for functions that extract
#'   dataset-specific properties.
#'
#' @details
#' ## Inheritance and Defaults
#'
#' Some properties can be specified at both the global level and the dataset level:
#' - **observable_unit**: Dataset-specific values override global when specified,
#'   otherwise the global value is used.
#' - **versioned**: Dataset-specific values override global when specified,
#'   otherwise inherits from global (default `FALSE` if not specified anywhere).
#'
#' Other properties are dataset-specific only:
#' - **has_output_type_ids**: Only for oracle-output dataset (default `FALSE`)
#' - **non_task_id_schema**: Only for time-series dataset (default `NULL`)
#'
#' @examples
#' hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
#' config <- read_config(hub_path, "target-data")
#'
#' # Get the date column name
#' get_date_col(config)
#'
#' # Get observable unit (uses dataset-specific or falls back to global)
#' get_observable_unit(config, dataset = "time-series")
#' get_observable_unit(config, dataset = "oracle-output")
#'
#' # Get versioned setting (inherits from global if not specified)
#' get_versioned(config, dataset = "time-series")
#'
#' # Get oracle-output specific property
#' get_has_output_type_ids(config)
#'
#' # Get time-series specific property
#' get_non_task_id_schema(config)
#'
#' # Check if target data config exists
#' has_target_data_config(hub_path)
#' no_config_hub <- system.file("testhubs/v5/target_file/", package = "hubUtils")
#' has_target_data_config(no_config_hub)
NULL

#' @describeIn target-data-utils Get the name of the date column across hub data.
#' @return `get_date_col()` returns a character string: the name of the date
#'   column that stores the date on which observed data actually occurred.
#' @export
get_date_col <- function(config_target_data) {
  config_target_data$date_col
}

#' @describeIn target-data-utils Get observable unit column names. Returns
#'   dataset-specific observable_unit if configured, otherwise falls back to global.
#' @return `get_observable_unit()` returns a character vector: column names
#'   whose unique value combinations define the minimum observable unit.
#' @export
get_observable_unit <- function(
  config_target_data,
  dataset = c("time-series", "oracle-output")
) {
  # Validate dataset parameter
  dataset <- rlang::arg_match(dataset)

  # Get global observable_unit
  global_observable_unit <- config_target_data$observable_unit

  # Get dataset-specific observable_unit if present
  dataset_config <- config_target_data[[dataset]]
  if (is.null(dataset_config)) {
    return(global_observable_unit)
  }

  dataset_observable_unit <- dataset_config$observable_unit
  if (is.null(dataset_observable_unit)) {
    return(global_observable_unit)
  }

  dataset_observable_unit
}

#' @describeIn target-data-utils Get whether target data is versioned for the
#'   specified dataset. Returns dataset-specific setting if configured, otherwise
#'   inherits from global (default `FALSE` if not specified).
#' @return `get_versioned()` returns a logical value: whether the dataset is
#'   versioned using `as_of` dates.
#' @export
get_versioned <- function(
  config_target_data,
  dataset = c("time-series", "oracle-output")
) {
  # Validate dataset parameter
  dataset <- rlang::arg_match(dataset)

  # Get global versioned (default to FALSE if not specified)
  global_versioned <- config_target_data$versioned %||% FALSE

  # Get dataset-specific versioned if present, otherwise inherit global
  dataset_config <- config_target_data[[dataset]]
  if (is.null(dataset_config)) {
    return(global_versioned)
  }

  dataset_versioned <- dataset_config$versioned
  if (is.null(dataset_versioned)) {
    return(global_versioned)
  }

  dataset_versioned
}

#' @describeIn target-data-utils Get whether oracle-output data has
#'   output_type/output_type_id columns.
#' @return `get_has_output_type_ids()` returns a logical value: whether
#'   oracle-output data has `output_type` and `output_type_id` columns (default
#'   `FALSE` if not specified).
#' @export
get_has_output_type_ids <- function(config_target_data) {
  oracle_config <- config_target_data[["oracle-output"]]
  if (is.null(oracle_config)) {
    return(FALSE) # default
  }

  oracle_config$has_output_type_ids %||% FALSE
}

#' @describeIn target-data-utils Get the schema for non-task ID columns in
#'   time-series data.
#' @return `get_non_task_id_schema()` returns a named list: key-value pairs of
#'   non-task ID column names and their data types, or `NULL` if not specified.
#' @export
get_non_task_id_schema <- function(config_target_data) {
  ts_config <- config_target_data[["time-series"]]
  if (is.null(ts_config)) {
    return(NULL)
  }

  ts_config$non_task_id_schema
}

#' @describeIn target-data-utils Check if target data config file exists in hub.
#' @param hub_path Path to a hub. Can be a local directory path or cloud URL
#'   (S3, GCS).
#' @return `has_target_data_config()` returns a logical value: `TRUE` if the
#'   target-data.json file exists in the `hub-config` directory of the hub,
#'   `FALSE` otherwise.
#' @export
has_target_data_config <- function(hub_path) {
  UseMethod("has_target_data_config")
}

#' @rdname target-data-utils
#' @export
has_target_data_config.default <- function(hub_path) {
  fs::file_exists(
    fs::path(hub_path, "hub-config", "target-data.json")
  )
}

#' @rdname target-data-utils
#' @export
has_target_data_config.SubTreeFileSystem <- function(hub_path) {
  config_path <- fs::path("hub-config", "target-data.json")
  hub_path$GetFileInfo(config_path)[[1]]$type != 0L
}
