## code to prepare `hub_con_output` dataset goes here
hub_path <- system.file("testhubs/flusight", package = "hubUtils")
hub_con <- hubData::connect_hub(hub_path)
hub_con_output <- hub_con |>
  dplyr::filter(output_type == "quantile", location == "US") |>
  dplyr::collect() |>
  dplyr::filter(forecast_date == max(forecast_date))


usethis::use_data(hub_con_output, overwrite = TRUE)
