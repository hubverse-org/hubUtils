# Transform between output types

Transform between output types for each unique combination of task IDs
for each model. Conversion must be from a single initial output type to
one or more to output types, and the resulting output will only contain
the to output types. See details for supported conversions.

## Usage

``` r
convert_output_type(model_out_tbl, to)
```

## Arguments

- model_out_tbl:

  an object of class `model_out_tbl` containing predictions with a
  single, unique value in the `output_type` column.

- to:

  a named list indicating the desired output types and associated output
  type IDs. List item name and value pairs may be as follows:

  - `mean`: `NA` (no associated output type ID)

  - `median`: `NA` (no associated output type ID)

  - `quantile`: a numeric vector of probability levels OR a dataframe of
    probability levels and the task ID variables they depend upon. (See
    examples section for an example of each.) Note that any task ID
    variable value must appear in the associated `model_out_tbl` task ID
    column

## Value

object of class `model_out_tbl` containing (only) predictions of the to
output_type(s) for each unique combination of task IDs for each model

## Details

Currently, only `"sample"` can be converted to `"mean"`, `"median"`, or
`"quantile"`

## Examples

``` r
# We illustrate the conversion between output types using normal distributions
ex_quantiles <- c(0.25, 0.5, 0.75)
model_out_tbl <- expand.grid(
  stringsAsFactors = FALSE,
  group1 = c(1, 2),
  model_id = "A",
  output_type = "sample",
  output_type_id = 1:100
) |>
  dplyr::mutate(value = rnorm(200, mean = group1))

# Output type conversions with vector `to` elements
convert_output_type(model_out_tbl,
  to = list("quantile" = ex_quantiles, "median" = NA)
)
#> # A tibble: 8 × 5
#>   model_id group1 output_type output_type_id value
#> * <chr>     <dbl> <chr>                <dbl> <dbl>
#> 1 A             1 quantile              0.25 0.614
#> 2 A             1 quantile              0.5  1.13 
#> 3 A             1 quantile              0.75 1.87 
#> 4 A             2 quantile              0.25 1.45 
#> 5 A             2 quantile              0.5  2.09 
#> 6 A             2 quantile              0.75 2.75 
#> 7 A             1 median               NA    1.13 
#> 8 A             2 median               NA    2.09 

# Output type conversion with dataframe `to` element
# Output type ID values (quantile levels) are determined by group1 value
quantile_levels <- rbind(
  data.frame(group1 = 1, output_type_id = 0.5),
  data.frame(group1 = 2, output_type_id = c(0.25, 0.5, 0.75))
)
convert_output_type(model_out_tbl,
  to = list("quantile" = quantile_levels)
)
#> # A tibble: 4 × 5
#>   model_id group1 output_type output_type_id value
#> * <chr>     <dbl> <chr>                <dbl> <dbl>
#> 1 A             1 quantile              0.5   1.13
#> 2 A             2 quantile              0.25  1.45
#> 3 A             2 quantile              0.5   2.09
#> 4 A             2 quantile              0.75  2.75
```
