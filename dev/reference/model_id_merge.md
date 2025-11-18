# Merge/Split model output tbl `model_id` column

Merge/Split model output tbl `model_id` column

## Usage

``` r
model_id_merge(tbl, sep = "-")

model_id_split(tbl, sep = "-")
```

## Arguments

- tbl:

  a `data.frame` or `tibble` of model output data returned from a query
  to a `<hub_connection>` object.

- sep:

  character string. Character used as separator when concatenating
  `team_abbr` and `model_abbr` values into a single `model_id` string or
  splitting `model_id` into component `team_abbr` and `model_abbr`. When
  splitting, if multiple instances of the separator exist in a
  `model_id` stringing, splitting occurs occurs on the first instance.

## Value

`tbl` with either `team_abbr` and `model_abbr` merged into a single
`model_id` column or `model_id` split into columns `team_abbr` and
`model_abbr`.

a [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
`model_id` column split into separate `team_abbr` and `model_abbr`
columns

## Functions

- `model_id_merge()`: merge `team_abbr` and `model_abbr` into a single
  `model_id` column.

- `model_id_split()`: split `model_id` column into separate `team_abbr`
  and `model_abbr` columns.

## Examples

``` r
tbl_split <- model_id_split(hub_con_output)
tbl_split
#> # A tibble: 92 × 9
#>    team_abbr model_abbr forecast_date horizon target        location output_type
#>    <chr>     <chr>      <date>          <int> <chr>         <chr>    <chr>      
#>  1 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  2 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  3 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  4 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  5 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  6 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  7 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  8 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  9 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#> 10 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#> # ℹ 82 more rows
#> # ℹ 2 more variables: output_type_id <chr>, value <dbl>

# Merge model_id
tbl_merged <- model_id_merge(tbl_split)
tbl_merged
#> # A tibble: 92 × 8
#>    model_id     forecast_date horizon target location output_type output_type_id
#>    <chr>        <date>          <int> <chr>  <chr>    <chr>       <chr>         
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

# Split / Merge using custom separator
tbl_sep <- hub_con_output
tbl_sep$model_id <- gsub("-", "_", tbl_sep$model_id)
tbl_sep <- model_id_split(tbl_sep, sep = "_")
tbl_sep
#> # A tibble: 92 × 9
#>    team_abbr model_abbr forecast_date horizon target        location output_type
#>    <chr>     <chr>      <date>          <int> <chr>         <chr>    <chr>      
#>  1 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  2 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  3 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  4 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  5 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  6 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  7 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  8 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#>  9 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#> 10 hub       baseline   2023-05-08          1 wk ahead inc… US       quantile   
#> # ℹ 82 more rows
#> # ℹ 2 more variables: output_type_id <chr>, value <dbl>
tbl_sep <- model_id_merge(tbl_sep, sep = "_")
tbl_sep
#> # A tibble: 92 × 8
#>    model_id     forecast_date horizon target location output_type output_type_id
#>    <chr>        <date>          <int> <chr>  <chr>    <chr>       <chr>         
#>  1 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.01          
#>  2 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.025         
#>  3 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.05          
#>  4 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.1           
#>  5 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.15          
#>  6 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.2           
#>  7 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.25          
#>  8 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.3           
#>  9 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.35          
#> 10 hub_baseline 2023-05-08          1 wk ah… US       quantile    0.4           
#> # ℹ 82 more rows
#> # ℹ 1 more variable: value <dbl>
```
