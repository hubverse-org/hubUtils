# Get the values each modeling task in a round allows

Reads a round of a `tasks.json` config into one list per modeling task.
Each list holds the values that modeling task allows in each task ID
column and, for each output type, in the `output_type_id` column:

## Usage

``` r
get_round_value_sets_config(
  config_tasks,
  round_id,
  required_vals_only = FALSE,
  force_output_types = FALSE,
  output_types = NULL,
  derived_task_ids = NULL,
  call = rlang::current_env()
)
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
  match round's `round_id` value in config. Ignored if hub contains only
  a single round.

- required_vals_only:

  Logical. Whether to return only required values.

- force_output_types:

  Logical. Whether to treat all output types as required, regardless of
  their `is_required` setting. Only affects the result when
  `required_vals_only = TRUE`.

- output_types:

  Character vector of output type names to include. If `NULL`, all
  output types in the round are included.

- derived_task_ids:

  Character vector of derived task ID names (task IDs whose values
  depend on other task IDs). Their values are returned as `NA`.

- call:

  The execution environment of the function to name in errors and
  warnings about invalid `output_types` or `derived_task_ids`. Defaults
  to the environment of `get_round_value_sets_config()`.

## Value

A list with one element per modeling task in the round. Each element is
a list of two:

- `task_ids`: a named list with a vector of allowed values for each task
  ID in the round.

- `output_type_ids`: a named list with a vector of allowed output type
  ID values for each output type in the modeling task. An output type
  with no `required` values is left out when
  `required_vals_only = TRUE`.

## Details

    [[1]]
      $task_ids
        $target   "wk flu hosp rate category"
        $horizon  0 1 2 3
        $location "US" "01" "02" ...
      $output_type_ids
        $pmf      "low" "moderate" "high" ...

The values are read from the config as follows:

- `required` and `optional` values are combined into one vector,
  `required` values first. With `required_vals_only = TRUE`, only
  `required` values are kept.

- A task ID a modeling task does not use is either listed as `null` or
  left out of that modeling task. Both are returned as `NA`, the value
  model output holds in that column. So are task IDs that have no
  `required` values when `required_vals_only = TRUE`, and derived task
  IDs.

- In a round with `round_id_from_variable: true`, the task ID holding
  round IDs is set to `round_id`.

- Output type IDs are read the same way for every schema version. From
  schema v4.0.0 onwards, an output type's `is_required` setting
  determines whether its output type IDs are required. Output types with
  no output type ID values are returned as `NA`. For `mean` and
  `median`, `NA` is the only valid value. For `sample`, `NA` stands in
  for sample IDs, which the config does not list.

Values keep the type they have in the config.

## Examples

``` r
hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
config_tasks <- read_config(hub_path)
get_round_value_sets_config(config_tasks, round_id = "2022-10-22")
#> [[1]]
#> [[1]]$task_ids
#> [[1]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[1]]$task_ids$target
#> [1] "flu_hosp_rate_cat"
#> 
#> [[1]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[1]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[1]]$task_ids$target_end_date
#>  [1] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" "2022-11-19"
#>  [6] "2022-11-26" "2022-12-03" "2022-12-10" "2022-12-17" "2022-12-24"
#> [11] "2022-12-31" "2023-01-07" "2023-01-14"
#> 
#> 
#> [[1]]$output_type_ids
#> [[1]]$output_type_ids$pmf
#> [1] "low"       "moderate"  "high"      "very high"
#> 
#> 
#> 
#> [[2]]
#> [[2]]$task_ids
#> [[2]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[2]]$task_ids$target
#> [1] "flu_hosp_rate"
#> 
#> [[2]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[2]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[2]]$task_ids$target_end_date
#>  [1] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" "2022-11-19"
#>  [6] "2022-11-26" "2022-12-03" "2022-12-10" "2022-12-17" "2022-12-24"
#> [11] "2022-12-31" "2023-01-07" "2023-01-14"
#> 
#> 
#> [[2]]$output_type_ids
#> [[2]]$output_type_ids$cdf
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12
#> 
#> 
#> 
#> [[3]]
#> [[3]]$task_ids
#> [[3]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[3]]$task_ids$target
#> [1] "flu_hosp_inc"
#> 
#> [[3]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[3]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[3]]$task_ids$target_end_date
#>  [1] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" "2022-11-19"
#>  [6] "2022-11-26" "2022-12-03" "2022-12-10" "2022-12-17" "2022-12-24"
#> [11] "2022-12-31" "2023-01-07" "2023-01-14"
#> 
#> 
#> [[3]]$output_type_ids
#> [[3]]$output_type_ids$quantile
#>  [1] 0.025 0.100 0.200 0.300 0.400 0.500 0.600 0.700 0.800 0.900 0.975
#> 
#> [[3]]$output_type_ids$sample
#> [1] NA
#> 
#> [[3]]$output_type_ids$mean
#> [1] NA
#> 
#> 
#> 
# Set derived task IDs to NA
get_round_value_sets_config(
  config_tasks,
  round_id = "2022-10-22",
  derived_task_ids = "target_end_date"
)
#> [[1]]
#> [[1]]$task_ids
#> [[1]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[1]]$task_ids$target
#> [1] "flu_hosp_rate_cat"
#> 
#> [[1]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[1]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[1]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[1]]$output_type_ids
#> [[1]]$output_type_ids$pmf
#> [1] "low"       "moderate"  "high"      "very high"
#> 
#> 
#> 
#> [[2]]
#> [[2]]$task_ids
#> [[2]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[2]]$task_ids$target
#> [1] "flu_hosp_rate"
#> 
#> [[2]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[2]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[2]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[2]]$output_type_ids
#> [[2]]$output_type_ids$cdf
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12
#> 
#> 
#> 
#> [[3]]
#> [[3]]$task_ids
#> [[3]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[3]]$task_ids$target
#> [1] "flu_hosp_inc"
#> 
#> [[3]]$task_ids$horizon
#> [1] 1 2
#> 
#> [[3]]$task_ids$location
#> [1] "US" "01" "02"
#> 
#> [[3]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[3]]$output_type_ids
#> [[3]]$output_type_ids$quantile
#>  [1] 0.025 0.100 0.200 0.300 0.400 0.500 0.600 0.700 0.800 0.900 0.975
#> 
#> [[3]]$output_type_ids$sample
#> [1] NA
#> 
#> [[3]]$output_type_ids$mean
#> [1] NA
#> 
#> 
#> 
# Required values of a single output type only
get_round_value_sets_config(
  config_tasks,
  round_id = "2022-10-22",
  required_vals_only = TRUE,
  output_types = "pmf"
)
#> [[1]]
#> [[1]]$task_ids
#> [[1]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[1]]$task_ids$target
#> [1] NA
#> 
#> [[1]]$task_ids$horizon
#> [1] NA
#> 
#> [[1]]$task_ids$location
#> [1] NA
#> 
#> [[1]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[1]]$output_type_ids
#> [[1]]$output_type_ids$pmf
#> [1] "low"       "moderate"  "high"      "very high"
#> 
#> 
#> 
#> [[2]]
#> [[2]]$task_ids
#> [[2]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[2]]$task_ids$target
#> [1] NA
#> 
#> [[2]]$task_ids$horizon
#> [1] NA
#> 
#> [[2]]$task_ids$location
#> [1] NA
#> 
#> [[2]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[2]]$output_type_ids
#> named list()
#> 
#> 
#> [[3]]
#> [[3]]$task_ids
#> [[3]]$task_ids$reference_date
#> [1] "2022-10-22"
#> 
#> [[3]]$task_ids$target
#> [1] NA
#> 
#> [[3]]$task_ids$horizon
#> [1] NA
#> 
#> [[3]]$task_ids$location
#> [1] NA
#> 
#> [[3]]$task_ids$target_end_date
#> [1] NA
#> 
#> 
#> [[3]]$output_type_ids
#> named list()
#> 
#> 
```
