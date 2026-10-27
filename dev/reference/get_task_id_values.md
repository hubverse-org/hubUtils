# Get the values a task ID takes

Collects the `required` and `optional` values of a task ID from every
modeling task in the config, or in one round.

## Usage

``` r
get_task_id_values(
  config_tasks,
  task_id_name,
  round_id = NULL,
  call = rlang::current_env()
)
```

## Arguments

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/dev/reference/read_config.md).

- task_id_name:

  character string. The name of a task ID.

- round_id:

  character string. Round identifier. If `NULL`, the default, values are
  collected across all rounds.

- call:

  The execution environment of the function to name in error and warning
  messages. By default, messages name this function. Supply another
  environment, such as a wrapper function's environment, to name that
  function instead.

## Value

a vector of the unique values the task ID takes, with the type the
values were read from the config as. Dates are character strings. `NULL`
if the task ID's `required` and `optional` values are both `null` in
every modeling task in scope.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_task_id_values(config_tasks, "origin_date")
#> [1] "2022-10-01" "2022-10-08" "2022-10-15" "2022-10-22" "2022-10-29"
get_task_id_values(config_tasks, "origin_date", round_id = "2022-10-01")
#> [1] "2022-10-01" "2022-10-08"
get_task_id_values(config_tasks, "horizon")
#> [1] 1 2 3 4
```
