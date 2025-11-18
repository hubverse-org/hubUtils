# Is config list representation using v3.0.0 schema?

Is config list representation using v3.0.0 schema?

## Usage

``` r
is_v3_config(config)
```

## Arguments

- config:

  List representation of the JSON config file.

## Value

Logical, whether the config list representation is using v3.0.0 schema
or greater.

## Examples

``` r
config <- read_config_file(
  system.file("config", "tasks.json", package = "hubUtils")
)
is_v3_config(config)
#> [1] TRUE
```
