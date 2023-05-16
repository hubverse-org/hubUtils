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
              file_system = class(dataset$filesystem)[1],
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
              file_system = class(dataset$filesystem$base_fs)[1],
              model_output_dir = model_output_dir$base_path
    )
}
