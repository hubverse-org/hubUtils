get_error_path <- function(schema, element = "target_metadata",
                           type = c("schema", "instance"),
                           append_item_n = FALSE) {
  type <- rlang::arg_match(type)

  schema_paths <- schema %>%
    jsonlite::fromJSON(simplifyDataFrame = FALSE) %>%
    unlist(recursive = TRUE, use.names = TRUE) %>%
    names() %>%
    gsub("\\.", "/", .) %>%
    paste0("/", .)

  path <- grep(paste0(".*", element, "/type([0-9])?$"),
    schema_paths,
    value = TRUE
  ) %>%
    gsub("/type([0-9])?", "", .) %>%
    unique()

  # Instance paths to custom task IDs can be created by appending the element
  # name to the task ID properties.
  if (length(path) == 0L && type == "instance") {
    path <- grep(paste0(".*", "task_ids", "/type([0-9])?$"),
      schema_paths,
      value = TRUE
    ) %>%
      gsub("/type([0-9])?", "", .) %>%
      unique() %>%
      paste("properties", element, sep = "/")
  }

  # Schema paths to custom task IDs can be created by pointing to the task_ids
  # additionalProperties schema.
  # This will only retrun a path with schema v2.0.0 and above, when
  # additionalProperties became an object.
  if (length(path) == 0L && type == "schema") {
    path <- grep(".*task_ids/additionalProperties/type([0-9])?$",
      schema_paths,
      value = TRUE
    ) %>%
      gsub("/type([0-9])?", "", .) %>%
      unique()
  }

  if (append_item_n && any(
    grepl(
      paste(path, "items", sep = "/"),
      schema_paths
    )
  ) &&
    length(path) != 0L
  ) {
    path <- paste(path, "items", sep = "/")
  }


  switch(type,
    schema = if (length(path) == 0L) NA else paste0("#", path),
    instance = generate_instance_path_glue(path)
  )
}

generate_instance_path_glue <- function(path) {
  split_path <- gsub("properties/", "", path) %>%
    strsplit("/") %>%
    unlist()

  is_item <- split_path == "items"
  split_path[is_item] <- c(
    "{round_i - 1}",
    "{model_task_i - 1}",
    "{target_key_i - 1}"
  )[1:sum(is_item)]
  paste(split_path, collapse = "/")
}
