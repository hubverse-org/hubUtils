# Get the JSON schema download URL for a given config file version

Get the JSON schema download URL for a given config file version

## Usage

``` r
get_schema_url(
  config = c("tasks", "admin", "model", "target-data"),
  version,
  branch = "main"
)
```

## Arguments

- config:

  Name of config file to validate. One of `"tasks"`, `"admin"`,
  `"model"` or `"target-data"`.

- version:

  A valid version of hubverse
  [schema](https://github.com/hubverse-org/schemas) (e.g. `"v0.0.1"`).

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`.

## Value

The JSON schema download URL for a given config file version.

## See also

Other functions supporting config file validation:
[`get_schema()`](https://hubverse-org.github.io/hubUtils/reference/get_schema.md),
[`get_schema_valid_versions()`](https://hubverse-org.github.io/hubUtils/reference/get_schema_valid_versions.md)

## Examples

``` r
get_schema_url(config = "tasks", version = "v0.0.0.9")
#> https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json
```
