## code to prepare `json_datatypes` dataset goes here
json_datatypes <- c(
  string = "character",
  boolean = "logical",
  integer = "integer",
  number = "double"
)

## code to prepare `std_colnames` dataset goes here
std_colnames <- c("model_id", "output_type", "output_type_id", "value") |>
  purrr::set_names()


usethis::use_data(
  json_datatypes,
  std_colnames,
  overwrite = TRUE,
  internal = TRUE
)
