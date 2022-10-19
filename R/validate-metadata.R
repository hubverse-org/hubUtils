
#' Validate round_ids against available hub round_ids
#'
#' @param con a `hub_connection` class object.
#' @param round_ids A character vector of round ids.
#' @param val_type whether to throw a warning or error in the case invalid
#'   round ids are supplied.
#'
#' @return A character vector of valid round_ids.
#'   If `val_type = "warning"`, invalid round_ids are removed and a warning raised.
#'   If `val_type = "error"` or if no valid round_ids were supplied, an error is thrown.
#' @noRd
validate_round_ids <- function(con, round_ids = NULL,
                              val_type = c("warning","error")) {

    val_type <- rlang::arg_match(val_type)

    if (attr(con, "task_ids_by_round")) {
        if (is.null(round_ids)) {
            cli::cli_abort(
                c(
                    "x" = "{.var round_id} cannot be {.val NULL}",
                    "!" = "{.var round_id} must be supplied for Hubs with task ids that
                vary by round",
                    "i" = "Accepted {.var round_id} values are
                {.val { attr(con, 'round_ids') }}"
                )
            )
        }

        valid_round_ids <- get_round_ids(con)
        invalid_round_ids_lgl <- !round_ids %in% valid_round_ids

        if (any(invalid_round_ids_lgl)) {

            invalid_round_ids <- round_ids[invalid_round_ids_lgl]

            check_msg <- c(
                "x" = "{.val {invalid_round_ids}} {?is/are} not {?a/} valid
            {.var round_id} value{?s}.")

            if (all(invalid_round_ids_lgl)) {
                check_msg <- c(
                    check_msg,
                    "x" = "No valid {.var round_id} {cli::qty(round_ids)}
                     value{?s} supplied."
                )
                val_type <- "error"
            }

            check_msg <- c(
                check_msg,
                "i" = "Accepted {.var round_id} values are
                {.val { attr(con, 'round_ids') }}")

            switch(val_type,
                   warning = cli::cli_warn(
                       c(check_msg,
                         "!" = "{cli::qty(invalid_round_ids)} round_id{?s}
                      {.val {invalid_round_ids}} ignored."
                       )
                   ),
                   error = cli::cli_abort(check_msg)
            )

            round_ids <- round_ids[!invalid_round_ids_lgl]
        }
    } else {
        round_ids <- "round_id_from_variable"
    }


    round_ids
}

#' Validate task_ids against available hub task_ids for a given round_id
#' (where applicaple)
#'
#' @inheritParams validate_round_ids
#' @param task_ids A character vector of task ids.
#' @param round_id A single round id.
#'
#' @return A character vector of valid task_ids.
#'   If `val_type = "warning"`, invalid task_ids are removed and a warning raised.
#'   If `val_type = "error"` or if no valid task_ids were supplied, an error is thrown.
#' @noRd
validate_task_ids <- function(con, task_ids, round_id = NULL,
                              val_type = c(
                                  "warning",
                                  "error"
                              )) {

    val_type <- rlang::arg_match(val_type)
    round_id <- validate_round_ids(con, round_id)


    valid_task_ids <- get_task_ids(con, round_id = round_id)
    invalid_task_ids_lgl <- !task_ids %in% valid_task_ids

    if (any(invalid_task_ids_lgl)) {

        invalid_task_ids <- task_ids[invalid_task_ids_lgl]

        round_msg <- if (attr(con, "task_ids_by_round")) {
            cli::cli_fmt({
                cli::cli_text(" for {.val {round_id}}")
            })
        } else {
            NULL
        }

        check_msg <- c(
            "x" = "{.val {invalid_task_ids}} {?is/are} not {?a/} valid
            {.var task_id}{round_msg}.")

        if (all(invalid_task_ids_lgl)) {
            check_msg <- c(
                check_msg,
                "x" = "No valid task ids supplied{round_msg}."
            )
        }

        check_msg <- c(
            check_msg,
            "i" = "Accepted {.var task_id} values are
                {.val { valid_task_ids }}.")

        switch(val_type,
               warning = cli::cli_warn(
                   c(check_msg,
                     "!" = "{cli::qty(invalid_task_ids)} task_id{?s}
                      {.val {invalid_task_ids}} ignored{round_msg}."
                   )
               ),
               error = cli::cli_abort(check_msg)
        )
    }

    task_ids[!invalid_task_ids_lgl]
}
