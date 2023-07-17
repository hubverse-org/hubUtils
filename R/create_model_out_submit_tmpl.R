#' Create a model output submission file template
#'
#' @param hub_con A `⁠<hub_connection`>⁠ class object.
#' @inheritParams expand_model_out_val_grid
#' @param remove_empty_cols Logical. If `FALSE` (default) and `required_vals_only = TRUE`,
#' task IDs or output_type IDs where all values are optional are included as
#' columns of `NA`s.
#' If `TRUE`, such columns are excluded from the output.
#' Ignored when `required_vals_only = FALSE`.
#'
#' @return a tibble template containing an expanded grid of valid task ID and
#' output type ID value combinations for a given submission round
#' and output type.
#' If `required_vals_only = TRUE`, values are limited to the combination of required
#' values only.
#'
#' @details
#' For task IDs or output_type_ids where all values are optional, by default, columns
#' are included as columns of `NA`s. To exclude them from the output use
#' `remove_empty_cols = TRUE`.
#'
#' When a round is set to `round_id_from_variable: true`,
#' the value of the task ID from which round IDs are derived (i.e. the task ID
#' specified in `round_id` property of `config_tasks`) is set to the value of the
#' `round_id` argument in the returned output.
#' @export
#'
#' @examples
#' hub_con <- connect_hub(
#'   system.file("testhubs/flusight", package = "hubUtils")
#' )
#' create_model_out_submit_tmpl(hub_con, round_id = "2023-01-02")
#' create_model_out_submit_tmpl(
#'   hub_con,
#'   round_id = "2023-01-02",
#'   required_vals_only = TRUE
#' )
#' create_model_out_submit_tmpl(
#'   hub_con,
#'   round_id = "2023-01-02",
#'   required_vals_only = TRUE,
#'   remove_empty_cols = TRUE
#' )
#' # Specifying a round in a hub with multiple rounds
#' hub_con <- connect_hub(
#'   system.file("testhubs/simple", package = "hubUtils")
#' )
#' create_model_out_submit_tmpl(hub_con, round_id = "2022-10-01")
#' create_model_out_submit_tmpl(hub_con, round_id = "2022-10-29")
#' create_model_out_submit_tmpl(hub_con,
#'   round_id = "2022-10-29",
#'   required_vals_only = TRUE
#' )
#' create_model_out_submit_tmpl(hub_con,
#'   round_id = "2022-10-29",
#'   required_vals_only = TRUE,
#'   remove_empty_cols = TRUE
#' )
create_model_out_submit_tmpl <- function(hub_con, config_tasks, round_id,
                                         required_vals_only = FALSE,
                                         remove_empty_cols = FALSE) {
  switch(rlang::check_exclusive(hub_con, config_tasks),
    hub_con = {
      checkmate::assert_class(hub_con, classes = "hub_connection")
      config_tasks <- attr(hub_con, "config_tasks")
    },
    config_tasks = checkmate::assert_list(config_tasks)
  )

  tmpl_df <- expand_model_out_val_grid(config_tasks,
    round_id = round_id,
    required_vals_only = required_vals_only
  )

  tmpl_cols <- c(
    get_round_task_id_names(
      config_tasks,
      round_id
    ),
    std_colnames[names(std_colnames) != "model_id"]
  )

  opt_cols <- tmpl_cols[!tmpl_cols %in% names(tmpl_df)]

  if (length(opt_cols) > 0L) {
    if (any(opt_cols != std_colnames["value"])) {
      n_mt <- n_model_tasks(config_tasks, round_id)
      message_opt_tasks(opt_cols, n_mt, remove_empty_cols)
    }

    if (remove_empty_cols) {
      return(tmpl_df)
    } else {
      tmpl_schema <- create_hub_schema(
        config_tasks,
        partitions = NULL,
        r_schema = TRUE
      )
      convert_opt_cols <- tmpl_schema[opt_cols]

      tmpl_df[, opt_cols] <- NA
      tmpl_df[, names(convert_opt_cols)] <- purrr::map2(
        .x = names(convert_opt_cols),
        .y = convert_opt_cols,
        ~ get(paste0("as.", .y))(tmpl_df[[.x]])
      )

      tmpl_df <- tmpl_df[, tmpl_cols]
    }
  }
  tmpl_df
}

get_round_model_tasks <- function(config_tasks, round_id) {
  round_idx <- get_round_idx(
    config_tasks,
    round_id
  )
  purrr::pluck(
    config_tasks,
    "rounds",
    round_idx,
    "model_tasks"
  )
}

n_model_tasks <- function(config_tasks, round_id) {
  length(get_round_model_tasks(config_tasks, round_id))
}


get_round_task_id_names <- function(config_tasks, round_id) {
  get_round_model_tasks(config_tasks, round_id) %>%
    purrr::map(~ .x[["task_ids"]] %>%
      names()) %>%
    unlist() %>%
    unique()
}

message_opt_tasks <- function(opt_cols, n_mt, remove_empty_cols) {
  if (remove_empty_cols) {
    action <- "and std column {.val {std_colnames['value']}} not included in template."
  } else {
    action <- "included as all {.code NA} column{?s}."
  }
  opt_cols <- opt_cols[opt_cols != "value"]

  msg <- c("!" = paste("{cli::qty(length(opt_cols))}Column{?s} {.val {opt_cols}}
                       whose values are all optional", action))
  if (n_mt > 1L) {
    msg <- c(
      msg,
      "!" = "Round contains more than one modeling task ({.val {n_mt}})"
    )
  }
  msg <- c(
    msg,
    "i" = "See Hub's {.path tasks.json} file or {.cls hub_connection} attribute
          {.val config_tasks} for details of optional
    task ID/output_type/output_type ID value combinations."
  )
  cli::cli_bullets(msg)
}
