# Get task ID names for a given round

Get task ID names for a given round

## Usage

``` r
get_round_task_id_names(config_tasks, round_id)
```

## Arguments

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/reference/read_config.md).

- round_id:

  Character string. Round identifier. If the round is set to
  `round_id_from_variable: true`, IDs are values of the task ID defined
  in the round's `round_id` property of `config_tasks`. Otherwise should
  match round's `round_id` value in config. Ignored if hub contains only
  a single round.

## Value

a character vector of task ID names

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_round_task_id_names(config_tasks, round_id = "2022-10-08")
#> [1] "origin_date" "target"      "horizon"     "location"   
get_round_task_id_names(config_tasks, round_id = "2022-10-15")
#> [1] "origin_date" "target"      "horizon"     "location"    "age_group"  
```
