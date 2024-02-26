## code to prepare `json_datatypes` dataset goes here
json_datatypes <- c(
  string = "character",
  boolean = "logical",
  integer = "integer",
  number = "double"
)

## code to prepare `std_col_datatypes` dataset goes here
std_col_datatypes <- list(
  model_id = c("character", "factor"),
  output_type = c("character", "factor"),
  value = "numeric"
)

## code to prepare `std_colnames` dataset goes here
std_colnames <- c("model_id", "output_type", "output_type_id", "value") |>
  purrr::set_names()


usethis::use_data(json_datatypes, std_colnames, std_col_datatypes,
  overwrite = TRUE, internal = TRUE
)
