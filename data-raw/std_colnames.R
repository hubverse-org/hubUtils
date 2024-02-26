## code to prepare `std_colnames` dataset goes here
std_colnames <- c("model_id", "output_type", "output_type_id", "value") |>
  purrr::set_names()

usethis::use_data(std_colnames, overwrite = TRUE)
