# Get output type names for a given round

Get output type names for a given round

## Usage

``` r
get_round_output_type_names(
  config_tasks,
  round_id,
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
  match round's `round_id` value in config.

- call:

  The execution environment of the function to name in error and warning
  messages. By default, messages name this function. Supply another
  environment, such as a wrapper function's environment, to name that
  function instead.

## Value

a character vector of output type names

## Examples

``` r
hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_round_output_type_names(config_tasks, round_id = "2022-10-22")
#> [1] "pmf"      "cdf"      "quantile" "sample"   "mean"    
```
