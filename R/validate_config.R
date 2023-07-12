#' Validate a hub config file against a Infectious Disease Modeling Hubs schema
#'
#' @param hub_path Path to a local hub directory.
#' @param config Name of config file to validate. One of `"tasks"` or `"admin"`.
#' @param config_path Defaults to `NULL` which assumes all config files are in
#'   the `hub-config` directory in the root of hub directory. Argument
#'   `config_path` can be used to override default by providing a path to the
#'    config file to be validated.
#' @param schema_version Character string specifying the json schema version to
#'   be used for validation. The default value `"from_config"` will use the
#'   version specified in the `schema_version` property of the config file.
#'   `"latest"` will use the latest version available in the Infectious Disease
#'   Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#'   Alternatively, a specific version of a schema (e.g. `"v0.0.1"`)  can be
#'  specified.
#' @param branch The branch of the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   from which to fetch schema. Defaults to `"main"`.
#' @return Returns the result of validation. If validation is successful, will
#'   return `TRUE`. If any validation errors are detected, returns `FALSE` with
#'   details of errors appended as a data.frame to an `errors` attribute.
#'   To access
#'   the errors table use `attr(x, "errors")` where `x` is the output of the function.
#'
#'   You can print a more concise and easier to view version of an errors table with
#'   [view_config_val_errors()].
#' @export
#' @seealso [view_config_val_errors()]
#' @family functions supporting config file validation
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
                            branch = "main") {
  if (!(requireNamespace("jsonvalidate"))) {
    cli::cli_abort("Package {.pkg jsonvalidate} must be installed to use {.fn validate_config}. Please install it to continue.

                   Alternatively, to be able to use all packages required for hub maintainer functionality, re-install {.pkg hubUtils} using argument {.code dependencies = TRUE}")
  }

  config <- rlang::arg_match(config)

  if (is.null(config_path)) {
    checkmate::assert_directory_exists(hub_path)
    config_path <- fs::path(hub_path, "hub-config", config, ext = "json")
  }

  # check config file to be checked exists and is correct extension
  checkmate::assert_file_exists(config_path, extension = "json")

  if (schema_version == "from_config") {
    schema_version <- get_config_schema_version(config_path, config)
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
    validation <- validate_schema_version_property(validation, config)
    if (config == "tasks") {
      validation <- perform_dynamic_config_validations(validation)
    }
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

#' Get a vector of valid schema version
#'
#' @inheritParams validate_config
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


get_config_schema_version <- function(config_path, config) {
  config_schema_version <- jsonlite::read_json(config_path)$schema_version

  if (is.null(config_schema_version)) {
    cli::cli_abort(c("x" = "Property {.code schema_version} not found in config file."))
  }

  check_config_schema_version(config_schema_version,
    config = config
  )

  version <- stringr::str_extract(
    config_schema_version,
    "v([0-9]\\.){2}[0-9](\\.[0-9]+)?"
  )

  if (length(version) == 0L) {
    cli::cli_abort(
      c(
        "x" = "Valid {.field version} could not be extracted from config
            file {.file {config_path}}",
        "!" = "Please check property {.val schema_version} is correctly formatted."
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

#' Perform dynamic validation of target keys and schema_ids for internal consistency against
#'  task ids. Check only performed once basic jsonvalidate checks pass against
#'  schema.
#'
#' @param validation validation object returned by jsonvalidate::json_validate().
#'
#' @return If validation successful, returns original validation object. If
#'  validation fails, value of validation object is set to FALSE and the error
#'  table is appended to attribute "errors".
#' @noRd
perform_dynamic_config_validations <- function(validation) {
  config_json <- jsonlite::read_json(attr(validation, "config_path"),
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
  schema <- get_schema(attr(validation, "schema_url"))


  errors_tbl <- c(
    # Map over Round level validations
    purrr::imap(
      config_json[["rounds"]],
      ~ val_round(
        round = .x, round_i = .y,
        schema = schema
      )
    ),
    # Perform config level validation
    list(validate_round_ids_unique(config_json, schema))
  ) %>%
    purrr::list_rbind()


  if (nrow(errors_tbl) > 1) {
    # assign FALSE without loosing attributes
    validation[] <- FALSE
    attr(validation, "errors") <- rbind(
      attr(validation, "errors"),
      errors_tbl
    )
  }

  return(validation)
}

## Dynamic schema validation utilities ----
val_round <- function(round, round_i, schema) {
  model_task_grps <- round[["model_tasks"]]

  c(
    purrr::imap(
      model_task_grps,
      ~ val_model_task_grp_target_metadata(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ val_task_id_names(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ validate_mt_property_unique_vals(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, property = "task_ids",
        schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ validate_mt_property_unique_vals(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, property = "output_type",
        schema = schema
      )
    ),
    list(
      validate_round_ids_consistent(
        round = round,
        round_i = round_i,
        schema = schema
      )
    )
  ) %>%
    purrr::list_rbind()
}

# Validate that no task id names match reserved hub variable names
val_task_id_names <- function(model_task_grp, model_task_i, round_i, schema) {
  reserved_hub_vars <- c(
    "model_id", "output_type",
    "output_type_id", "value"
  )
  task_id_names <- names(model_task_grp$task_ids)
  check_task_id_names <- task_id_names %in% reserved_hub_vars

  if (any(check_task_id_names)) {
    invalid_task_id_values <- task_id_names[check_task_id_names]

    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(
          get_error_path(schema, "task_ids", "instance")
        ), "/",
        names(invalid_task_id_values)
      ),
      schemaPath = get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id names",
      message = glue::glue(
        "task_id name(s) '{invalid_task_id_values}'",
        " must not match reserved hub variable names."
      ),
      schema = "",
      data = glue::glue(
        'task_id names: {glue::glue_collapse(task_id_names, ", ", last = " & ")};
        reserved hub variable names:',
        ' {glue::glue_collapse(reserved_hub_vars, ", ", last = " & ")}'
      )
    )
    return(error_row)
  }

  return(NULL)
}

val_model_task_grp_target_metadata <- function(model_task_grp, model_task_i,
                                               round_i, schema) {
  grp_target_keys <- get_grp_target_keys(model_task_grp)

  # If all target keys are NULL, exit checks
  if (all(purrr::map_lgl(grp_target_keys, ~ is.null(.x)))) {
    return(NULL)
  }

  # Check that target key names across items in target metadata array are consistent.
  # If not returns error early as further checks may fail unexpectedly.
  errors_check_1 <- val_target_key_names_const(
    grp_target_keys, model_task_grp,
    model_task_i, round_i, schema
  )

  if (!is.null(errors_check_1)) {
    return(errors_check_1)
  }

  # Check whether target key names do not correspond to task_id properties
  invalid_target_key_names <- purrr::map(
    grp_target_keys,
    ~ find_invalid_target_keys(.x, model_task_grp)
  ) %>%
    unlist(use.names = FALSE)

  # If any do not correspond, run validation function to generate errors rows.
  # Otherwise assign NULL to errors_check_2
  if (any(invalid_target_key_names)) {
    errors_check_2 <- purrr::imap(
      grp_target_keys,
      ~ val_target_key_names(.x,
        target_key_i = .y,
        model_task_grp = model_task_grp,
        model_task_i = model_task_i,
        round_i = round_i,
        schema = schema
      )
    ) %>%
      purrr::list_rbind()
  } else {
    errors_check_2 <- NULL
  }
  # If none of the target key names match task id properties, return errors_check_2
  # early as further checks become redundant.
  if (all(invalid_target_key_names)) {
    return(errors_check_2)
  }

  # Check that the values of each target keys have matching values in the corresponding
  # task_id required & optional property arrays.
  errors_check_3 <- purrr::imap(
    grp_target_keys,
    ~ val_target_key_values(.x, model_task_grp,
      target_key_i = .y,
      model_task_i = model_task_i,
      round_i = round_i,
      schema = schema
    )
  ) %>%
    purrr::list_rbind()

  # Check that the unique values in the required & optional property arrays
  #  of each task_id identified as a target key have a matching
  #  value in the corresponding target key of at least one target metadata item.
  errors_check_4 <- val_target_key_task_id_values(grp_target_keys, model_task_grp,
    model_task_i = model_task_i,
    round_i = round_i,
    schema = schema
  )
  # Combine all error checks
  rbind(
    errors_check_2,
    errors_check_3,
    errors_check_4
  )
}

val_target_key_names_const <- function(grp_target_keys, model_task_grp,
                                       model_task_i, round_i, schema) {
  target_key_names <- purrr::map(grp_target_keys, ~ names(.x)) %>%
    purrr::map_if(~ !is.null(.x), ~.x, .else = ~"null")

  if (length(unique(target_key_names)) > 1) {
    error_row <- data.frame(
      instancePath = glue::glue(get_error_path(schema, "target_keys", "instance")),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key names not consistent across target_metadata array items"),
      schema = "",
      data = glue::glue("target_key_{seq_along(target_key_names)}: {purrr::map_chr(target_key_names,
        ~paste(.x, collapse = ','))}") %>%
        glue::glue_collapse(sep = ";  ")
    )
    return(error_row)
  }
  return(NULL)
}

val_target_key_names <- function(target_keys, model_task_grp,
                                 target_key_i, model_task_i,
                                 round_i, schema) {
  check <- find_invalid_target_keys(target_keys, model_task_grp)

  if (any(check)) {
    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(get_error_path(schema, "target_keys", "instance")),
        "/", names(check[check])
      ),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key(s) '{names(check[check])}' not properties of modeling task group task IDs"),
      schema = "",
      data = glue::glue("task_id names: {glue::glue_collapse(get_grp_task_ids(model_task_grp), sep = ', ')};
            target_key names: {glue::glue_collapse(names(target_keys), sep = ', ')}")
    )

    return(error_row)
  } else {
    return(NULL)
  }
}

val_target_key_values <- function(target_keys, model_task_grp,
                                  target_key_i, model_task_i,
                                  round_i, schema) {
  check <- !find_invalid_target_keys(target_keys, model_task_grp)

  valid_target_keys <- target_keys[check]

  task_id_values <- purrr::map(
    names(valid_target_keys),
    ~ model_task_grp[["task_ids"]][[.x]] %>%
      unlist(recursive = TRUE, use.names = FALSE)
  ) %>%
    purrr::set_names(names(valid_target_keys))


  is_invalid_target_key <- purrr::map2_lgl(
    valid_target_keys, task_id_values,
    ~ !.x %in% .y
  )


  if (any(is_invalid_target_key)) {
    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(get_error_path(schema, "target_keys", "instance")),
        "/", names(is_invalid_target_key)
      ),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys values",
      message = glue::glue("target_key value '{valid_target_keys[names(is_invalid_target_key[is_invalid_target_key])]}' does not match any values in corresponding modeling task group task_id"),
      schema = "",
      data = glue::glue("task_id.{names(is_invalid_target_key)} values: {purrr::map_chr(task_id_values, ~glue::glue_collapse(.x, sep = ', '))};
            target_key.{names(valid_target_keys)} value: {unlist(valid_target_keys)}")
    )

    return(error_row)
  } else {
    return(NULL)
  }
}

val_target_key_task_id_values <- function(grp_target_keys,
                                          model_task_grp,
                                          model_task_i,
                                          round_i, schema) {

  # Get unique values of target key names
  target_key_names <- purrr::map(grp_target_keys, ~ names(.x)) %>%
    unique() %>%
    unlist()

  # Identify target_key_names that are valid task id properties
  val_target_key_names <- target_key_names[
    target_key_names %in% names(model_task_grp[["task_ids"]])
  ]


  # Get list of unique task id values across both required & optional arrays
  # for each valid target key.
  task_id_values <- model_task_grp[["task_ids"]][val_target_key_names] %>%
    purrr::map(~ unlist(.x, use.names = FALSE)) %>%
    unique() %>%
    purrr::set_names(val_target_key_names)

  # Get list of target key values for each valid target key.
  target_key_values <- purrr::map(
    purrr::set_names(val_target_key_names),
    ~ get_all_grp_target_key_values(.x, grp_target_keys) %>%
      unique()
  )

  # Identify task id values that do not have a match in any of the corresponding
  # target key definitions.
  invalid_task_id_values <- purrr::map2(
    .x = task_id_values,
    .y = target_key_values,
    ~ !.x %in% .y
  ) %>%
    purrr::map2(
      task_id_values,
      ~ .y[.x]
    ) %>%
    purrr::compact() %>%
    purrr::map_chr(~ paste(.x, collapse = ", "))


  if (length(invalid_task_id_values) != 0) {
    error_row <- data.frame(
      instancePath = paste0(glue::glue(get_error_path(schema, "task_ids", "instance")), "/", names(invalid_task_id_values)),
      schemaPath = get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id values",
      message = glue::glue("task_id value(s) '{invalid_task_id_values}' not defined in any corresponding target_key."),
      schema = "",
      data = glue::glue("task_id.{names(invalid_task_id_values)} unique values: {purrr::map_chr(target_key_values[names(invalid_task_id_values)], ~glue::glue_collapse(.x, sep = ', '))};
            target_key.{names(invalid_task_id_values)} unique values: {purrr::map_chr(target_key_values[names(invalid_task_id_values)],
            ~paste(.x, collapse = ', '))}")
    )
    return(error_row)
  }

  return(NULL)
}


get_all_grp_target_key_values <- function(target, grp_target_keys) {
  purrr::map_chr(
    grp_target_keys,
    ~ .x[[target]]
  )
}


get_grp_target_keys <- function(model_task_grp) {
  purrr::map(
    model_task_grp[["target_metadata"]],
    ~ .x[["target_keys"]]
  )
}

get_grp_task_ids <- function(model_task_grp) {
  names(model_task_grp[["task_ids"]])
}

find_invalid_target_keys <- function(target_keys, model_task_grp) {
  !names(target_keys) %in% get_grp_task_ids(model_task_grp) %>%
    stats::setNames(names(target_keys))
}




check_config_schema_version <- function(schema_version, config = c("tasks", "admin")) {
  config <- rlang::arg_match(config)

  check_filename <- grepl(
    glue::glue("/{config}-schema.json$"),
    schema_version
  )
  if (!check_filename) {
    cli::cli_abort(c(
      "x" = "{.code schema_version} property {.url {schema_version}}
                     does not point to appropriate schema file.",
      "i" = "{.code schema_version} basename should be
                     {.file {config}-schema.json} but is {.file {basename(schema_version)}}"
    ))
  }

  check_prefix <- grepl("https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/",
    schema_version,
    fixed = TRUE
  )

  if (!check_prefix) {
    cli::cli_abort(c(
      "x" = "Invalid {.code schema_version} property.",
      "i" = "Valid {.code schema_version} properties should start with
                         {.val https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/}
                         and resolve to the schema file's raw contents on GitHub."
    ))
  }
}


validate_schema_version_property <- function(validation, config = c("tasks", "admin")) {
  config <- rlang::arg_match(config)
  schema_version <- jsonlite::read_json(attr(validation, "config_path"),
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )$schema_version
  schema <- get_schema(attr(validation, "schema_url"))


  errors_tbl <- NULL
  check_filename <- grepl(
    glue::glue("/{config}-schema.json$"),
    schema_version
  )
  if (!check_filename) {
    errors_tbl <- rbind(
      errors_tbl,
      data.frame(
        instancePath = get_error_path(schema, "schema_version", "instance"),
        schemaPath = get_error_path(schema, "schema_version", "schema"),
        keyword = "schema_version file name",
        message = glue::glue(
          "'schema_version' property does not point to corresponding schema file for config '{config}'. ",
          "Should be '{config}-schema.json' but is '{basename(schema_version)}'"
        ),
        schema = "",
        data = schema_version
      )
    )
  }

  check_prefix <- grepl("https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/",
    schema_version,
    fixed = TRUE
  )

  if (!check_prefix) {
    errors_tbl <- rbind(
      errors_tbl,
      data.frame(
        instancePath = get_error_path(schema, "schema_version", "instance"),
        schemaPath = get_error_path(schema, "schema_version", "schema"),
        keyword = "schema_version prefix",
        message = paste(
          "Invalid 'schema_version' property. Should start with",
          "'https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/'"
        ),
        schema = "",
        data = schema_version
      )
    )
  }

  if (!is.null(errors_tbl)) {
    # assign FALSE without loosing attributes
    validation[] <- FALSE
    attr(validation, "errors") <- rbind(
      attr(validation, "errors"),
      errors_tbl
    )
  }

  return(validation)
}

validate_mt_property_unique_vals <- function(model_task_grp,
                                             model_task_i,
                                             round_i,
                                             property = c(
                                               "task_ids",
                                               "output_type"
                                             ),
                                             schema) {
  property <- rlang::arg_match(property)
  property_text <- c(
    task_ids = "Task ID",
    output_type = "Output type IDs of output type"
  )[property]


  val_properties <- switch(property,
    task_ids = model_task_grp[["task_ids"]],
    output_type = model_task_grp[["output_type"]][
      c("quantile", "cdf", "pmf", "sample")
    ] %>%
      purrr::compact() %>%
      purrr::map(~ .x[["type_id"]])
  )

  dup_properties <- purrr::map(
    val_properties,
    ~ {
      x <- unlist(.x, use.names = FALSE)
      dups <- x[duplicated(x)]
      if (length(dups) == 0L) {
        NULL
      } else {
        dups
      }
    }
  ) %>%
    purrr::compact()

  if (length(dup_properties) == 0L) {
    return(NULL)
  } else {
    purrr::imap(
      dup_properties,
      ~ data.frame(
        instancePath = glue::glue(get_error_path(schema, property, "instance"), "/{.y}"),
        schemaPath = get_error_path(schema, property, "schema"),
        keyword = glue::glue("{property} uniqueItems"),
        message = glue::glue("must NOT have duplicate items across 'required' and 'optional' properties. {property_text} '{.y}' contains duplicates."),
        schema = "",
        data = glue::glue("duplicate values: {paste(.x, collapse = ', ')}")
      )
    ) %>% purrr::list_rbind()
  }
}

validate_round_ids_consistent <- function(round, round_i,
                                          schema) {
  n_mt <- length(round[["model_tasks"]])

  if (!round[["round_id_from_variable"]] || n_mt == 1L) {
    return(NULL)
  }

  round_id_var <- round[["round_id"]]

  mt <- purrr::map(
    round[["model_tasks"]],
    ~ purrr::pluck(.x, "task_ids", round_id_var)
  )

  checks <- purrr::map(
    .x = purrr::set_names(seq_along(mt)[-1]),
    ~ {
      check <- all.equal(mt[[1]], mt[[.x]])
      if (is.logical(check) && check) NULL else check
    }
  ) %>% purrr::compact()

  if (length(checks) == 0L) {
    return(NULL)
  }
  purrr::imap(
    checks,
    ~ tibble::tibble(
      instancePath = glue::glue_data(
        list(model_task_i = as.integer(.y)),
        get_error_path(schema, "task_ids", "instance"),
        "/{round_id_var}"
      ),
      schemaPath = get_error_path(schema, round_id_var, "schema"),
      keyword = "round_id var",
      message = glue::glue(
        "round_id var '{round_id_var}' property MUST be",
        " consistent across modeling task items"
      ),
      schema = "",
      data = glue::glue("{.x} compared to model task 1")
    )
  ) %>%
    purrr::list_rbind() %>%
    as.data.frame()
}

# Validate that round IDs are unique across all rounds in config file
validate_round_ids_unique <- function(config_tasks, schema) {
  round_ids <- get_round_ids(config_tasks)

  if (!any(duplicated(round_ids))) {
    return(NULL)
  }

  dup_round_ids <- unique(round_ids[duplicated(round_ids)])

  purrr::map(
    purrr::set_names(dup_round_ids),
    ~ dup_round_id_error_df(
      .x,
      config_tasks = config_tasks,
      schema = schema
    )
  ) %>% purrr::list_rbind()
}

dup_round_id_error_df <- function(dup_round_id,
                                  config_tasks,
                                  schema) {
  dup_round_idx <- purrr::imap(
    get_round_ids(config_tasks, flatten = "model_task"),
    ~ {
      if (dup_round_id %in% .x) .y else NULL
    }
  ) %>%
    purrr::compact() %>%
    unlist() %>%
    `[`(-1L)

  dup_mt_idx <- purrr::map(
    dup_round_idx,
    ~ get_round_ids(config_tasks, flatten = "task_id")[[.x]] %>%
      purrr::imap_int(~{if (dup_round_id %in% .x) .y else NULL}) %>%
      purrr::compact()
  )

  purrr::map2(
    .x = dup_round_idx,
    .y = dup_mt_idx,
    ~ tibble::tibble(
      instancePath = glue::glue_data(
        list(
          round_i = .x,
          model_task_i = .y
        ),
        get_error_path(schema, get_round_id_var(.x, config_tasks), "instance",
                       append_item_n = TRUE)
      ),
      schemaPath = get_error_path(schema, get_round_id_var(.x, config_tasks),
        "schema"),
      keyword = "round_id uniqueItems",
      message = glue::glue(
        "must NOT contains duplicate round ID values across rounds"
      ),
      schema = "",
      data = glue::glue("duplicate value: {dup_round_id}")
    )
  ) %>%
    purrr::list_rbind() %>%
    as.data.frame()
}

get_round_id_var <- function(idx, config_tasks) {
  if (config_tasks[["rounds"]][[idx]][["round_id_from_variable"]]) {
    config_tasks[["rounds"]][[idx]][["round_id"]]
  } else {
    "rounds"
  }
}
