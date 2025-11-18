# Validate a `model_out_tbl` object.

Validate a `model_out_tbl` object.

## Usage

``` r
validate_model_out_tbl(tbl)
```

## Arguments

- tbl:

  a `model_out_tbl` S3 class object.

## Value

If valid, returns a `model_out_tbl` class object. Otherwise, throws an
error.

## Examples

``` r
md_out <- as_model_out_tbl(hub_con_output)
validate_model_out_tbl(md_out)
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
