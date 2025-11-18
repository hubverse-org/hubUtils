# Get the name of the output type id column based on the schema version

Version can be provided either directly through the `config_version`
argument or extracted from a `config_tasks` object.

## Usage

``` r
get_config_tid(config_version, config_tasks)
```

## Arguments

- config_version:

  Character string of the schema version.

- config_tasks:

  a list version of the content's of a hub's `tasks.json` config file,
  accessed through the `"config_tasks"` attribute of a
  `<hub_connection>` object or function
  [`read_config()`](https://hubverse-org.github.io/hubUtils/reference/read_config.md).

## Value

character string of the name of the output type id column

## Examples

``` r
get_config_tid("v3.0.0")
#> [1] "output_type_id"
get_config_tid("v2.0.0")
#> [1] "output_type_id"
# this will produce a warning because support for schema version 1.0.0
# has been dropped.
get_config_tid("v1.0.0")
#> Warning: Hub configured using schema version v1.0.0. Support for schema earlier than
#> v2.0.0 was deprecated in hubUtils 0.0.0.9010.
#> ℹ Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as
#>   soon as possible.
#> [1] "type_id"
```
