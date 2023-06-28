test_that("column renaming works", {
  hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))

  x <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date))
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
  expect_warning(names(as_model_out_tbl(x,
    output_type_col = output_type_col
  )))

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
  hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date))

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
})

test_that("removing empty columns works", {
  hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
  tbl <- hub_con %>%
    dplyr::filter(output_type == "quantile", location == "US") %>%
    dplyr::collect() %>%
    dplyr::filter(forecast_date == max(forecast_date))

  tbl$age_group <- NA

  expect_equal(
    names(suppressMessages(as_model_out_tbl(tbl, remove_empty = TRUE))),
    c(
      "model_id", "forecast_date", "horizon", "target", "location",
      "output_type", "output_type_id", "value"
    )
  )
})