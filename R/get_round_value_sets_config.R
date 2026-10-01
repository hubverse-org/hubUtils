#' Get the values each modeling task in a round allows
#'
#' Reads a round of a `tasks.json` config into one list per modeling task. Each
#' list holds the values that modeling task allows in each task ID column and,
#' for each output type, in the `output_type_id` column:
#'
#' ```
#' [[1]]
#'   $task_ids
#'     $target   "wk flu hosp rate category"
#'     $horizon  0 1 2 3
#'     $location "US" "01" "02" ...
#'   $output_type_ids
#'     $pmf      "low" "moderate" "high" ...
#' ```
#'
#' @inheritParams get_round_idx
#' @param required_vals_only Logical. Whether to return only required values.
#' @param force_output_types Logical. Whether to treat all output types as
#' required, regardless of their `is_required` setting. Only affects the
#' result when `required_vals_only = TRUE`.
#' @param output_types Character vector of output type names to include. If
#' `NULL`, all output types in the round are included.
#' @param derived_task_ids Character vector of derived task ID names (task IDs
#' whose values depend on other task IDs). Their values are returned as `NA`.
#' @param call The execution environment of the function to name in errors
#' and warnings about invalid `output_types` or `derived_task_ids`. Defaults
#' to the environment of `get_round_value_sets_config()`.
#'
#' @details
#' The values are read from the config as follows:
#'
#' - `required` and `optional` values are combined into one vector, `required`
#'   values first. With `required_vals_only = TRUE`, only `required` values are
#'   kept.
#' - A task ID a modeling task does not use is either listed as `null` or left
#'   out of that modeling task. Both are returned as `NA`, the value model
#'   output holds in that column. So are task IDs that have no `required`
#'   values when `required_vals_only = TRUE`, and derived task IDs.
#' - In a round with `round_id_from_variable: true`, the task ID holding round
#'   IDs is set to `round_id`.
#' - Output type IDs are read the same way for every schema version. From
#'   schema v4.0.0 onwards, an output type's `is_required` setting determines
#'   whether its output type IDs are required. Output types with no output type
#'   ID values are returned as `NA`. For `mean` and `median`, `NA` is the only
#'   valid value. For `sample`, `NA` stands in for sample IDs, which the config
#'   does not list.
#'
#' Values keep the type they have in the config.
#'
#' @return A list with one element per modeling task in the round. Each element
#' is a list of two:
#' - `task_ids`: a named list with a vector of allowed values for each task ID
#'   in the round.
#' - `output_type_ids`: a named list with a vector of allowed output type ID
#'   values for each output type in the modeling task. An output type with no
#'   `required` values is left out when `required_vals_only = TRUE`.
#' @export
#' @importFrom rlang %||%
#'
#' @examples
#' hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
#' config_tasks <- read_config(hub_path)
#' get_round_value_sets_config(config_tasks, round_id = "2022-10-22")
#' # Set derived task IDs to NA
#' get_round_value_sets_config(
#'   config_tasks,
#'   round_id = "2022-10-22",
#'   derived_task_ids = "target_end_date"
#' )
#' # Required values of a single output type only
#' get_round_value_sets_config(
#'   config_tasks,
#'   round_id = "2022-10-22",
#'   required_vals_only = TRUE,
#'   output_types = "pmf"
#' )
get_round_value_sets_config <- function(
  config_tasks,
  round_id,
  required_vals_only = FALSE,
  force_output_types = FALSE,
  output_types = NULL,
  derived_task_ids = NULL,
  call = rlang::current_env()
) {
  checkmate::assert_flag(required_vals_only)
  checkmate::assert_flag(force_output_types)
  checkmate::assert_character(output_types, null.ok = TRUE)
  checkmate::assert_character(derived_task_ids, null.ok = TRUE)
  round_config <- get_round_config(config_tasks, round_id)
  model_tasks <- round_config[["model_tasks"]]
  round_task_ids <- mt_task_id_names(model_tasks)
  output_types <- validate_output_types(
    output_types,
    mt_output_type_names(model_tasks),
    call = call
  )
  derived_task_ids <- validate_derived_task_ids(
    derived_task_ids,
    model_tasks,
    round_task_ids,
    call = call
  )
  round_id_var <- if (isTRUE(round_config[["round_id_from_variable"]])) {
    round_config[["round_id"]]
  }
  config_tid <- get_config_tid(config_tasks = config_tasks)

  purrr::map(
    model_tasks,
    \(model_task) {
      task_ids <- model_task[["task_ids"]]
      task_ids[derived_task_ids] <- NULL
      task_ids <- purrr::map(
        task_ids,
        \(x) {
          if (required_vals_only) {
            x[["required"]]
          } else {
            c(x[["required"]], x[["optional"]])
          }
        }
      )
      # When round IDs come from a task ID, the config lists every round ID
      # that task ID can take. Model output for this round holds only
      # `round_id` there, so `round_id` replaces the config values as the
      # only allowed value.
      if (
        !is.null(round_id_var) &&
          round_id_var %in% names(model_task[["task_ids"]])
      ) {
        task_ids[[round_id_var]] <- round_id
      }
      list(
        task_ids = purrr::map(
          purrr::set_names(round_task_ids),
          \(task_id) task_ids[[task_id]] %||% NA
        ),
        output_type_ids = subset_mt_output_types(model_task, output_types) |>
          get_mt_output_type_ids(
            config_tid,
            required_vals_only,
            force_output_types
          )
      )
    }
  )
}

# Return the output types of a modeling task named in `output_types`, or all
# of them if `output_types` is `NULL`.
subset_mt_output_types <- function(model_task, output_types) {
  out <- model_task[["output_type"]]
  if (is.null(output_types)) {
    return(out)
  }
  out[intersect(output_types, names(out))]
}

# Check that `output_types` are output types of the round.
validate_output_types <- function(
  output_types,
  round_output_types,
  call = rlang::caller_env()
) {
  if (is.null(output_types)) {
    return(NULL)
  }
  invalid_output_types <- setdiff(output_types, round_output_types)
  if (length(invalid_output_types) > 0L) {
    cli::cli_abort(
      c(
        "x" = "{.val {invalid_output_types}} {?is/are} not valid output
        type{?s}.",
        "i" = "{.arg output_types} must be members of:
        {.val {round_output_types}}"
      ),
      call = call
    )
  }
  output_types
}

# Check `derived_task_ids` against the round's task IDs. Task IDs not in the
# round are dropped with a warning. A derived task ID with required values is
# an error, because a required value cannot be `NA`.
validate_derived_task_ids <- function(
  derived_task_ids,
  model_tasks,
  round_task_ids,
  call = rlang::caller_env()
) {
  if (is.null(derived_task_ids)) {
    return(NULL)
  }
  valid_task_ids <- intersect(derived_task_ids, round_task_ids)
  if (length(valid_task_ids) < length(derived_task_ids)) {
    cli::cli_warn(
      c(
        "x" = "{.val {setdiff(derived_task_ids, round_task_ids)}}
        {?is/are} not valid task ID{?s}. Ignored.",
        "i" = "{.arg derived_task_ids} must be a member of:
        {.val {round_task_ids}}"
      ),
      call = call
    )
  }
  if (length(valid_task_ids) == 0L) {
    return(NULL)
  }
  has_required <- purrr::map(
    model_tasks,
    \(model_task) {
      purrr::map_lgl(
        purrr::set_names(valid_task_ids),
        \(task_id) !is.null(model_task[["task_ids"]][[task_id]][["required"]])
      )
    }
  ) |>
    purrr::reduce(`|`)
  if (any(has_required)) {
    cli::cli_abort(
      c(
        "x" = "Derived task IDs cannot have required task ID values.",
        "!" = "{.val {names(has_required)[has_required]}} ha{?s/ve}
          required task ID values."
      ),
      call = call
    )
  }
  valid_task_ids
}
