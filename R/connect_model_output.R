#' @export
#' @param schema An [arrow::Schema] object for the Dataset.
#' If NULL (the default), the schema will be inferred from the data sources. Note
#' that for `"csv"` file_format connections, the schema should NOT contain fields for
#' any partition variables. For `"parquet"` and `"arrow"` schema should contain
#' fields for partition variables.
#' @param partition_names character vector that defines the field names to which
#' recursive directory names correspond to. Defaults to a single `model_id` field
#' which reflects the standard expected structure of a `model-output` directory.
#' @describeIn connect_hub connect directly to a `model-output` directory. This
#' function can be used to access data directly from an appropriately set up
#' model output directory which is not part of a fully configured hub.
connect_model_output <- function(model_output_dir,
                                 file_format = c("csv", "parquet", "arrow"),
                                 partition_names = "model_id",
                                 schema = NULL) {
    UseMethod("connect_model_output")
}

#' @export
connect_model_output.default <- function(model_output_dir,
                                         file_format = c("csv", "parquet", "arrow"),
                                         partition_names = "model_id",
                                         schema = NULL) {
    rlang::check_required(model_output_dir)
    if (!dir.exists(model_output_dir)) {
        cli::cli_abort(c("x" = "Directory {.path {model_output_dir}} does not exist."))
    }
    file_format <- rlang::arg_match(file_format)

    if (file_format == "csv") {
        dataset <- arrow::open_dataset(
            model_output_dir,
            format = file_format,
            partitioning = partition_names,
            col_types = schema,
            unify_schemas = FALSE,
            strings_can_be_null = TRUE,
            factory_options = list(exclude_invalid_files = TRUE)
        )
    } else {
        dataset <- arrow::open_dataset(
            model_output_dir,
            format = file_format,
            partitioning = partition_names,
            schema = schema,
            unify_schemas = FALSE,
            factory_options = list(exclude_invalid_files = TRUE)
        )
    }


    structure(dataset,
              class = c("mod_out_connection", class(dataset)),
              file_format = file_format,
              file_system = class(dataset$filesystem)[1],
              model_output_dir = model_output_dir
    )
}

#' @export
connect_model_output.SubTreeFileSystem <- function(model_output_dir,
                                                   file_format = c("csv", "parquet", "arrow"),
                                                   partition_names = "model_id",
                                                   schema = NULL) {
    rlang::check_required(model_output_dir)
    file_format <- rlang::arg_match(file_format)

    if (file_format == "csv") {
        dataset <- arrow::open_dataset(
            model_output_dir,
            format = file_format,
            partitioning = partition_names,
            schema = schema,
            unify_schemas = TRUE,
            strings_can_be_null = TRUE,
            factory_options = list(exclude_invalid_files = TRUE)
        )
    } else {
        dataset <- arrow::open_dataset(
            model_output_dir,
            format = file_format,
            partitioning = partition_names,
            schema = schema,
            unify_schemas = TRUE,
            factory_options = list(exclude_invalid_files = TRUE)
        )
    }

    structure(dataset,
              class = c("mod_out_connection", class(dataset)),
              file_format = file_format,
              file_system = class(dataset$filesystem$base_fs)[1],
              model_output_dir = model_output_dir$base_path
    )
}
