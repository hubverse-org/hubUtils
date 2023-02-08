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
#'   validation errors in the Viewer panel. Defaults to `TRUE`.
#' @return Returns the result of validation. If validation is successful, will
#'   return `TRUE`. If any validation errors are detected, returns `FALSE` with
#'   details of errors appended as a data.frame to an `errors` attribute. To access
#'   the errors table use `attr(x, "errors")` where `x` is the output of the function.
#' @export
#' @seealso launch_pretty_errors_report
#' @family schema-validation
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
#' validate_config(config_path = config_path, config = "tasks", pretty_errors = FALSE)
#'
#' # Print pretty errors in help & pkgdown documentation. Not necessary when running
#' # interactively.
#' validate_config(config_path = config_path,
#'                 config = "tasks", pretty_errors = FALSE) |>
#'                 launch_pretty_errors_report() |>
#'                 gt::as_raw_html()
validate_config <- function(hub_path = ".",
                            config = c("tasks", "admin"),
                            config_path = NULL, schema_version = "from_config",
                            branch = "main") {
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


  if (validation && config == "tasks") {
    validation <- validate_config_target_keys(validation)
  }

  if (validation) {
    cli::cli_alert_success(
      "Successfully validated config file {.file {config_path}} against schema {.url {schema_url}}"
    )
  } else {
    cli::cli_warn(
      "Schema errors detected in config file {.file {config_path}} validated against schema {.url {schema_url}}"
    )
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


validate_config_target_keys <- function(validation) {
  if (!validation) {
    return(validation)
  }

  config_json <- jsonlite::read_json(attr(validation, "config_path"),
                                     simplifyVector = TRUE,
                                     simplifyDataFrame = FALSE)
  schema <- get_schema(attr(validation, "schema_url"))


  errors_tbl <- purrr::imap(config_json[["rounds"]],
                            ~val_round(round = .x, rnd_i = .y,
                                       schema = schema)) %>%
    purrr::list_rbind()

  if (!is.null(errors_tbl)) {
    # assign FALSE without loosing attributes
    validation[] <- FALSE
    attr(validation, "errors") <- errors_tbl
  }

  return(validation)
}


val_round <- function(round, rnd_i, schema) {

  mt_grps <- round[["model_tasks"]]

  purrr::imap(mt_grps,
              ~val_mt_grp(mt_grp = .x, mt_i = .y,
                          rnd_i = rnd_i, schema = schema)) %>%
    purrr::list_rbind()
}



val_mt_grp <- function(mt_grp, mt_i, rnd_i, schema) {

  grp_tks <- get_grp_tks(mt_grp)

  # If all target keys are NULL, exit checks
  if (all(purrr::map_lgl(grp_tks, ~is.null(.x)))) {
    return(NULL)
  }

  # Check that target key names across items in target metadata array are consistent.
  # If not returns error early as further checks may fail unexpectedly.
  errors_check_1 <- val_tk_nms_const(grp_tks, mt_grp,
                                     mt_i, rnd_i, schema)

  if (!is.null(errors_check_1)) {
    return(errors_check_1)
  }

  # Check whether target key names do not correspond to task_id properties
  invalid_tk_nms <- purrr::map(grp_tks,
                               ~find_inval_tks(.x, mt_grp)) %>%
    unlist(use.names = FALSE)

  # If any do not correspond, run validation function to generate errors rows.
  # Otherwise assign NULL to errors_check_2
  if (any(invalid_tk_nms)) {

    errors_check_2 <- purrr::imap(grp_tks,
                                  ~val_tk_nms(.x, tk_i = .y,
                                              mt_grp = mt_grp,
                                              mt_i = mt_i,
                                              rnd_i = rnd_i,
                                              schema = schema)) %>%
      purrr::list_rbind()
  } else {
    errors_check_2 <- NULL
  }
  # If none of the target key names match task id properties, return errors_check_2
  # early as further checks become redundant.
  if (all(invalid_tk_nms)) {
    return(errors_check_2)
  }

  # Check that the values of each target keys have matching values in the corresponding
  # task_id required & optional property arrays.
  errors_check_3 <- purrr::imap(grp_tks,
                                ~val_tk_vals(.x, mt_grp,
                                             tk_i = .y,
                                             mt_i = mt_i,
                                             rnd_i = rnd_i,
                                             schema = schema))  %>%
    purrr::list_rbind()

  # Check that the unique values in the required & optional property arrays
  #  of each task_id identified as a target key have a matching
  #  value in the corresponding target key of at least one target metadata item.
  errors_check_4 <- val_tk_tid_vals(grp_tks, mt_grp,
                                    mt_i = mt_i,
                                    rnd_i = rnd_i,
                                    schema = schema)
  # Combine all error checks
  rbind(errors_check_2,
        errors_check_3,
        errors_check_4)

}


val_tk_nms_const <- function(grp_tks, mt_grp,
                             mt_i, rnd_i, schema) {

  tk_nms <- purrr::map(grp_tks, ~names(.x)) %>%
    purrr::map_if(~!is.null(.x), ~.x, .else = ~"null")

  if (length(unique(tk_nms)) > 1){
    error_row <- data.frame(
      instancePath = glue::glue(get_error_path(schema, "target_keys", "instance")),
      schemaPath =  get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key names not consistent across target_metadata array items"),
      schema = "",
      data = glue::glue("target_key_{seq_along(tk_nms)}: {purrr::map_chr(tk_nms,
        ~paste(.x, collapse = ','))}") %>%
        glue::glue_collapse(sep = ";  ")
    )
    return(error_row)
  }
  return(NULL)
}

val_tk_nms <- function(tks, mt_grp, tk_i, mt_i, rnd_i, schema) {

  check <- find_inval_tks(tks, mt_grp)

  if (any(check)) {

    error_row <- data.frame(
      instancePath = paste0(glue::glue(get_error_path(schema, "target_keys", "instance")),
                            "/", names(check[check])),
      schemaPath =  get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key(s) '{names(check[check])}' not properties of modeling task group task IDs"),
      schema = "",
      data = glue::glue("task_id names: {glue::glue_collapse(get_grp_tids(mt_grp), sep = ', ')};
            target_key names: {glue::glue_collapse(names(tks), sep = ', ')}")
    )

    return(error_row)

  } else {
    return(NULL)
  }
}




val_tk_vals <- function(tks, mt_grp, tk_i, mt_i, rnd_i, schema) {

  check <- !find_inval_tks(tks, mt_grp)

  valid_tks <- tks[check]

  tid_vals <- purrr::map(names(valid_tks),
                         ~mt_grp[["task_ids"]][[.x]] %>%
                           unlist(recursive = TRUE, use.names = FALSE)) %>%
    purrr::set_names(names(valid_tks))


  is_invalid_tk <- purrr::map2_lgl(valid_tks, tid_vals,
                                   ~!.x %in% .y)


  if (any(is_invalid_tk)) {
    error_row <- data.frame(
      instancePath = paste0(glue::glue(get_error_path(schema, "target_keys", "instance")),
                            "/", names(is_invalid_tk)),
      schemaPath =  get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys values",
      message = glue::glue("target_key value '{valid_tks[names(is_invalid_tk[is_invalid_tk])]}' does not match any values in corresponding modeling task group task_id"),
      schema = "",
      data = glue::glue("task_id.{names(is_invalid_tk)} values: {purrr::map_chr(tid_vals, ~glue::glue_collapse(.x, sep = ', '))};
            target_key.{names(valid_tks)} value: {unlist(valid_tks)}")
    )

    return(error_row)
  } else {
    return(NULL)
  }
}




val_tk_tid_vals <- function(grp_tks, mt_grp, mt_i,
                            rnd_i, schema) {

  # Get unique values of target key names
  tk_nms <- purrr::map(grp_tks, ~names(.x)) %>%
    unique() %>% unlist()

  # Identify target_key_names that are valid task id properties
  val_tk_nms <- tk_nms[tk_nms %in% names(mt_grp[["task_ids"]])]


  # Get list of unique task id values across both required & optional arrays
  # for each valid target key.
  tid_vals <- mt_grp[["task_ids"]][val_tk_nms] %>%
    purrr::map(~unlist(.x, use.names = FALSE)) %>%
    unique() %>%
    purrr::set_names(val_tk_nms)

  # Get list of target key values for each valid target key.
  tk_vals <- purrr::map(
    purrr::set_names(val_tk_nms),
    ~get_all_grp_tk_vals(.x, grp_tks) %>%
      unique()
  )

  # Identify task id values that do not have a match in any of the corresponding
  # target key definitions.
  invalid_tid_vals <- purrr::map2(
    .x = tid_vals,
    .y = tk_vals,
    ~!.x %in% .y
  ) %>%
    purrr::map2(
      tid_vals,
      ~.y[.x]) %>%
    purrr::compact() %>%
    purrr::map_chr(~paste(.x, collapse = ", "))


  if(length(invalid_tid_vals) != 0){
    error_row <- data.frame(
      instancePath = paste0(glue::glue(get_error_path(schema, "task_ids", "instance")),"/", names(invalid_tid_vals)),
      schemaPath =  get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id values",
      message = glue::glue("task_id value(s) '{invalid_tid_vals}' not defined in any corresponding target_key."),
      schema = "",
      data = glue::glue("task_id.{names(invalid_tid_vals)} unique values: {purrr::map_chr(tk_vals[names(invalid_tid_vals)], ~glue::glue_collapse(.x, sep = ', '))};
            target_key.{names(invalid_tid_vals)} unique values: {purrr::map_chr(tk_vals[names(invalid_tid_vals)],
            ~paste(.x, collapse = ', '))}")
    )
    return(error_row)
  }

  return(NULL)
}


get_all_grp_tk_vals <- function(target, grp_tks) {
  purrr::map_chr(grp_tks,
                 ~.x[[target]])
}


get_grp_tks <- function(mt_grp) {
  purrr::map(mt_grp[["target_metadata"]],
             ~.x[["target_keys"]]
  )
}

get_grp_tids <- function(mt_grp) {
  names(mt_grp[["task_ids"]])
}

find_inval_tks <- function(target_keys, mt_grp) {

  !names(target_keys) %in% get_grp_tids(mt_grp) %>%
    stats::setNames(names(target_keys))
}


get_error_path <- function(schema, element = "target_metadata",
                           type = c("schema", "instance")) {

  type <- rlang::arg_match(type)

  schema_paths <- schema %>%
    jsonlite::fromJSON(simplifyDataFrame = FALSE) %>%
    unlist(recursive = TRUE, use.names = TRUE) %>%
    names() %>%
    gsub("\\.", "/", .) %>%
    paste0("/", .)

  path <- grep(paste0(".*", element, "/type([0-9])?$"), schema_paths, value = TRUE) %>%
    gsub("/type([0-9])?", "", .) %>%
    unique()

  switch (type,
          schema = paste0("#", path),
          instance = generate_instance_path_glue(path)
  )

}

generate_instance_path_glue <- function(path) {

  split_path <- gsub("properties/", "", path) %>%
    strsplit("/") %>%
    unlist()

  is_item <- split_path == "items"
  split_path[is_item]  <- c("{rnd_i - 1}", "{mt_i - 1}", "{tk_i - 1}")[1:sum(is_item)]
  paste(split_path, collapse = "/")
}



