#' Create a Hub arrow schema
#'
#' Create an arrow schema from a the `tasks.json` config file for using when
#' opening an arrow dataset.
#' @param config_tasks a list version of the content's of a hub's `tasks.json`
#' config file created using function [read_config()].
#' @param format the hub file format.
#' @param partitions a named list specifying the arrow data types of any
#' partitioning column. Only relevant for opening `"parquet"` or `"arrow"` format datasets.
#' Ignored for all other formats.
#'
#' @return an arrow schema object that can be used to define column datatypes when
#' opening model output data. If the schema is being created for a `parquet`/`arrow` hub,
#' the partitioning variable data type is included in the schema while for `csv` hubs
#' the partitioning variable is not as it causes errors when opening.
#' @export
#'
#' @examples
#' origin_path <- system.file("testhubs/simple", package = "hubUtils")
#' config_tasks <- hubUtils:::read_config(origin_path, "tasks")
#' schema_csv <- create_hub_schema(config_tasks, format = "csv")
#' con_csv <- arrow::open_dataset(
#'     origin_path, format = "csv",
#'     partitioning = "team",
#'     col_types = schema_csv,
#'     factory_options = list(exclude_invalid_files = TRUE))
#' con_csv
#'
#' schema_parquet <- create_hub_schema(config_tasks, format = "parquet")
#' con_parquet <- arrow::open_dataset(
#'     origin_path, format = "parquet",
#'     partitioning = "team",
#'     schema = schema_parquet,
#'     factory_options = list(exclude_invalid_files = TRUE))
#' con_parquet
#'
#' hub_con <- arrow::open_dataset(
#'     sources = list(
#'         con_csv,
#'         con_parquet)
#' )
#' hub_con
create_hub_schema <- function(config_tasks,
                         format = c("csv", "parquet", "arrow"),
                         partitions = list(team = arrow::utf8())) {

    format <- rlang::arg_match(format)
    if (format != "parquet") {
        partitions <- NULL
    }

    task_id_names <- get_task_id_names(config_tasks)

    task_id_types <- purrr::map_chr(
        task_id_names,
        ~get_task_id_type(config_tasks,
                          .x))

    arrow_datatypes <- list(
        character = arrow::utf8(),
        double = arrow::float64(),
        integer = arrow::int32(),
        logical = arrow::boolean(),
        Date = arrow::date32()
    )

    task_id_arrow_types <- arrow_datatypes[task_id_types] %>%
        stats::setNames(task_id_names)

    c(task_id_arrow_types,
      type = arrow::utf8(),
      type_id = arrow_datatypes[[get_type_id_type(config_tasks)]],
      value = arrow_datatypes[[get_value_type(config_tasks)]],
      partitions
    ) %>%
        arrow::schema()

}

get_task_id_names <- function(variables) {
    purrr::map(
        config_tasks[["rounds"]],
        ~.x[["model_tasks"]]) %>%
        purrr::map(~.x[[1]][["task_ids"]] %>%
                       names()) %>%
        unlist() %>%
        unique()
}

get_task_id_values <- function(config_tasks,
                               task_id_name,
                               round = "all") {
    if (round == "all") {
        model_tasks <- purrr::map(config_tasks[["rounds"]],
                                  ~.x[["model_tasks"]])
    } else {
        round_idx <- which(
            purrr::map_chr(config_tasks[["rounds"]],
                           ~.x$round_id) == round)
        model_tasks <- purrr::map(
            config_tasks[["rounds"]][round_idx],
            ~.x[["model_tasks"]])
    }


    purrr::map(config_tasks[["rounds"]],
               ~.x[["model_tasks"]]) %>%
        purrr::map(~.x[[1]][["task_ids"]][[task_id_name]])
}

get_task_id_type <- function(config_tasks,
                             task_id_name,
                             round = "all") {
    values <- get_task_id_values(
        config_tasks,
        task_id_name,
        round) %>%
        unlist()

    get_data_type(values)
}


get_type_id_type <- function(config_tasks) {
    values <- purrr::map(config_tasks[["rounds"]],
                         ~.x[["model_tasks"]]) %>%
        purrr::map(~.x[[1]][["output_type"]]) %>%
        unlist(recursive = FALSE) %>%
        purrr::map(~purrr::pluck(.x, "type_id")) %>%
        unlist()

    get_data_type(values)
}


get_value_type <- function(config_tasks) {
    types <- purrr::map(config_tasks[["rounds"]],
                        ~.x[["model_tasks"]]) %>%
        purrr::map(~.x[[1]][["output_type"]]) %>%
        purrr::flatten() %>%
        purrr::map(~purrr::pluck(.x, "value", "type")) %>%
        unlist() %>%
        unique()

    coerce_datatype(json_datatypes[types])

}

get_data_type <- function(x) {
    type <- typeof(x)

    if (type == "character" && test_iso_date(x)) {
        type <- "Date"
    }
    return(type)
}

coerce_datatype <- function(types) {

    if ("character" %in% types) {
        return("character")
    }
    if ("double" %in% types) {
        return("double")
    }
    if ("integer" %in% types) {
        return("integer")
    }
    if ("logical" %in% types) {
        return("logical")
    }
}

test_iso_date <- function(x) {
    class(try(as.Date(x), silent = TRUE)) == "Date"
}


