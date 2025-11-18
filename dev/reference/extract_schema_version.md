# Extract the schema version from a schema `id` or config `schema_version` property character string

Extract the schema version from a schema `id` or config `schema_version`
property character string

## Usage

``` r
extract_schema_version(id)
```

## Arguments

- id:

  A schema `id` or config `schema_version` property character string.

## Value

The schema version number as a character string.

## Examples

``` r
extract_schema_version("schema_version: v3.0.0")
#> [1] "v3.0.0"
extract_schema_version("refs/heads/main/v3.0.0")
#> [1] "v3.0.0"
```
