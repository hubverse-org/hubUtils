
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Example Complex Forecast Hub

**This repository is under construction.**

This repository is designed as an example modeling Hub that follows the
infrastructure guidelines laid out by the [Consortium of Infectious
Disease Modeling
Hubs](https://github.com/Infectious-Disease-Modeling-Hubs/).

The example model outputs that are provided here are adapted from
forecasts submitted to the FluSight Forecast Hub for the 2022/23 season.
The original forecasts were provided in quantile format, but they have
been modified to provide examples of additional model output types and
targets. They should be viewed only as illustrations of the data
formats, not as realistic examples of forecasts. **Note that the folder
`internal-data-raw` is not a part of the standard hub setup; it contains
the original source data and scripts used to create the example model
output data and target data.**

## Working with the data in R

Install the [hubData
package](https://infectious-disease-modeling-hubs.github.io/hubData/) to
work with the data in R.

To connect to a local copy of the data, first clone this repository.

You can then use functions in the `hubData` package to connect to hub
data as well as dplyr functions to filter and select data prior to
collecting the data into R.

``` r
library(hubData)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following object is masked from 'package:testthat':
#> 
#>     matches
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

For example, to connect to the hub and collect all model outputs:

``` r
model_outputs <- connect_hub(hub_path = ".") %>%
  collect_hub()
```

To access time series target data, you can use the
`connect_target_time_series()` function. For example, to collect all
time series targets:

``` r
target_time_series_data <- connect_target_timeseries() |>
  collect()
target_time_series_data
#> # A tibble: 20,510 × 4
#>    date       target          location observation
#>    <date>     <chr>           <chr>          <dbl>
#>  1 2020-01-11 wk inc flu hosp 01                 0
#>  2 2020-01-11 wk inc flu hosp 15                 0
#>  3 2020-01-11 wk inc flu hosp 18                 0
#>  4 2020-01-11 wk inc flu hosp 27                 0
#>  5 2020-01-11 wk inc flu hosp 30                 0
#>  6 2020-01-11 wk inc flu hosp 37                 0
#>  7 2020-01-11 wk inc flu hosp 48                 0
#>  8 2020-01-11 wk inc flu hosp US                 1
#>  9 2020-01-18 wk inc flu hosp 01                 0
#> 10 2020-01-18 wk inc flu hosp 15                 0
#> # ℹ 20,500 more rows
```

You can also filter data prior to collecting it. For example, to collect
oracle-output target data for specific targets, you can use `dplyr`
function `filter()` to select the targets you are interested in.

``` r
inc_flu_hosp_oracle_data <- connect_target_oracle_output() |>
  filter(target == "wk inc flu hosp") |>
  collect()
inc_flu_hosp_oracle_data
#> # A tibble: 7,420 × 6
#>    location target_end_date target       output_type output_type_id oracle_value
#>    <chr>    <date>          <chr>        <chr>       <chr>                 <dbl>
#>  1 US       2022-10-22      wk inc flu … quantile    <NA>                   2380
#>  2 01       2022-10-22      wk inc flu … quantile    <NA>                    141
#>  3 02       2022-10-22      wk inc flu … quantile    <NA>                      3
#>  4 04       2022-10-22      wk inc flu … quantile    <NA>                     22
#>  5 05       2022-10-22      wk inc flu … quantile    <NA>                     50
#>  6 06       2022-10-22      wk inc flu … quantile    <NA>                    124
#>  7 08       2022-10-22      wk inc flu … quantile    <NA>                     15
#>  8 09       2022-10-22      wk inc flu … quantile    <NA>                      9
#>  9 10       2022-10-22      wk inc flu … quantile    <NA>                      1
#> 10 11       2022-10-22      wk inc flu … quantile    <NA>                      8
#> # ℹ 7,410 more rows
  
flu_hosp_rate_category_oracle_data <- connect_target_oracle_output() |>
  filter(target == "wk flu hosp rate category") |>
  collect()
flu_hosp_rate_category_oracle_data
#> # A tibble: 7,420 × 6
#>    location target_end_date target       output_type output_type_id oracle_value
#>    <chr>    <date>          <chr>        <chr>       <chr>                 <dbl>
#>  1 US       2022-10-22      wk flu hosp… pmf         low                       1
#>  2 US       2022-10-22      wk flu hosp… pmf         moderate                  0
#>  3 US       2022-10-22      wk flu hosp… pmf         high                      0
#>  4 US       2022-10-22      wk flu hosp… pmf         very high                 0
#>  5 01       2022-10-22      wk flu hosp… pmf         low                       0
#>  6 01       2022-10-22      wk flu hosp… pmf         moderate                  1
#>  7 01       2022-10-22      wk flu hosp… pmf         high                      0
#>  8 01       2022-10-22      wk flu hosp… pmf         very high                 0
#>  9 02       2022-10-22      wk flu hosp… pmf         low                       1
#> 10 02       2022-10-22      wk flu hosp… pmf         moderate                  0
#> # ℹ 7,410 more rows
```

### Accessing data from the cloud

To connect to a copy of this example data hosted in the cloud (on AWS
S3), first you need to create a hub path that points to the S3 bucket
where the hub data is stored. You can do this using the `s3_bucket()`
function from the `hubData` package.

``` r
hub_path <- s3_bucket("hubverse-example-complex-forecast-hub")
```

You can then use the same `connect_hub()` and `connect_target_*()`
functions to connect to and access the data in the cloud and also
`dplyr` functions to subset data prior to collecting.

For example, to collect all model outputs for a specific target end date
and location, you can use the following code:

``` r
connect_hub(hub_path, skip_checks = TRUE) |>
  filter(target_end_date == "2022-10-22",
         location == "02") |>
  collect_hub()
#> ℹ Updating superseded URL `Infectious-Disease-Modeling-hubs` to `hubverse-org`
#> ℹ Updating superseded URL `Infectious-Disease-Modeling-hubs` to `hubverse-org`
#> # A tibble: 687 × 9
#>    model_id   location reference_date horizon target_end_date target output_type
#>  * <chr>      <chr>    <date>           <int> <date>          <chr>  <chr>      
#>  1 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  2 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  3 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  4 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  5 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  6 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  7 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  8 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#>  9 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#> 10 Flusight-… 02       2022-10-22           0 2022-10-22      wk in… quantile   
#> # ℹ 677 more rows
#> # ℹ 2 more variables: output_type_id <chr>, value <dbl>
```
