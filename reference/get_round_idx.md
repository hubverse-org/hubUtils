# Utilities for accessing round ID metadata

Utilities for accessing round ID metadata

## Usage

``` r
get_round_idx(config_tasks, round_id)

get_round_ids(
  config_tasks,
  flatten = c("all", "model_task", "task_id", "none")
)
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

- flatten:

  Character. Whether and how much to flatten output.

  - `"all"`: Complete flattening. Returns a character vector of unique
    round IDs across all rounds.

  - `"model_task"`: Flatten model tasks. Returns a list with an element
    for each round. Each round element contains a character vector of
    unique round IDs across all round model tasks. Only applicable if
    `round_id_from_variable` is `TRUE`.

  - `"task_id"`: Flatten task ID. Returns a nested list with an element
    for each round. Each round element contains a list with an element
    for each model task. Each model task element contains a character
    vector of unique round IDs. across `required` and `optional`
    properties. Only applicable if `round_id_from_variable` is `TRUE`

  - `"none"`: No flattening. If `round_id_from_variable` is `TRUE`,
    returns a nested list with an element for each round. Each round
    element contains a nested element for each model task. Each model
    task element contains a nested list of `required` and `optional`
    character vectors of round IDs. If `round_id_from_variable` is
    `FALSE`,a list with a round ID for each round is returned.

## Value

the integer index of the element in `config_tasks$rounds` that a
character round identifier maps to

a list or character vector of hub round IDs

- A character vector is returned only if `flatten = "all"`

- A list is returned otherwise (see `flatten` for more details)

## Functions

- `get_round_idx()`: Get an integer index of the element in
  `config_tasks$rounds` that a character round identifier maps to.

- `get_round_ids()`: Get a list or character vector of hub round IDs.
  For each round, if `round_id_from_variable` is `TRUE`, round IDs
  returned are the values of the task ID defined in the `round_id`
  property. Otherwise, if `round_id_from_variable` is `FALSE`, the value
  of the `round_id` property is returned.

## Examples

``` r
config_tasks <- read_config(
  hub_path = system.file("testhubs/simple", package = "hubUtils")
)
# Get round IDs
get_round_ids(config_tasks)
#> [1] "2022-10-01" "2022-10-08" "2022-10-15" "2022-10-22" "2022-10-29"
get_round_ids(config_tasks, flatten = "model_task")
#> [[1]]
#> [1] "2022-10-01" "2022-10-08"
#> 
#> [[2]]
#> [1] "2022-10-15" "2022-10-22" "2022-10-29"
#> 
get_round_ids(config_tasks, flatten = "task_id")
#> [[1]]
#> [[1]][[1]]
#> [1] "2022-10-01" "2022-10-08"
#> 
#> 
#> [[2]]
#> [[2]][[1]]
#> [1] "2022-10-15" "2022-10-22" "2022-10-29"
#> 
#> 
get_round_ids(config_tasks, flatten = "none")
#> [[1]]
#> [[1]][[1]]
#> [[1]][[1]]$required
#> NULL
#> 
#> [[1]][[1]]$optional
#> [1] "2022-10-01" "2022-10-08"
#> 
#> 
#> 
#> [[2]]
#> [[2]][[1]]
#> [[2]][[1]]$required
#> NULL
#> 
#> [[2]][[1]]$optional
#> [1] "2022-10-15" "2022-10-22" "2022-10-29"
#> 
#> 
#> 
# Get round integer index using a round_id
get_round_idx(config_tasks, "2022-10-01")
#> [1] 1
get_round_idx(config_tasks, "2022-10-29")
#> [1] 2
```
