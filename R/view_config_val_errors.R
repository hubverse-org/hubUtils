#' Print a concise and informative version of validation errors table.
#'
#' @param x output of [validate_config()].
#'
#' @return prints the errors attribute of x in an informative format to the viewer. Only
#' available in interactive mode.
#' @export
#' @seealso [validate_config()]
#' @family functions supporting config file validation
#' @examples
#' \dontrun{
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks") |>
#'   view_config_val_errors()
#' }
view_config_val_errors <- function(x) {
  if (all(unlist(x))) {
    cli::cli_alert_success(c(
      "Validation of {.path {attr(x, 'config_path')}}",
      "{.path {attr(x, 'config_dir')}} was successful.", "
                             No validation errors to display."
    ))
    return(invisible(NULL))
  }

  if (length(x) > 1L) {
    error_df <- purrr::map2(
      x, names(x),
      ~ compile_errors(.x, .y) %>%
        process_error_df()
    ) %>%
      purrr::list_rbind()
    val_path <- attr(x, "config_dir")
    val_type <- "directory"
    error_loc_columns <- c(
      "fileName",
      "instancePath",
      "schemaPath"
    )
  } else {
    error_df <- attr(x, "errors") %>%
      process_error_df()
    val_path <- attr(x, "config_path")
    val_type <- "file"
    error_loc_columns <- c(
      "instancePath",
      "schemaPath"
    )
  }

  schema_version <- attr(x, "schema_version")
  schema_url <- attr(x, "schema_url")

  title <- gt::md("**`hubUtils` config validation error report**")
  subtitle <- gt::md(
    glue::glue("Report for {val_type} **`{val_path}`** using
                   schema version [**{schema_version}**]({schema_url})")
  )



  # Create table ----
  gt::gt(error_df) %>%
    gt::tab_header(
      title = title,
      subtitle = subtitle
    ) %>%
    gt::tab_spanner(
      label = gt::md("**Error location**"),
      columns = error_loc_columns
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
  if (length(paths) > 1L) {
    for (i in 2:length(paths)) {
      paths[i] <- paste0(
        "\u2514",
        paste(rep("\u2500", times = i - 2),
          collapse = ""
        ),
        paths[i]
      )
    }
  }
  paste(paths, collapse = " \n ")
}



dataframe_to_markdown <- function(x) {
  split(x, seq_len(nrow(x))) %>%
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



remove_superfluous_enum_rows <- function(errors_tbl) {
  dup_inst <- duplicated(errors_tbl$instancePath)

  if (any(dup_inst)) {
    dup_idx <- errors_tbl$instancePath[dup_inst] %>%
      purrr::map(~ which(errors_tbl$instancePath == .x))

    dup_keywords <- purrr::map(dup_idx, ~ errors_tbl$keyword[.x])

    dup_unneccessary <- purrr::map_lgl(
      dup_keywords,
      ~ all(.x == c("type", "enum") | .x == c("type", "const"))
    )

    if (any(dup_unneccessary)) {
      remove_idx <- purrr::map_int(
        dup_idx[dup_unneccessary],
        ~ .x[2]
      )
      errors_tbl <- errors_tbl[-remove_idx, ]
    }
  }

  errors_tbl
}

compile_errors <- function(x, file_name) {
  errors_tbl <- attr(x, "errors")
  if (!is.null(errors_tbl)) {
    cbind(
      fileName = rep(fs::path(file_name, ext = "json"), nrow(errors_tbl)),
      errors_tbl
    )
  }
}


process_error_df <- function(errors_tbl) {
  if (is.null(errors_tbl)) {
    return(NULL)
  }
  errors_tbl[c("dataPath", "parentSchema", "params")] <- NULL
  errors_tbl <- errors_tbl[!grepl("oneOf.+", errors_tbl$schemaPath), ]
  errors_tbl <- remove_superfluous_enum_rows(errors_tbl)

  # Get rid of unnecessarily verbose data entry when a required property is
  # missing. Addressing this is dependent on the data column data type.
  if (any(errors_tbl$keyword == "required")) {
    if (inherits(errors_tbl$data, "data.frame")) {
      errors_tbl$data <- ""
    } else {
      errors_tbl$data[errors_tbl$keyword == "required"] <- ""
    }
  }
  # Get rid of unnecessarily verbose data entry when an additionalProperties property is
  # detected Addressing this is dependent on the data column data type.
  if (any(errors_tbl$keyword == "additionalProperties")) {
    if (inherits(errors_tbl$data, "data.frame")) {
      errors_tbl$data <- ""
    } else {
      errors_tbl$data[errors_tbl$keyword == "additionalProperties"] <- ""
    }
  }

  error_df <- split(errors_tbl, seq_len(nrow(errors_tbl))) %>%
    purrr::map(
      ~ unlist(.x, recursive = FALSE) %>%
        purrr::map(~ process_element(.x)) %>%
        tibble::as_tibble()
    ) %>%
    purrr::list_rbind() %>%
    # split long column names
    stats::setNames(gsub("\\.", " ", names(.)))


  # format path and error message columns
  error_df[["schemaPath"]] <- purrr::map_chr(error_df[["schemaPath"]], path_to_tree)
  error_df[["instancePath"]] <- purrr::map_chr(error_df[["instancePath"]], path_to_tree)
  error_df[["message"]] <- paste("\u274c", error_df[["message"]])

  error_df
}
