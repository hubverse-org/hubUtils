## code to prepare `json_datatypes` dataset goes here
json_datatypes <- c(
  string = "character",
  boolean = "logical",
  integer = "integer",
  number = "double"
)

## code to prepare `std_col_datatypes` dataset goes here
std_col_datatypes <- c(
    model_id = "character",
    output_type = "character",
    value = "numeric"
)

usethis::use_data(json_datatypes, std_col_datatypes,
                  overwrite = TRUE, internal = TRUE)
