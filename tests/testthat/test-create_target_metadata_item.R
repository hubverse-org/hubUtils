test_that("create_target_metadata_item functions work correctly", {
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    )
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = FALSE
    )
  )
})



test_that("create_target_metadata_item functions error correctly", {
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "weekly"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = c("inc hosp", "inc death")),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = c(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = TRUE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = 100000,
      target_type = "discrete",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "invalid_target_type",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = c("rate per 100,000 population", "count"),
      target_type = "discrete",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
})
