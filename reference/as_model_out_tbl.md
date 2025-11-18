# Convert model output to a `model_out_tbl` class object.

Convert model output to a `model_out_tbl` class object.

## Usage

``` r
as_model_out_tbl(
  tbl,
  model_id_col = NULL,
  output_type_col = NULL,
  output_type_id_col = NULL,
  value_col = NULL,
  sep = "-",
  trim_to_task_ids = FALSE,
  hub_con = NULL,
  task_id_cols = NULL,
  remove_empty = FALSE
)
```

## Arguments

- tbl:

  a `data.frame` or `tibble` of model output data returned from a query
  to a `<hub_connection>` object.

- model_id_col:

  character string. If a `model_id` column does not already exist in
  `tbl`, the `tbl` column name containing `model_id` data.
  Alternatively, if both a `team_abbr` and a `model_abbr` column exist,
  these will be merged automatically to create a single `model_id`
  column.

- output_type_col:

  character string. If an `output_type` column does not already exist in
  `tbl`, the `tbl` column name containing `output_type` data.

- output_type_id_col:

  character string. If an `output_type_id` column does not already exist
  in `tbl`, the `tbl` column name containing `output_type_id` data.

- value_col:

  character string. If a `value` column does not already exist in `tbl`,
  the `tbl` column name containing `value` data.

- sep:

  character string. Character used as separator when concatenating
  `team_abbr` and `model_abbr` column values into a single `model_id`
  string. Only applicable if `model_id` column not present and
  `team_abbr` and `model_abbr` columns are.

- trim_to_task_ids:

  logical. Whether to trim `tbl` to task ID columns only. Task ID
  columns can be specified by providing a `<hub_connection>` class
  object to `hub_con` or manually through `task_id_cols`.

- hub_con:

  a `<hub_connection>` class object. Only used if
  `trim_to_task_ids = TRUE` and tasks IDs should be determined from the
  hub config.

- task_id_cols:

  a character vector of column names. Only used if
  `trim_to_task_ids = TRUE` to manually specify task ID columns to
  retain. Overrides `hub_con` argument if provided.

- remove_empty:

  Logical. Whether to remove columns containing only `NA`.

## Value

A `model_out_tbl` class object.

## Examples

``` r
as_model_out_tbl(hub_con_output)
#> # A tibble: 92 × 8
#>    model_id     forecast_date horizon target location output_type output_type_id
#>  * <chr>        <date>          <int> <chr>  <chr>    <chr>       <chr>         
#>  1 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.01          
#>  2 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.025         
#>  3 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.05          
#>  4 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.1           
#>  5 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.15          
#>  6 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.2           
#>  7 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.25          
#>  8 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.3           
#>  9 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.35          
#> 10 hub-baseline 2023-05-08          1 wk ah… US       quantile    0.4           
#> # ℹ 82 more rows
#> # ℹ 1 more variable: value <dbl>
```
