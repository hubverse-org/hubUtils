#' Check that an argument is supplied and has the expected type
#'
#' @param x The argument to check.
#' @param is_valid A predicate function. `x` passes the check when
#' `is_valid(x)` is `TRUE`.
#' @param what Description of the expected type, used in the error message
#' as "`arg` must be `what`, not ...".
#' @param arg Name of the argument, used in the error message.
#' @param call The execution environment of the function to name in the error
#' message.
#' @return `x`, invisibly.
#' @noRd
check_arg_type <- function(
  x,
  is_valid,
  what,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  rlang::check_required(x, arg = arg, call = call)
  if (!is_valid(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be {what}, not {.obj_type_friendly {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' Check that a tasks config argument is supplied and is a list
#'
#' Note that a data frame is a list but is never a tasks config, so it is
#' rejected.
#'
#' @inheritParams check_arg_type
#' @noRd
check_config_tasks <- function(config_tasks, call = rlang::caller_env()) {
  check_arg_type(
    config_tasks,
    function(x) is.list(x) && !is.data.frame(x),
    "a list",
    call = call
  )
}
