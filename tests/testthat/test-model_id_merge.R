test_that("merging-splitting model_id works", {
  hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date))

  # Test splitting
  expect_snapshot(model_id_split(tbl) %>%
    dplyr::arrange(dplyr::desc(model_abbr)))
  tbl <- model_id_split(tbl)
  expect_equal(
    names(tbl),
    c(
      "team_abbr", "model_abbr", "forecast_date", "horizon", "target",
      "location", "output_type", "output_type_id", "value"
    )
  )
  expect_equal(unique(tbl$model_abbr), c("baseline", "ensemble"))
  expect_equal(unique(tbl$team_abbr), c("hub"))
  expect_snapshot(model_id_split(tbl), error = TRUE)

  # Test merging
  expect_equal(
    names(suppressMessages(model_id_merge(tbl))),
    c(
      "model_id", "forecast_date", "horizon", "target", "location",
      "output_type", "output_type_id", "value"
    )
  )
  expect_equal(
    suppressMessages(unique(model_id_merge(tbl)$model_id)),
    c("hub-baseline", "hub-ensemble")
  )

  tbl <- suppressMessages(as_model_out_tbl(tbl))
  expect_equal(
    names(tbl),
    c(
      "model_id", "forecast_date", "horizon", "target", "location",
      "output_type", "output_type_id", "value"
    )
  )
  expect_equal(
    unique(tbl$model_id),
    c("hub-baseline", "hub-ensemble")
  )


  expect_snapshot(model_id_merge(tbl), error = TRUE)

  # Test custom separator
  tbl_sep <- tbl
  tbl_sep$model_id <- gsub("-", "_", tbl_sep$model_id)
  tbl_sep <- model_id_split(tbl_sep, sep = "_")
  expect_equal(unique(tbl_sep$model_abbr), c("baseline", "ensemble"))
  expect_equal(unique(tbl_sep$team_abbr), c("hub"))
  expect_true(all(c("team_abbr", "model_abbr") %in% names(tbl_sep)))


  tbl_sep <- model_id_merge(tbl_sep, sep = "_")
  expect_true("model_id" %in% names(tbl_sep))
  expect_equal(
    unique(tbl_sep$model_id),
    c("hub_baseline", "hub_ensemble")
  )
})
