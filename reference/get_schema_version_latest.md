# Get the latest schema version

Get the latest schema version from the schema repository if "latest"
requested (default) or ignore if specific version provided.

## Usage

``` r
get_schema_version_latest(schema_version = "latest", branch = "main")
```

## Arguments

- schema_version:

  A character vector. Either "latest" or a valid schema version.

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`.

## Value

a schema version string. If `schema_version` is "latest", the latest
schema version from the schema repository. If specific version provided
to `schema_version`, the same version is returned.

## Examples

``` r
# Get the latest version of the schema
get_schema_version_latest()
#> [1] "v6.0.0"
get_schema_version_latest(schema_version = "v3.0.0")
#> [1] "v3.0.0"
```
