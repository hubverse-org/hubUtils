# Get the data type of a task ID

The data type is the simplest R type that represents every value the
task ID takes in the config. Character values that are all ISO 8601
dates (`YYYY-MM-DD`) are reported as `"Date"`.

## Usage

``` r
get_task_id_type(
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
  [`read_config()`](https://hubverse-org.github.io/hubUtils/reference/read_config.md).

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

a character string, one of `"character"`, `"double"`, `"integer"`,
`"logical"` or `"Date"`. `NA` if the task ID's `required` and `optional`
values are both `null` in every modeling task in scope, so the config
declares no type for it there.

## See also

[`get_task_id_values()`](https://hubverse-org.github.io/hubUtils/reference/get_task_id_values.md)
for the values the type is derived from.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_task_id_type(config_tasks, "origin_date")
#> [1] "Date"
get_task_id_type(config_tasks, "horizon")
#> [1] "integer"
get_task_id_type(config_tasks, "location")
#> [1] "character"
```
