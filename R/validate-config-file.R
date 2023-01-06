#' Validate a hub config file against a Infectious Disease Modeling Hubs schema
#'
#' @param hub_path Path to a local hub directory.
#' @param config Name of config file to validate. One of `"tasks"` or `"admin"`.
#' @param config_path Defaults to `NULL` which assumes all config files are in
#'   the `hub-config` directory in the root of hub directory. Argument `config_path`
#'   can be used to override default by providing a path to the config file to be
#'   validated.
#' @param schema_version Character string specifying the json schema version to
#'   be used for validation. The default value `"from_config"` will use the version
#'   specified in the `schema_version` property of the config file. `"latest"` will
#'   use the latest version available in the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#'   Alternartively, a specific version of a schema (e.g. `"v0.0.1"`)  can be specified.
#' @param branch The branch of the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   from which to fetch schema. Defaults to `"main"`.
#' @param pretty_errors Whether to launch an informative pretty table of any
#'   validation errors in the Viewer panel. Will only launch run in an interactive
#'   environment.
#' @return Returns the result of validation. If validation is successful, will
#'   return `TRUE`. If any validation errors are detected, returns `FALSE` with
#'   details of errors appended as a data.frame to an `errors` attribute. To access
#'   the errors table use `attr(x, "errors")` where `x` is the output of the function.
#' @export
#'
#' @examples
#' # Valid config file
#' validate_config(
#'   hub_path = system.file(
#'     "testhubs/simple/",
#'     package = "hubUtils"
#'   ),
#'   config = "tasks"
#' )
#' # Config file with errors
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks")
validate_config <- function(hub_path = ".",
                            config = c("tasks", "admin"),
                            config_path = NULL, schema_version = "from_config",
                            branch = "main",
                            pretty_errors = FALSE) {
  config <- rlang::arg_match(config)

  if (is.null(config_path)) {
    checkmate::assert_directory_exists(hub_path)
    config_path <- fs::path(hub_path, "hub-config", config, ext = "json")
  }

  # check config file to be checked exists and is correct extension
  checkmate::assert_file_exists(config_path, extension = "json")

  if (schema_version == "from_config") {
    schema_version <- get_config_schema_version(config_path)
  }

  # Get the latest version available in our GitHub schema repo
  if (schema_version == "latest") {
    schema_version <- get_schema_valid_versions(branch = branch) %>%
      sort() %>%
      utils::tail(1)
  }

  schema_url <- get_schema_url(
    config = config,
    version = schema_version,
    branch = branch
  )

  schema_json <- get_schema(schema_url)


  validation <- jsonvalidate::json_validate(
    json = config_path,
    schema = schema_json,
    engine = "ajv",
    verbose = TRUE
  )

  attr(validation, "config_path") <- config_path
  attr(validation, "schema_version") <- schema_version
  attr(validation, "schema_url") <- schema_url


  if (validation) {
    cli::cli_alert_success(
      "Successfully validated config file {.file {config_path}}"
    )
  } else {
    cli::cli_warn(
      "Schema errors detected in config file {.file {config_path}}"
    )

    if (pretty_errors) {
      print(
        launch_pretty_errors_report(validation)
      )
    }
  }
  return(validation)
}


.get_schema_valid_versions <- function(branch = "main") {
  req <- gh::gh("GET /repos/Infectious-Disease-Modeling-Hubs/schemas/git/trees/{branch}",
    branch = branch
  )

  types <- vapply(req$tree, "[[", "", "type")
  paths <- vapply(req$tree, "[[", "", "path")
  dirs_lgl <- types == "tree" & grepl("^v([0-9]\\.){2}[0-9](\\.[0-9]+)?", paths)

  paths[dirs_lgl]
}


#' Get a vector of valid schema version
#'
#' @inheritParams validate_config
#'
#' @return a character vector of valid versions of Infectious Disease Modeling Hubs
#'   [schema](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#' @export
#' @examples
#' get_schema_valid_versions()
get_schema_valid_versions <- memoise::memoise(.get_schema_valid_versions)


get_config_schema_version <- function(config_path) {
  config_schema_version <- jsonlite::read_json(config_path)$schema_version

  if (is.null(config_schema_version)) {
    error_detail <- c("x" = "Property {.val schema_version} not found in file.")
  }

  version <- stringr::str_extract(
    config_schema_version,
    "v([0-9]\\.){2}[0-9](\\.[0-9]+)?"
  )

  if (length(version) == 0L) {
    error_detail <- c("!" = "Please check property {.val schema_version} is correct.")
    cli::cli_abort(
      c(
        "Valid {.field version} could not be extracted from config
            file {.file {config_path}}",
        error_detail
      )
    )
  }

  version
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

#' Get the json schema download URL for a given config file version
#'
#' @inheritParams validate_config
#' @param version A valid version of Infectious Disease Modeling Hubs
#'   [schema](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   (e.g. `"v0.0.1"`).
#'
#' @return The json schema download URL for a given config file version.
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

.get_schema <- function(schema_url) {
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

#' Download a schema
#'
#' @param schema_url The download URL for a given config schema version.
#'
#' @return Contents of the json schema as a character string.
#' @export
#' @examples
#' schema_url <- get_schema_url(config = "tasks", version = "v0.0.0.9")
#' get_schema(schema_url)
get_schema <- memoise::memoise(.get_schema)


#' Print a concise and informative version of validation errors table
#'
#' @param x output of [validate_config].
#'
#' @return prints the errors attribute of x in an informative format to the viewer. Only
#' available in interactive mode.
#' @noRd
launch_pretty_errors_report <- function(x) {
  errors_tbl <- attr(x, "errors")
  config_path <- attr(x, "config_path")
  schema_version <- attr(x, "schema_version")
  schema_url <- attr(x, "schema_url")

  title <- gt::md("**`hubUtils` config validation error report**")
  subtitle <- gt::md(
    glue::glue("Report for file **`{config_path}`** using
                   schema version [**{schema_version}**]({schema_url})")
  )

  errors_tbl[c("dataPath", "parentSchema", "params")] <- NULL
  errors_tbl <- errors_tbl[!grepl("oneOf.+", errors_tbl$schemaPath), ]

  n_col <- length(errors_tbl)

  error_df <- split(errors_tbl, 1:nrow(errors_tbl)) %>%
    purrr::map_df(
      ~ unlist(.x, recursive = FALSE) %>% purrr::map(~ process_element(.x))
    ) %>%
    # split long column names
    stats::setNames(gsub("\\.", " ", names(.)))


  # format path and error message columns
  error_df[["schemaPath"]] <- purrr::map_chr(error_df[["schemaPath"]], path_to_tree)
  error_df[["instancePath"]] <- purrr::map_chr(error_df[["instancePath"]], path_to_tree)
  error_df[["message"]] <- paste("\u274c", error_df[["message"]])


  # Create table ----
  gt::gt(error_df) %>%
    gt::tab_header(
      title = title,
      subtitle = subtitle
    ) %>%
    gt::tab_spanner(
      label = gt::md("**Error location**"),
      columns = c(
        "instancePath",
        "schemaPath"
      )
    ) %>%
    gt::tab_spanner(
      label = gt::md("**Schema details**"),
      columns = c(
        "keyword",
        "message",
        "schema"
      )
    ) %>%
    gt::tab_spanner(
      label = gt::md("**Config**"),
      columns = "data"
    ) %>%
    gt::fmt_markdown(columns = c(
      "instancePath",
      "schemaPath",
      "schema"
    )) %>%
    gt::tab_style(
      style = gt::cell_text(whitespace = "pre"),
      locations = gt::cells_body(columns = c(
        "instancePath",
        "schemaPath",
        "schema"
      ))
    ) %>%
    gt::tab_style(
      style = gt::cell_text(whitespace = "pre-wrap"),
      locations = gt::cells_body(columns = "schema")
    ) %>%
    gt::tab_style(
      style = list(
        gt::cell_fill(color = "#F9E3D6"),
        gt::cell_text(weight = "bold")
      ),
      locations = gt::cells_body(
        columns = c("message", "data")
      )
    ) %>%
    gt::cols_width(
      "schema" ~ gt::pct(1.5 / 6 * 100),
      "data" ~ gt::pct(1 / 6 * 100),
      "message" ~ gt::pct(1 / 6 * 100)
    ) %>%
    gt::cols_align(
      align = "center",
      columns = c(
        "keyword",
        "message",
        "data"
      )
    ) %>%
    gt::tab_options(
      column_labels.font.weight = "bold",
      table.margin.left = gt::pct(2),
      table.margin.right = gt::pct(2),
      data_row.padding = gt::px(5),
      heading.background.color = "#F0F3F5",
      column_labels.background.color = "#F0F3F5"
    ) %>%
    gt::tab_source_note(
      source_note = gt::md("For more information, please consult the
                                 [**`hubDocs` documentation**.](https://hubdocs.readthedocs.io/en/latest/)")
    )
}



path_to_tree <- function(x) {
  # Split up path and remove blank and root elements
  paths <- strsplit(x, "/") %>%
    unlist() %>%
    as.list()
  paths <- paths[!(paths == "" | paths == "#")]

  # Highlight property names and convert from 0 to 1 array index
  paths <- paths %>%
    purrr::map_if(
      !is.na(as.numeric(paths)),
      ~ as.numeric(.x) + 1
    ) %>%
    purrr::map_if(
      !paths %in% c("items", "properties"),
      ~ paste0("**", .x, "**")
    ) %>%
    unlist() %>%
    suppressWarnings()

  # build path tree
  for (i in 2:length(paths)) {
    paths[i] <- paste0("\u2514", paste(rep("\u2500", times = i - 2),
      collapse = ""
    ), paths[i])
  }

  paste(paths, collapse = " \n ")
}



dataframe_to_markdown <- function(x) {
  split(x, 1:nrow(x)) %>%
    purrr::map(
      ~ unlist(.x, use.names = TRUE) %>%
        stats::setNames(gsub("properties\\.", "", names(.))) %>%
        stats::setNames(gsub("\\.", "-", names(.))) %>%
        remove_null_properties() %>%
        paste0("**", names(.), ":** ", .) %>%
        paste(collapse = " \n ")
    ) %>%
    unlist(use.names = TRUE) %>%
    paste0("**", names(.), "** \n ", .) %>%
    paste(collapse = "\n\n ") %>%
    gsub("[^']NA", "'NA'", .)
}



process_element <- function(x) {
  if (inherits(x, "data.frame")) {
    return(dataframe_to_markdown(x))
  }

  vector_to_character(x)
}

vector_to_character <- function(x) {
  # unlist and collapse list columns
  out <- unlist(x, recursive = TRUE, use.names = TRUE)

  if (length(names(out)) != 0L) {
    out <- paste0(names(out), ": ", out)
  }
  out %>% paste(collapse = ", ")
}



remove_null_properties <- function(x) {
  null_maxitem <- names(x[is.na(x) & grepl("maxItems", names(x))])
  x[!names(x) %in% c(
    null_maxitem,
    gsub(
      "maxItems", "const",
      null_maxitem
    )
  )]
}
