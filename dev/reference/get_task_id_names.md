# Get hub task IDs

Get hub task IDs

## Usage

``` r
get_task_id_names(config_tasks)
```

## Arguments

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/dev/reference/read_config.md).

## Value

a character vector of all unique task ID names across all rounds.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
config_tasks <- read_config(hub_path, "tasks")
get_task_id_names(config_tasks)
#> [1] "origin_date" "target"      "horizon"     "location"    "age_group"  
```
