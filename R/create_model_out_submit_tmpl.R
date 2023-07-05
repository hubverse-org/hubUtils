#' Create a model output submission file template
#'
#' @param hub_con A `⁠<hub_connection`>⁠ class object.
#' @inheritParams expand_model_out_val_grid
#' @param include_opt_cols Logical. If `FALSE` (default) and `required_only = TRUE`,
#' task IDs or output_type IDs where all values are optional are excluded
#' from the output.
#' If `TRUE`, columns of `NA`s are included instead.
#' Ignored when `required_only = FALSE`.
#'
#' @return a tibble template containing an expanded grid of valid task ID and
#' output type ID value combinations for a given submission round (if applicable)
#' and output type.
#' If `required_only = TRUE`, values are limited to the combination of required
#' values only.
#'
#' @details
#' For task IDs or output_type_ids where all values are optional, by default, columns
#' are excluded from the output. To include them as columns of `NA`s, use
#' `include_opt_cols = FALSE`.
#'
#' If `round_id` is specified and the round is set to `round_id_from_variable: true`,
#' the value of the task ID from which round IDs are derived (i.e. the task ID
#' specified in `round_id` property of `config_tasks`) is set to the value of the
#' `round_id` argument in the returned output.
#' @export
#'
#' @examples
#' hub_con <- connect_hub(
#'   system.file("testhubs/flusight", package = "hubUtils")
#' )
#' create_model_out_submit_tmpl(hub_con)
#' create_model_out_submit_tmpl(hub_con, required_only = TRUE)
#' create_model_out_submit_tmpl(hub_con,
#'   required_only = TRUE,
#'   include_opt_cols = TRUE
#' )
#' # Specifying a round in a hub with multiple rounds
#' hub_con <- connect_hub(
#'   system.file("testhubs/simple", package = "hubUtils")
#' )
#' create_model_out_submit_tmpl(hub_con, round_id = "2022-10-01")
#' create_model_out_submit_tmpl(hub_con, round_id = "2022-10-29")
#' create_model_out_submit_tmpl(hub_con,
#'   round_id = "2022-10-29",
#'   required_only = TRUE
#' )
#' create_model_out_submit_tmpl(hub_con,
#'   round_id = "2022-10-29",
#'   required_only = TRUE,
#'   include_opt_cols = TRUE
#' )
create_model_out_submit_tmpl <- function(hub_con, config_tasks,
                                         round_id = NULL,
                                         required_only = FALSE,
                                         include_opt_cols = FALSE) {
  switch(rlang::check_exclusive(hub_con, config_tasks),
    hub_con = {
      checkmate::assert_class(hub_con, classes = "hub_connection")
      config_tasks <- attr(hub_con, "config_tasks")
    },
    config_tasks = checkmate::assert_list(config_tasks)
  )

  round_task_ids <- get_round_task_id_names(
    config_tasks,
    round_id
  )

  tmpl_df <- expand_model_out_val_grid(config_tasks,
    round_id = round_id,
    required_only = required_only
  )

  opt_task_ids <- round_task_ids[!round_task_ids %in% names(tmpl_df)]

  if (required_only && length(opt_task_ids) > 0L) {
    n_mt <- n_model_tasks(config_tasks, round_id)
    message_opt_tasks(opt_task_ids, n_mt, include_opt_cols)

    if (include_opt_cols) {
      conv_opt_task_ids <- create_hub_schema(
        config_tasks,
        partitions = NULL,
        r_schema = TRUE
      )[opt_task_ids]

      tmpl_df[, opt_task_ids] <- NA
      tmpl_df[, names(conv_opt_task_ids)] <- purrr::map2(
        .x = names(conv_opt_task_ids),
        .y = conv_opt_task_ids,
        ~ get(paste0("as.", .y))(tmpl_df[[.x]])
      )

      tmpl_df <- tmpl_df[, c(round_task_ids, "output_type", "output_type_id")]
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

message_opt_tasks <- function(opt_task_ids, n_mt, include_opt_cols) {
  if (include_opt_cols) {
    action <- "included as {.val NA} column{?s}."
  } else {
    action <- "not included in template."
  }
  msg <- c("!" = paste("Task ID{?s} {.val {opt_task_ids}} whose values are all
                 optional", action))
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
