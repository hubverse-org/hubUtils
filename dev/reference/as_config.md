# Coerce a config list to a config class object

Coerce a config list to a config class object

## Usage

``` r
as_config(x)
```

## Arguments

- x:

  a list representation of the contents a `tasks.json` config file.

## Value

a config list object with subclass `<config>`.

## Examples

``` r
config_tasks <- read_config(
  hub_path = system.file("testhubs/simple", package = "hubUtils")
)
# Remove all attributes except names to demonstrate functionality
attributes(config_tasks) <- attributes(config_tasks)[
  names(attributes(config_tasks)) == "names"
]
# Convert to config object
as_config(config_tasks)
#> $schema_version
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"
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
#> [1] "2022-10-01" "2022-10-08"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
#> [1] "wk inc flu hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
#> NULL
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
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
#> [1] "integer"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
#>  [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
#> [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
#> NULL
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
#> [1] "wk inc flu hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "count"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
#> [1] "wk inc flu hosp"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "continuous"
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
#> $rounds[[2]]
#> $rounds[[2]]$round_id_from_variable
#> [1] TRUE
#> 
#> $rounds[[2]]$round_id
#> [1] "origin_date"
#> 
#> $rounds[[2]]$model_tasks
#> $rounds[[2]]$model_tasks[[1]]
#> $rounds[[2]]$model_tasks[[1]]$task_ids
#> $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date
#> $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2022-10-15" "2022-10-22" "2022-10-29"
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$target
#> $rounds[[2]]$model_tasks[[1]]$task_ids$target$required
#> [1] "wk inc flu hosp"
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$target$optional
#> NULL
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$location
#> $rounds[[2]]$model_tasks[[1]]$task_ids$location$required
#> NULL
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$location$optional
#>  [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
#> [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
#> [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
#> [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$age_group
#> $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$required
#> [1] "65+"
#> 
#> $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$optional
#> [1] "0-5"   "6-18"  "19-24" "25-64"
#> 
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
#> [1] NA
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$value
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$type
#> [1] "integer"
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
#>  [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
#> [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
#> NULL
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$type
#> [1] "integer"
#> 
#> $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "wk inc flu hosp"
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "count"
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
#> [1] "wk inc flu hosp"
#> 
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "continuous"
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $rounds[[2]]$submissions_due
#> $rounds[[2]]$submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $rounds[[2]]$submissions_due$start
#> [1] -6
#> 
#> $rounds[[2]]$submissions_due$end
#> [1] 1
#> 
#> 
#> 
#> 
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"
#> attr(,"type")
#> [1] "tasks"
#> attr(,"class")
#> [1] "config" "list"  
```
