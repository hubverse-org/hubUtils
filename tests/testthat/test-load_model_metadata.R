library(dplyr)
library(tibble)
library(tidyr)

test_that("load_model_metadata fails correctly", {
  # Incorrect hub path throws an error
  expect_error(
    load_model_metadata("no-hub"),
    regexp = "* directory does not exist."
  )

  # No model-metadata folder throws an error
  hub_path <- system.file("testhubs/flusight", package = "hubUtils")
  expect_error(
    load_model_metadata(hub_path),
    regexp = ".*model-metadata.* directory not found in root of Hub"
  )
  
  # Empty model-metadata folder throws an error
  hub_path <- system.file("testhubs/empty", package = "hubUtils")
  expect_error(
    load_model_metadata(hub_path),
    regexp = "* directory is empty."
  )
})

# Contains all three of team_abbr, model_abbr, model_id
test_that("resulting tibble has team_abbr, model_abbr, and model_id_columns", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  model_metadata <- load_model_metadata(hub_path)
  expect_true(all(c("team_abbr", "model_abbr", "model_id") %in% names(model_metadata)))
})

# Specifying non-existent models throws an error
test_that("Specifying models that don't provide metadata throws an error", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  expect_error(
    load_model_metadata(hub_path, model_ids="non-existent"),
    regexp = "* does not have associated metadata."
  )
})

# Output is a tibble
test_that("output is a tibble", {
  hub_path <- system.file("testhubs/simple", package = "hubUtils")
  model_metadata <- load_model_metadata(hub_path)
  expect_true(any(class(model_metadata) %in% c("tbl", "tbl_df", "data.frame")))
})
