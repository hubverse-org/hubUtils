# Is config file using v3.0.0 schema?

Is config file using v3.0.0 schema?

## Usage

``` r
is_v3_config_file(config_path)
```

## Arguments

- config_path:

  Either a character string of a path to a local JSON config file, a
  character string of the URL to the **raw contents** of a JSON config
  file (e.g on GitHub) or an object of class `<SubTreeFileSystem>`
  created using functions
  [`arrow::s3_bucket()`](https://arrow.apache.org/docs/r/reference/s3_bucket.html)
  and associated methods for creating paths to JSON config files within
  the bucket.

## Value

Logical, whether the config file is using v3.0.0 schema or greater.

## Examples

``` r
config_path <- system.file("config", "tasks.json", package = "hubUtils")
is_v3_config_file(config_path)
#> [1] TRUE
```
