
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

## Working with the data

To work with the data in R, you can use code like the following:

``` r
library(hubUtils)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

model_outputs <- hubUtils::connect_hub(hub_path = ".") %>%
  dplyr::collect()
head(model_outputs)
#> # A tibble: 6 × 9
#>   location reference_date horizon target_end_date target          output_type
#>   <chr>    <date>           <int> <date>          <chr>           <chr>      
#> 1 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> 2 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> 3 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> 4 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> 5 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> 6 US       2022-10-22           0 2022-10-22      wk inc flu hosp quantile   
#> # ℹ 3 more variables: output_type_id <chr>, value <dbl>, model_id <chr>

target_time_series_data <- read.csv(
  "target-data/flu-hospitalization-time-series.csv")
head(target_time_series_data)
#>         date location value
#> 1 2020-01-11       01     0
#> 2 2020-01-11       15     0
#> 3 2020-01-11       18     0
#> 4 2020-01-11       27     0
#> 5 2020-01-11       30     0
#> 6 2020-01-11       37     0

inc_flu_hosp_target_data <- read.csv(
  "target-data/wk-inc-flu-hosp-target-values.csv")
head(inc_flu_hosp_target_data)
#>   location reference_date horizon target_end_date          target value
#> 1       01     2022-10-22       0      2022-10-22 wk inc flu hosp   141
#> 2       01     2022-10-22       1      2022-10-29 wk inc flu hosp   262
#> 3       01     2022-10-22       2      2022-11-05 wk inc flu hosp   360
#> 4       01     2022-10-22       3      2022-11-12 wk inc flu hosp   303
#> 5       01     2022-10-29       0      2022-10-29 wk inc flu hosp   262
#> 6       01     2022-10-29       1      2022-11-05 wk inc flu hosp   360

rate_category_target_data <- read.csv(
  "target-data/wk-flu-hosp-rate-category-target-values.csv")
head(rate_category_target_data)
#>   location reference_date horizon target_end_date                    target
#> 1       01     2022-10-22       0      2022-10-22 wk flu hosp rate category
#> 2       01     2022-10-22       1      2022-10-29 wk flu hosp rate category
#> 3       01     2022-10-22       2      2022-11-05 wk flu hosp rate category
#> 4       01     2022-10-22       3      2022-11-12 wk flu hosp rate category
#> 5       01     2022-10-29       0      2022-10-29 wk flu hosp rate category
#> 6       01     2022-10-29       1      2022-11-05 wk flu hosp rate category
#>   output_type_id value
#> 1       moderate     1
#> 2           high     1
#> 3           high     1
#> 4           high     1
#> 5           high     1
#> 6           high     1
```
