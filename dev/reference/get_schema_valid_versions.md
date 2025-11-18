# Get a vector of valid schema version

Get a vector of valid schema version

## Usage

``` r
get_schema_valid_versions(branch = "main")
```

## Arguments

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`.

## Value

a character vector of valid versions of hubverse
[schema](https://github.com/hubverse-org/schemas).

## See also

Other functions supporting config file validation:
[`get_schema()`](https://hubverse-org.github.io/hubUtils/dev/reference/get_schema.md),
[`get_schema_url()`](https://hubverse-org.github.io/hubUtils/dev/reference/get_schema_url.md)

## Examples

``` r
get_schema_valid_versions()
#>  [1] "v0.0.0.9" "v0.0.1"   "v1.0.0"   "v2.0.0"   "v2.0.1"   "v3.0.0"  
#>  [7] "v3.0.1"   "v4.0.0"   "v5.0.0"   "v5.1.0"   "v6.0.0"  
```
