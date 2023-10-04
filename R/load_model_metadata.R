#' Load in metadata for a specified group of models into a tibble with one row per model.
#'
#' @param hub_path Either a character string path to a local Modeling Hub directory
#' or an object of class `<SubTreeFileSystem>` created using functions [s3_bucket()]
#' or [gs_bucket()] by providing a string S3 or GCS bucket name or path to a
#' Modeling Hub directory stored in the cloud.
#' For more details consult the
#' [Using cloud storage (S3, GCS)](https://arrow.apache.org/docs/r/articles/fs.html)
#' in the `arrow` package.
#' @param model_ids A vector of character strings of models for which to load 
#'   metadata. Defaults to NULL, in which case metadata for all models is loaded.
#'
#' @return `tibble` with model metadata. One row for each model, one column for each top-level field in the metadata file. For metadata files with nested structures, this tibble may contain list-columns where the entries are lists containing the nested metadata values.
#' @export
#'
#' @examples
#' # Load in model metadata from local hub
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' read_config(hub_path)
#' # load_model_metadata file from AWS S3 bucket hub
#' hub_path <- s3_bucket("hubverse/hubutils/testhubs/simple/")
#' load_model_metadata(hub_path)
load_model_metadata <- function(hub_path, model_ids) {
  UseMethod("load_model_metadata")
}


#' @export
load_model_metadata.default <- function(hub_path, model_ids = NULL) {
  metadata_dir <- fs::path(hub_path, "model-metadata")
  metadata_paths <- fs::dir_ls(metadata_dir)
#  metadata_paths <- list.files(as .character(metadata_dir), recursive=TRUE)

  if (!fs::dir_exists(metadata_dir)) {
    cli::cli_abort(
      "Model metadata directory does not exist in hub at at path {.metadata_dir { metadata_dir }}."
    )
  }
  
  model_info <- metadata_paths |>
    purrr::map(function(path) {
      temp <- path |>
        yaml::read_yaml() |>
        enframe() |>
        tidyr::pivot_wider(names_from="name", values_from="value") 
        
      if (all(c("team_abbr", "model_abbr") %in% names(temp)) & isFALSE(("model_id") %in% names(temp))) {
        temp <- hubUtils::model_id_merge(temp, sep="-") |>
          mutate(model_id=as.list(model_id))
      } else if (isFALSE(c("team_abbr", "model_abbr") %in% names(temp)) & ("model_id" %in% names(temp))) {
        temp <- hubUtils::model_id_split(temp, sep="-")
      }
      
      col_types <- rep("type", ncol(temp))
      not_list_indices <- list()
      for (i in 1:ncol(temp)) {
        col_types[i] <- temp |> pull(i) |> pluck(1) |> class()
        if (col_types[i] != "list") not_list_indices[[i]] <- i
      }
      not_list_indices <- unlist(not_list_indices)
    
      temp |>
        tidyr::unnest(not_list_indices)
    }) |>
    purrr::list_rbind()

  # Error or warning if a supplied model is not among those with metadata?
  if (!is.null(model_ids)) model_info <- dplyr::filter(model_info, model_id %in% model_ids)

  return (model_info)
}
