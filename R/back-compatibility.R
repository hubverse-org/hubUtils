get_config_tid <- function(config_version, config_tasks) {
  tid_check <- check_deprecated_schema( # nolint: object_usage_linter
    config_version = config_version,
    config = config_tasks,
    valid_version = "v2.0.0",
    hubutils_version = "0.0.0.9010"
  )
  if (tid_check) "type_id" else "output_type_id"
}

get_schema_version_latest <- function(schema_version = "latest",
                                      branch = "main") {
  if (schema_version == "latest") {
    get_schema_valid_versions(branch = branch) %>%
      sort() %>%
      utils::tail(1)
  } else {
    schema_version
  }
}
