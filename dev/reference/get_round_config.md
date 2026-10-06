# Get the configuration of a given round

Get the configuration of a given round

## Usage

``` r
get_round_config(config_tasks, round_id, call = rlang::current_env())
```

## Arguments

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/dev/reference/read_config.md).

- round_id:

  Character string. Round identifier. If the round is set to
  `round_id_from_variable: true`, IDs are values of the task ID defined
  in the round's `round_id` property of `config_tasks`. Otherwise should
  match round's `round_id` value in config.

- call:

  The execution environment of the function to name in error and warning
  messages. By default, messages name this function. Supply another
  environment, such as a wrapper function's environment, to name that
  function instead.

## Value

a list representation of the round's element in the `rounds` property of
the tasks config.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_round_config(config_tasks, round_id = "2022-10-08")
#> $round_id_from_variable
#> [1] TRUE
#> 
#> $round_id
#> [1] "origin_date"
#> 
#> $model_tasks
#> $model_tasks[[1]]
#> $model_tasks[[1]]$task_ids
#> $model_tasks[[1]]$task_ids$origin_date
#> $model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2022-10-01" "2022-10-08"
#> 
#> 
#> $model_tasks[[1]]$task_ids$target
#> $model_tasks[[1]]$task_ids$target$required
#> [1] "wk inc flu hosp"
#> 
#> $model_tasks[[1]]$task_ids$target$optional
#> NULL
#> 
#> 
#> $model_tasks[[1]]$task_ids$horizon
#> $model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
#> 
#> $model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> $model_tasks[[1]]$task_ids$location
#> $model_tasks[[1]]$task_ids$location$required
#> NULL
#> 
#> $model_tasks[[1]]$task_ids$location$optional
#>  [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
#> [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
#> [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
#> [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
#> 
#> 
#> 
#> $model_tasks[[1]]$output_type
#> $model_tasks[[1]]$output_type$mean
#> $model_tasks[[1]]$output_type$mean$output_type_id
#> $model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> $model_tasks[[1]]$output_type$mean$output_type_id$optional
#> [1] NA
#> 
#> 
#> $model_tasks[[1]]$output_type$mean$value
#> $model_tasks[[1]]$output_type$mean$value$type
#> [1] "integer"
#> 
#> $model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> $model_tasks[[1]]$output_type$quantile
#> $model_tasks[[1]]$output_type$quantile$output_type_id
#> $model_tasks[[1]]$output_type$quantile$output_type_id$required
#>  [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
#> [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
#> 
#> $model_tasks[[1]]$output_type$quantile$output_type_id$optional
#> NULL
#> 
#> 
#> $model_tasks[[1]]$output_type$quantile$value
#> $model_tasks[[1]]$output_type$quantile$value$type
#> [1] "integer"
#> 
#> $model_tasks[[1]]$output_type$quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $model_tasks[[1]]$target_metadata
#> $model_tasks[[1]]$target_metadata[[1]]
#> $model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "wk inc flu hosp"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "count"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_keys
#> $model_tasks[[1]]$target_metadata[[1]]$target_keys$target
#> [1] "wk inc flu hosp"
#> 
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "continuous"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $submissions_due
#> $submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $submissions_due$start
#> [1] -6
#> 
#> $submissions_due$end
#> [1] 1
#> 
#> 
```
