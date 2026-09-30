#' Read a model metadata file into R
#'
#' Reads a model metadata YAML file into a named list.
#'
#' @details
#' Every array in the file is returned as a list, including an array with a
#' single element. For example, `methods: ["one"]` is returned as
#' `list("one")` and not as the string `"one"`.
#'
#' @param path A character string of the path to a local model metadata YAML
#' file.
#' @return The contents of the metadata file as a named list, or `NULL` for an
#' empty file.
#' @export
#' @examples
#' hub_path <- system.file("testhubs/simple", package = "hubUtils")
#' path <- fs::path(hub_path, "model-metadata", "team1-goodmodel.yaml")
#' read_model_metadata(path)
read_model_metadata <- function(path) {
  checkmate::assert_string(path)
  checkmate::assert_file_exists(path, extension = c("yml", "yaml"))
  yaml::read_yaml(path, handlers = list(seq = identity))
}
