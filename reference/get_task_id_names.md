# Get hub task IDs

Get hub task IDs

## Usage

``` r
get_task_id_names(config_tasks, call = rlang::current_env())
```

## Arguments

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/reference/read_config.md).

- call:

  The execution environment of the function to name in error and warning
  messages. By default, messages name this function. Supply another
  environment, such as a wrapper function's environment, to name that
  function instead.

## Value

a character vector of all unique task ID names across all model tasks of
all rounds.

## See also

[`get_round_task_id_names()`](https://hubverse-org.github.io/hubUtils/reference/get_round_task_id_names.md)
for the task ID names of a single round.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_task_id_names(config_tasks)
#> [1] "origin_date" "target"      "horizon"     "location"    "age_group"  
```
