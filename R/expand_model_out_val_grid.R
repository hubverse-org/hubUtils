#' Create expanded grid of valid task ID and output type value combinations
#'
#' @param config_tasks a list version of the content's of a hub's `tasks.json`
#' config file, accessed through the `"config_tasks"` attribute of a `<hub_connection>`
#' object or function [read_config()].
#' @param round_id Character string. Round identifier. If the round is set to
#' `round_id_from_variable: true`, IDs are values of the task ID defined in the round's
#' `round_id` property of `config_tasks`.
#' Otherwise should match round's `round_id` value in config. Ignored if hub
#' contains only a single round.
#' @param required_only Logical. Whether to return only combinations of
#' Task ID and related output type ID required values.
#'
#' @return a tibble containing all possible task ID and related output type ID
#' value combinations.
#' If `required_only = TRUE`, values are limited to the combinations of required
#' values only.
#' @details
#' If `round_id` is specified and the round is set to `round_id_from_variable: true`,
#' the value of the task ID from which round IDs are derived (i.e. the task ID
#' specified in `round_id` property of `config_tasks`) is set to the value of the
#' `round_id` argument in the returned output.
#'
#' @export
#'
#' @examples
#' hub_con <- connect_hub(
#'   system.file("testhubs/flusight", package = "hubUtils")
#' )
#' config_tasks <- attr(hub_con, "config_tasks")
#' expand_model_out_val_grid(config_tasks)
#' expand_model_out_val_grid(config_tasks, required_only = TRUE)
#' # Specifying a round in a hub with multiple rounds
#' hub_con <- connect_hub(
#'   system.file("testhubs/simple", package = "hubUtils")
#' )
#' config_tasks <- attr(hub_con, "config_tasks")
#' expand_model_out_val_grid(config_tasks, round_id = "2022-10-01")
#' expand_model_out_val_grid(config_tasks, round_id = "2022-10-29")
expand_model_out_val_grid <- function(config_tasks,
                                      round_id = NULL,
                                      required_only = FALSE) {
  round_idx <- get_round_idx(config_tasks, round_id)

  round_config <- purrr::pluck(
    config_tasks,
    "rounds",
    round_idx
  )

  task_id_l <- purrr::map(
    round_config[["model_tasks"]],
    ~ .x[["task_ids"]]
  ) %>%
    fix_round_id(
      round_id = round_id,
      round_config = round_config,
      round_ids = get_round_ids(config_tasks)
    ) %>%
    process_grid_inputs(required_only = required_only)

  output_type_l <- purrr::map(
    round_config[["model_tasks"]],
    ~ .x[["output_type"]]
  ) %>%
    purrr::map(~ .x %>% purrr::map(~ .x[["type_id"]])) %>%
    process_grid_inputs(required_only = required_only)

  output_type_grid_l <- purrr::map2(
    task_id_l, output_type_l,
    ~ expand_output_type_grid(
      task_id_values = .x,
      output_type_values = .y
    )
  )

  do.call(rbind, output_type_grid_l) %>%
    tibble::as_tibble()
}



process_grid_inputs <- function(x, required_only = FALSE) {
  if (required_only) {
    purrr::map(x, ~ .x %>% purrr::map(~ .x[["required"]]))
  } else {
    purrr::modify_depth(x, .depth = 2, ~ unlist(.x, use.names = FALSE))
  }
}

expand_output_type_grid <- function(task_id_values,
                                    output_type_values) {
  purrr::imap(
    output_type_values,
    ~ c(task_id_values, list(
      output_type = .y,
      output_type_id = .x
    )) %>%
      purrr::compact() %>%
      expand.grid(stringsAsFactors = FALSE)
  ) %>%
    purrr::list_rbind()
}

fix_round_id <- function(x, round_id, round_config, round_ids) {
  if (round_config[["round_id_from_variable"]] && !is.null(round_id)) {
    round_id <- rlang::arg_match(round_id,
      values = round_ids
    )
    round_id_var <- round_config[["round_id"]]
    purrr::map(
      x,
      ~ .x %>%
        purrr::imap(~ if (.y == round_id_var) {
          list(required = round_id, optional = NULL)
        } else {
          .x
        })
    )
  } else {
    x
  }
}
