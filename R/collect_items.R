collect_items <- function(...,
                          item_class = c(
                            "task_id",
                            "output_type_item",
                            "target_metadata_item",
                            "model_task",
                            "round"
                          ),
                          output_class = c(
                            "task_ids",
                            "output_type",
                            "target_metadata",
                            "model_tasks",
                            "rounds"
                          ),
                          flatten = TRUE,
                          call = rlang::caller_env()) {
  item_class <- rlang::arg_match(item_class)
  output_class <- rlang::arg_match(output_class)

  items <- list(...)

  check_item_classes(items, item_class, call = call)

  schema_id <- check_schema_ids(items, call = call)

  if (flatten) {
    items <- purrr::list_flatten(items)
  } else {
    items <- purrr::map(
      items,
      function(x) {
        attributes(x) <- list(names = names(x))
        return(x)
      }
    )
  }
  if (item_class == "target_metadata_item") {
    check_target_metadata_properties_unique(items,
      property = "target_id",
      call = call
    )
    check_target_metadata_properties_unique(items,
      property = "target_name",
      call = call
    )
    check_target_metadata_properties_unique(items,
      property = "target_keys",
      call = call
    )
  } else {
    check_property_names_unique(items, call = call)
  }

  check_items_unique(items, item_class)

  structure(list(items),
    class = c(output_class, "list"),
    names = output_class,
    n = length(items),
    schema_id = schema_id
  )
}



check_items_unique <- function(items, item_class, call = rlang::caller_env()) {
  is_duplicate <- duplicated(items)

  if (any(is_duplicate)) {
    duplicated_items <- items[is_duplicate]
    duplicated_idx <- which(is_duplicate)


    duplicate_of <- purrr::map2_int(
      duplicated_items,
      duplicated_idx,
      ~ find_duplicate_of(.x, .y, items)
    )

    duplicate_of_msg <- paste0(
      "{.cls {item_class}} object ", "{.val {", duplicated_idx, "L}} ",
      "is a duplicate of object", " {.val {", duplicate_of, "L}}"
    ) %>%
      stats::setNames(rep("x", length(duplicate_of)))

    cli::cli_abort(
      "!" = "All {.cls {item_class}} objects provided must be unique
                   but duplicates detected.",
      duplicate_of_msg,
      call = call
    )
  }
}

find_duplicate_of <- function(duplicated_item, duplicate_idx, items) {
  which(purrr::map_lgl(
    items,
    ~ identical(.x, duplicated_item)
  )) %>%
    utils::head(1)
}
