test_that("column renaming works", {
  skip_if_not_installed("hubData")
  hub_con <- hubData::connect_hub(system.file("testhubs/flusight", package = "hubUtils"))

  x <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date)) %>%
    dplyr::arrange(model_id)

  names(x)[names(x) == "output_type"] <- "output_type_rename"

  output_type_col <- "output_type_rename"

  # Test successful column renaming
  expect_snapshot(
    str(as_model_out_tbl(x, output_type_col = output_type_col))
  )

  # Test error in column renaming
  output_type_col <- "output_type_rename_error"
  expect_snapshot(
    as_model_out_tbl(x, output_type_col = output_type_col),
    error = TRUE
  )

  output_type_col <- "output_type_rename"
  col_names <- names(as_model_out_tbl(x, output_type_col = output_type_col))
  output_type_col <- c(output_type_col, "second_col_name")
  expect_warning(names(as_model_out_tbl(x, output_type_col = output_type_col)))

  expect_equal(
    col_names,
    names(
      suppressWarnings(
        as_model_out_tbl(x, output_type_col = output_type_col)
      )
    )
  )
})

test_that("triming to task ids works", {
  skip_if_not_installed("hubData")
  hub_con <- hubData::connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date)) %>%
    dplyr::arrange(model_id)

  tbl$age_group <- NA
  expect_equal(
    names(as_model_out_tbl(tbl,
      trim_to_task_ids = TRUE,
      hub_con = hub_con
    )),
    c(
      "model_id", "forecast_date", "target", "horizon", "location",
      "output_type", "output_type_id", "value"
    )
  )

  expect_equal(
    names(as_model_out_tbl(tbl,
      trim_to_task_ids = TRUE,
      task_id_cols = c("forecast_date", "target"),
      hub_con = hub_con
    )),
    c(
      "model_id", "forecast_date", "target",
      "output_type", "output_type_id", "value"
    )
  )

  tbl$location <- NULL
  expect_snapshot(
    names(as_model_out_tbl(tbl,
      trim_to_task_ids = TRUE,
      hub_con = hub_con
    ))
  )
})

test_that("removing empty columns works", {
  skip_if_not_installed("hubData")
  hub_con <- hubData::connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date)) %>%
    dplyr::arrange(model_id)

  tbl$age_group <- NA

  expect_equal(
    names(as_model_out_tbl(tbl, remove_empty = TRUE)),
    c(
      "model_id", "forecast_date", "horizon", "target", "location",
      "output_type", "output_type_id", "value"
    )
  )

  # Ensure std_cols are not removed
  tbl$output_type_id <- NA
  expect_equal(
    names(as_model_out_tbl(tbl, remove_empty = TRUE)),
    c(
      "model_id", "forecast_date", "horizon", "target", "location",
      "output_type", "output_type_id", "value"
    )
  )
})

test_that("validating model_out_tbl std column datatypes works", {
  skip_if_not_installed("hubData")

  # test that correct data types succeed
  hub_con <- hubData::connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date)) %>%
    dplyr::arrange(model_id)

  expect_s3_class(as_model_out_tbl(tbl), "model_out_tbl")

  tbl$value <- as.integer(tbl$value)
  expect_s3_class(as_model_out_tbl(tbl), "model_out_tbl")

  # test that wrong data types throw error.
  tbl$model_id <- as.factor(tbl$model_id)
  tbl$output_type <- seq_along(tbl$output_type)
  tbl$value <- as.character(tbl$value)

  expect_snapshot(as_model_out_tbl(tbl), error = TRUE)
})
