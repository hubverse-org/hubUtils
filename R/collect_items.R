collect_items <- function(...,
                          item_class = c("task_id",
                                         "output_type_item",
                                         "target_metadata_item",
                                         "model_task"),
                          output_class = c("task_ids",
                                           "output_type",
                                           "target_metadata",
                                           "model_tasks"),
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
        items <- purrr::map(items,
                            function(x) {
                                attributes(x) <- list(names = names(x))
                                return(x)
                            })
    }
    if (item_class == "target_metadata_item") {
        check_target_metadata_properties_unique(items, property = "target_id",
                                                call = call)
        check_target_metadata_properties_unique(items, property = "target_name",
                                                call = call)
        check_target_metadata_properties_unique(items, property = "target_keys",
                                                call = call)
    } else {
        check_property_names_unique(items, call = call)
    }

    structure(list(items),
              class = c(output_class, "list"),
              names = output_class,
              n = length(items),
              schema_id = schema_id
    )
}
