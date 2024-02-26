## code to prepare `hub_locations` dataset goes here
library(dplyr)
hub_locations_us <- covidHubUtils::hub_locations |>
  select(-population, -full_location_name) |>
  tibble::as_tibble()

hub_locations_eu <- covidHubUtils::hub_locations_ecdc |>
  select(-population) |>
  tibble::as_tibble()

usethis::use_data(hub_locations_us, overwrite = TRUE)

usethis::use_data(hub_locations_eu, overwrite = TRUE)
