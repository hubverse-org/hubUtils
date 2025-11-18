# Subset a `model_out_tbl` or submission `tbl`.

Subset a `model_out_tbl` or submission `tbl`.

## Usage

``` r
subset_task_id_cols(model_out_tbl)

subset_std_cols(model_out_tbl)
```

## Arguments

- model_out_tbl:

  A `model_out_tbl` or submission `tbl` object. Must inherit from class
  `data.frame`.

## Value

- `subset_task_id_cols`: an object of the same class as `model_out_tbl`
  which contains only task ID columns.

&nbsp;

- `subset_std_cols`: an object of the same class as `model_out_tbl`
  which contains only hubverse standard columns (i.e. columns that are
  not task_id columns).

## Functions

- `subset_task_id_cols()`: subset a `model_out_tbl` or submission `tbl`
  to only include task_id columns

- `subset_std_cols()`: subset a `model_out_tbl` or submission `tbl` to
  only include hubverse standard columns (i.e. columns that are not
  task_id columns)

## Examples

``` r
model_out_tbl_path <- system.file("testhubs", "v4", "simple",
  "model-output", "hub-baseline", "2022-10-15-hub-baseline.parquet",
  package = "hubUtils"
)
model_out_tbl <- arrow::read_parquet(model_out_tbl_path)
subset_task_id_cols(model_out_tbl)
#> # A tibble: 276 × 5
#>    origin_date target          horizon location age_group
#>    <date>      <chr>             <int> <chr>    <chr>    
#>  1 2022-10-15  wk inc flu hosp       1 US       65+      
#>  2 2022-10-15  wk inc flu hosp       1 US       65+      
#>  3 2022-10-15  wk inc flu hosp       1 US       65+      
#>  4 2022-10-15  wk inc flu hosp       1 US       65+      
#>  5 2022-10-15  wk inc flu hosp       1 US       65+      
#>  6 2022-10-15  wk inc flu hosp       1 US       65+      
#>  7 2022-10-15  wk inc flu hosp       1 US       65+      
#>  8 2022-10-15  wk inc flu hosp       1 US       65+      
#>  9 2022-10-15  wk inc flu hosp       1 US       65+      
#> 10 2022-10-15  wk inc flu hosp       1 US       65+      
#> # ℹ 266 more rows
subset_std_cols(model_out_tbl)
#> # A tibble: 276 × 3
#>    output_type output_type_id value
#>    <chr>                <dbl> <int>
#>  1 quantile             0.01    135
#>  2 quantile             0.025   137
#>  3 quantile             0.05    139
#>  4 quantile             0.1     140
#>  5 quantile             0.15    141
#>  6 quantile             0.2     141
#>  7 quantile             0.25    142
#>  8 quantile             0.3     143
#>  9 quantile             0.35    144
#> 10 quantile             0.4     145
#> # ℹ 266 more rows
```
