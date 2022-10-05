#' Read a `hubmeta` file
#'
#' Read a `hubmeta` file of hub metadata contained in `JSON` or `YAML` format.
#' Where applicable, the function also substitutes any `$ref` element with values
#' contained in the element in `$defs` defined by the value of the `$ref` element.
#' @param path path to the `hubmeta file`.
#' @param drop_defs logical. Whether to drop the `$defs` element of the metadata
#'   (where applicable).
#'
#' @return a list of hub metadata.
#' @export
#'
#' @examples
#' # Read a JSON `hubmeta` file
#' json_path <- system.file("hubmeta/scnr_hubmeta_ref.json", package = "hubUtils")
#' read_hubmeta(json_path)
#' # Read a JSON `hubmeta` file and keep `$defs` element
#' yml_path <- system.file("hubmeta/scnr_hubmeta_ref.yml", package = "hubUtils")
#' read_hubmeta(yml_path, drop_defs = FALSE)
read_hubmeta <- function(path, drop_defs = TRUE) {

    if (!fs::file_exists(path)){
        cli::cli_abort(
            "File {.path { path }} does not exist."
        )
    }

    ext <- fs::path_ext(path)
    valid_ext <- c('json', 'yaml', 'yml')

    if (!ext %in% valid_ext) {
        cli::cli_abort(
            c(
                "{.var hubmeta} file extension should be one of {.val { valid_ext }}",
                x ="File {.file { path }} has extension {.val { ext }}"
            )
        )
    }

    if (ext == "yaml") ext <- "yml"

    hubmeta <- switch (
        ext,
        json = jsonlite::read_json(path,
                                   simplifyVector = TRUE,
                                   simplifyDataFrame = FALSE),
        yml = yaml::read_yaml(path)
    )



    defs_idx <- names(hubmeta) == "$defs"

    if (any(defs_idx)) {
        defs <- hubmeta[defs_idx]
        hubmeta <- hubmeta[!defs_idx]

        hubmeta <- substitute_refs(hubmeta, defs)

        if (!drop_defs) {
            hubmeta <- c(hubmeta, defs)
        }

        return(hubmeta)
    }


}

#' Substitute references with definitions
#'
#' The function recursively scans a `hubmeta` list and substitutes any `$ref`
#' element identified with values contained in the element in `$defs` defined by
#' the value of the `$ref` element being processed.
#' @param x a hubmeta list with the `$defs` element removed
#' @param defs the hubmeta list `$defs` element
#'
#' @importFrom rlang `!!!`
#' @return x with any elements labelled with `$ref` replaced with the contents of the
#'   definition specified by the value in `$ref`.
#' @noRd
substitute_refs <- function(x, defs){

    if(is.list(x)){
        is_ref <- names(x) == "$ref"

        if (any(is_ref)) {
            def_location <- x[[is_ref]]

            def_idx <- gsub("#/", "", def_location, fixed = TRUE) |>
                strsplit(split = "/") |>
                unlist() |>
                as.list()

            replace <- purrr::pluck(defs, !!!def_idx)

            if (is.null(replace)) {
                cli::cli_abort(
                    c(x = "definition for def {.val { def_location }} returning {.var NULL} ")
                )
            } else {
                x <- replace
            }
        } else {
            lapply(x, substitute_refs, defs = defs)
        }
    }else{
        x
    }
}

