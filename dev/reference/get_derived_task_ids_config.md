# Get hub or round level derived task IDs

`get_config_derived_task_ids()` is an alias of
`get_derived_task_ids_config()`.

## Usage

``` r
get_derived_task_ids_config(config_tasks, round_id = NULL)

get_config_derived_task_ids(config_tasks, round_id = NULL)
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

## Value

a character vector of hub or round level derived task ID names. If
`round_id` is `NULL` or the round does not have a round level
`derived_task_ids` setting, returns the hub level `derived_task_ids`
setting.

## See also

[`get_hub_derived_task_ids()`](https://hubverse-org.github.io/hubUtils/dev/reference/get_hub_timezone.md)
to get derived task IDs from a hub path.

## Examples

``` r
hub_path <- system.file("testhubs/v4/flusight", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_derived_task_ids_config(config_tasks)
#> [1] "target_date"
get_derived_task_ids_config(config_tasks, round_id = "2023-05-08")
#> [1] "target_date"
```
