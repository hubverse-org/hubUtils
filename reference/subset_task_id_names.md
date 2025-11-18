# Subset a vector of column names to only include task IDs

Subset a vector of column names to only include task IDs

## Usage

``` r
subset_task_id_names(x)
```

## Arguments

- x:

  character vector of column names

## Value

a character vector of task ID names

## Examples

``` r
x <- c(
  "origin_date", "horizon", "target_date",
  "location", "output_type", "output_type_id", "value"
)
subset_task_id_names(x)
#> [1] "origin_date" "horizon"     "target_date" "location"   
```
