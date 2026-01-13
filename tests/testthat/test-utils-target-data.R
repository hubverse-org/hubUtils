test_that("get_date_col works", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  expect_equal(get_date_col(config), "target_end_date")
})

test_that("get_observable_unit returns global value by default", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  # Both datasets should return the global observable_unit
  expect_equal(
    get_observable_unit(config, dataset = "time-series"),
    c("target_end_date", "target", "location")
  )
  expect_equal(
    get_observable_unit(config, dataset = "oracle-output"),
    c("target_end_date", "target", "location")
  )
})

test_that("get_observable_unit falls back to global when dataset not configured", {
  # Create a minimal config with only global observable_unit
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date"
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_equal(
    get_observable_unit(config, dataset = "time-series"),
    c("date", "location")
  )
  expect_equal(
    get_observable_unit(config, dataset = "oracle-output"),
    c("date", "location")
  )
})

test_that("get_observable_unit uses dataset-specific override", {
  # Create a config with dataset-specific observable_unit override
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      "oracle-output" = list(
        observable_unit = c("date", "location", "horizon")
      )
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  # time-series should use its specific override
  expect_equal(
    get_observable_unit(config, dataset = "oracle-output"),
    c("date", "location", "horizon")
  )

  # oracle-output should still use global
  expect_equal(
    get_observable_unit(config, dataset = "time-series"),
    c("date", "location")
  )
})

test_that("get_observable_unit validates dataset parameter", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  expect_error(
    get_observable_unit(config, dataset = "invalid"),
    regexp = "`dataset` must be one of"
  )
})

test_that("get_versioned returns global value by default", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  # Both datasets should return the global versioned setting
  expect_equal(get_versioned(config, dataset = "time-series"), FALSE)
  expect_equal(get_versioned(config, dataset = "oracle-output"), FALSE)
})

test_that("get_versioned defaults to FALSE when not specified", {
  # Create a config without versioned property
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date"
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_equal(get_versioned(config, dataset = "time-series"), FALSE)
  expect_equal(get_versioned(config, dataset = "oracle-output"), FALSE)
})

test_that("get_versioned inherits from global when dataset not configured", {
  # Create a config with global versioned = TRUE but no dataset configs
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      versioned = TRUE
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_equal(get_versioned(config, dataset = "time-series"), TRUE)
  expect_equal(get_versioned(config, dataset = "oracle-output"), TRUE)
})

test_that("get_versioned uses dataset-specific override", {
  # Create a config with dataset-specific versioned override
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      "time-series" = list(
        versioned = TRUE
      )
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  # time-series should use its specific override
  expect_equal(get_versioned(config, dataset = "time-series"), TRUE)

  # oracle-output should still use global
  expect_equal(get_versioned(config, dataset = "oracle-output"), FALSE)
})

test_that("get_versioned validates dataset parameter", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  expect_error(
    get_versioned(config, dataset = "invalid"),
    regexp = "`dataset` must be one of"
  )
})

test_that("get_has_output_type_ids works", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  expect_equal(get_has_output_type_ids(config), TRUE)
})

test_that("get_has_output_type_ids defaults to FALSE when not specified", {
  # Create a config without oracle-output section
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date"
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_equal(get_has_output_type_ids(config), FALSE)
})

test_that("get_has_output_type_ids defaults to FALSE when oracle-output exists but property not specified", {
  # Create a config with oracle-output section but no has_output_type_ids
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      "oracle-output" = list(
        versioned = TRUE
      )
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_equal(get_has_output_type_ids(config), FALSE)
})

test_that("get_non_task_id_schema returns NULL when not specified", {
  # Create a config without time-series section
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date"
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_null(get_non_task_id_schema(config))
})

test_that("get_non_task_id_schema returns NULL when time-series exists but property not specified", {
  # Create a config with time-series section but no non_task_id_schema
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      "time-series" = list(
        versioned = TRUE
      )
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  expect_null(get_non_task_id_schema(config))
})

test_that("get_non_task_id_schema returns schema when specified", {
  # Create a config with non_task_id_schema
  config <- structure(
    list(
      schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
      observable_unit = c("date", "location"),
      date_col = "date",
      "time-series" = list(
        non_task_id_schema = list(
          location_name = "character",
          population = "integer"
        )
      )
    ),
    class = c("config", "list"),
    config_type = "target-data"
  )

  schema <- get_non_task_id_schema(config)
  expect_type(schema, "list")
  expect_named(schema, c("location_name", "population"))
  expect_equal(schema$location_name, "character")
  expect_equal(schema$population, "integer")
})

test_that("all functions work together on real config", {
  hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
  config <- read_config(hub_path, "target-data")

  # Test all functions return expected values
  expect_equal(get_date_col(config), "target_end_date")
  expect_equal(
    get_observable_unit(config, "time-series"),
    c("target_end_date", "target", "location")
  )
  expect_equal(
    get_observable_unit(config, "oracle-output"),
    c("target_end_date", "target", "location")
  )
  expect_equal(get_versioned(config, "time-series"), FALSE)
  expect_equal(get_versioned(config, "oracle-output"), FALSE)
  expect_equal(get_has_output_type_ids(config), TRUE)
  expect_null(get_non_task_id_schema(config))
})

test_that("has_target_data_config works on local hubs", {
  config_hub <- system.file("testhubs/v6/target_file/", package = "hubUtils")
  expect_true(has_target_data_config(config_hub))

  no_config_hub <- system.file("testhubs/v5/target_file/", package = "hubUtils")
  expect_false(has_target_data_config(no_config_hub))
})

test_that("has_target_data_config works on S3 hubs", {
  skip_on_cran()
  skip_if_not(arrow::arrow_with_s3())
  no_config_hub <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
  expect_false(has_target_data_config(no_config_hub))
})
