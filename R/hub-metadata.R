get_task_id_params <- function(x,
                               param = c(
                                 "location",
                                 "horizon",
                                 "origin_date"
                               ),
                               flatten = FALSE) {
  param <- match.arg(param)
  values <- x$model_tasks[[1]]$task_ids[[param]]

  if (flatten) {
    out <- c(
      values$required,
      values$optional
    ) |>
      unlist() |>
      unname()
  } else {
    out <- list(
      required = purrr::pluck(
        values,
        "required"
      ) |>
        unlist(),
      optional = purrr::pluck(
        values,
        "optional"
      ) |>
        unlist()
    )
  }

  out <- structure(out,
    units = purrr::pluck(
      values,
      "units"
    ) |>
      unlist(),
    format = purrr::pluck(
      values,
      "format"
    ) |>
      unlist()
  )
  return(out)
}
