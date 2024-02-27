#' Get the json schema download URL for a given config file version
#'
#' @param config Name of config file to validate. One of `"tasks"` or `"admin"`.
#' @param version A valid version of Infectious Disease Modeling Hubs
#'   [schema](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   (e.g. `"v0.0.1"`).
#' @param branch The branch of the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   from which to fetch schema. Defaults to `"main"`.
#'
#' @return The json schema download URL for a given config file version.
#' @family functions supporting config file validation
#' @export
#'
#' @examples
#' get_schema_url(config = "tasks", version = "v0.0.0.9")
get_schema_url <- function(config = c("tasks", "admin", "model"),
                           version, branch = "main") {
    config <- rlang::arg_match(config)
    rlang::check_required(version)

    # Ensure the version determined is valid and a folder exists in our GitHub schema
    # repo
    validate_schema_version(version, branch = branch)

    schema_repo <- "Infectious-Disease-Modeling-Hubs/schemas"
    glue::glue("https://raw.githubusercontent.com/{schema_repo}/{branch}/{version}/{config}-schema.json")
}

#' Get a vector of valid schema version
#'
#' @inheritParams get_schema_url
#'
#' @return a character vector of valid versions of Infectious Disease Modeling Hubs
#'   [schema](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#' @family functions supporting config file validation
#' @export
#' @examples
#' get_schema_valid_versions()
get_schema_valid_versions <- function(branch = "main") {
    branches <- gh::gh(
        "GET /repos/Infectious-Disease-Modeling-Hubs/schemas/branches"
    ) %>%
        vapply("[[", "", "name")

    if (!branch %in% branches) {
        cli::cli_abort(c(
            "x" = "{.val {branch}} is not a valid branch in schema repository
                   {.url https://github.com/Infectious-Disease-Modeling-Hubs/schemas/branches}",
            "i" = "Current valid branches are: {.val {branches}}"
        ))
    }

    req <- gh::gh("GET /repos/Infectious-Disease-Modeling-Hubs/schemas/git/trees/{branch}",
                  branch = branch
    )

    types <- vapply(req$tree, "[[", "", "type")
    paths <- vapply(req$tree, "[[", "", "path")
    dirs_lgl <- types == "tree" & grepl("^v([0-9]\\.){2}[0-9](\\.[0-9]+)?", paths)

    paths[dirs_lgl]
}

#' Download a schema
#'
#' @param schema_url The download URL for a given config schema version.
#'
#' @return Contents of the json schema as a character string.
#' @family functions supporting config file validation
#' @export
#' @examples
#' schema_url <- get_schema_url(config = "tasks", version = "v0.0.0.9")
#' get_schema(schema_url)
get_schema <- function(schema_url) {
    response <- try(curl::curl_fetch_memory(schema_url), silent = TRUE)

    if (inherits(response, "try-error")) {
        cli::cli_abort(
            "Connection to schema repository failed. Please check your internet connection.
            If the problem persists, please open an issue at:
            {.url https://github.com/Infectious-Disease-Modeling-Hubs/schemas}"
        )
    }

    if (response$status_code == 200L) {
        response$content %>%
            rawToChar() %>%
            jsonlite::prettify()
    } else {
        cli::cli_abort(
            "Attempt to download schema from {.url {schema_url}} failed with status code: {.field {response$status_code}}."
        )
    }
}

validate_schema_version <- function(schema_version, branch) {
    valid_versions <- get_schema_valid_versions(branch = branch)

    if (schema_version %in% valid_versions) {
        invisible(schema_version)
    } else {
        cli::cli_abort(
            "{.val {schema_version}} is not a valid schema version.
            Current valid schema version{?s} {?is/are}: {.val {valid_versions}}.
            For more details, visit {.url https://github.com/Infectious-Disease-Modeling-Hubs/schemas}"
        )
    }
}
