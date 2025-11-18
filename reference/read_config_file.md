# Read a JSON config file from a path

Read a JSON config file from a path

## Usage

``` r
read_config_file(config_path, silent = TRUE)
```

## Arguments

- config_path:

  Either a character string of a path to a local JSON config file, a
  character string of the URL to the **raw contents** of a JSON config
  file (e.g on GitHub) or an object of class `<SubTreeFileSystem>`
  created using functions
  [`arrow::s3_bucket()`](https://arrow.apache.org/docs/r/reference/s3_bucket.html)
  and associated methods for creating paths to JSON config files within
  the bucket.

- silent:

  Logical. If `TRUE`, suppress warnings. Default is `FALSE`.

## Value

The contents of the config file as an R list. If possible, the output is
further converted to a `<config>` class object before returning. Note
that `"model-metadata-schema"` files are never converted to a `<config>`
object.

## Examples

``` r
# Read local config file
read_config_file(system.file("config", "tasks.json", package = "hubUtils"))
#> $schema_version
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
#> 
#> $rounds
#> $rounds[[1]]
#> $rounds[[1]]$round_id_from_variable
#> [1] TRUE
#> 
#> $rounds[[1]]$round_id
#> [1] "forecast_date"
#> 
#> $rounds[[1]]$model_tasks
#> $rounds[[1]]$model_tasks[[1]]
#> $rounds[[1]]$model_tasks[[1]]$task_ids
#> $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date
#> $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date$optional
#>  [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
#>  [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
#> [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
#> [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
#> [21] "2023-05-01" "2023-05-08" "2023-05-15"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
#> [1] "wk ahead inc flu hosp"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
#> [1] 2
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
#> [1] 1
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
#> [1] "US"
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
#> [1] "01" "02"
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$is_required
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$type
#> [1] "character"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$min_samples_per_task
#> [1] 50
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$max_samples_per_task
#> [1] 100
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$value
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$type
#> [1] "integer"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$minimum
#> [1] 0
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
#> [1] NA
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
#> [1] "double"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "wk ahead inc flu hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "weekly influenza hospitalization incidence"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
#> [1] "wk ahead inc flu hosp"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$description
#> [1] "This target represents the counts of new hospitalizations per horizon week."
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]
#> $rounds[[1]]$model_tasks[[2]]$task_ids
#> $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date
#> $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date$optional
#>  [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
#>  [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
#> [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
#> [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
#> [21] "2023-05-01" "2023-05-08" "2023-05-15"
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$target
#> $rounds[[1]]$model_tasks[[2]]$task_ids$target$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$target$optional
#> [1] "wk flu hosp rate change"
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[2]]$task_ids$horizon$required
#> [1] 2
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$horizon$optional
#> [1] 1
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$location
#> $rounds[[1]]$model_tasks[[2]]$task_ids$location$required
#> [1] "US"
#> 
#> $rounds[[1]]$model_tasks[[2]]$task_ids$location$optional
#> [1] "01" "02"
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$output_type
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id$required
#> [1] "large_decrease" "decrease"       "stable"         "increase"      
#> [5] "large_increase"
#> 
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id$optional
#> NULL
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$type
#> [1] "double"
#> 
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$minimum
#> [1] 0
#> 
#> $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_id
#> [1] "wk flu hosp rate change"
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_name
#> [1] "weekly influenza hospitalization rate change"
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_keys
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_keys$target
#> [1] "wk flu hosp rate change"
#> 
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_type
#> [1] "nominal"
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$description
#> [1] "This target represents the change in the rate of new hospitalizations per week comparing the week ending two days prior to the forecast_date to the week ending h weeks after the forecast_date."
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $rounds[[1]]$submissions_due
#> $rounds[[1]]$submissions_due$relative_to
#> [1] "forecast_date"
#> 
#> $rounds[[1]]$submissions_due$start
#> [1] -6
#> 
#> $rounds[[1]]$submissions_due$end
#> [1] 2
#> 
#> 
#> 
#> 
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
#> attr(,"type")
#> [1] "tasks"
#> attr(,"class")
#> [1] "config" "list"  
# Read config file from URL
url <- paste0(
  "https://raw.githubusercontent.com/hubverse-org/",
  "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
)
read_config_file(url)
#> $schema_version
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> 
#> $rounds
#> $rounds[[1]]
#> $rounds[[1]]$round_id_from_variable
#> [1] TRUE
#> 
#> $rounds[[1]]$round_id
#> [1] "origin_date"
#> 
#> $rounds[[1]]$model_tasks
#> $rounds[[1]]$model_tasks[[1]]
#> $rounds[[1]]$model_tasks[[1]]$task_ids
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2022-11-28" "2022-12-05" "2022-12-12"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
#> [1] "inc covid hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
#> NULL
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
#>  [1] -6 -5 -4 -3 -2 -1  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
#>  [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
#> [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
#> [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
#> [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$is_required
#> [1] FALSE
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
#> [1] "integer"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$is_required
#> [1] FALSE
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
#>  [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
#> [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$type
#> [1] "integer"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "inc covid hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Daily incident COVID hospitalizations"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "count"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
#> [1] "inc covid hosp"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$description
#> [1] "Daily newly reported hospitalizations where the patient has COVID, as reported by hospital facilities and aggregated in the HHS Protect data collection system."
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "day"
#> 
#> 
#> 
#> 
#> 
#> $rounds[[1]]$submissions_due
#> $rounds[[1]]$submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $rounds[[1]]$submissions_due$start
#> [1] -6
#> 
#> $rounds[[1]]$submissions_due$end
#> [1] 1
#> 
#> 
#> 
#> 
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"type")
#> [1] "tasks"
#> attr(,"class")
#> [1] "config" "list"  
# Read config file from AWS S3 bucket hub
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
config_path <- hub_path$path("hub-config/admin.json")
read_config_file(config_path)
#> ℹ Updating superseded URL `Infectious-Disease-Modeling-hubs` to `hubverse-org`
#> $schema_version
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json"
#> 
#> $name
#> [1] "Simple Forecast Hub"
#> 
#> $maintainer
#> [1] "Consortium of Infectious Disease Modeling Hubs"
#> 
#> $contact
#> $contact$name
#> [1] "Joe Bloggs"
#> 
#> $contact$email
#> [1] "j.bloggs@cidmh.com"
#> 
#> 
#> $repository_url
#> [1] "https://github.com/Infectious-Disease-Modeling-Hubs/example-simple-forecast-hub"
#> 
#> $hub_models
#> $hub_models[[1]]
#> $hub_models[[1]]$team_abbr
#> [1] "simple_hub"
#> 
#> $hub_models[[1]]$model_abbr
#> [1] "baseline"
#> 
#> $hub_models[[1]]$model_type
#> [1] "baseline"
#> 
#> 
#> 
#> $file_format
#> [1] "csv"     "parquet" "arrow"  
#> 
#> $timezone
#> [1] "US/Eastern"
#> 
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json"
#> attr(,"type")
#> [1] "admin"
#> attr(,"class")
#> [1] "config" "list"  
```
