# Is hub configured using v3.0.0 schema?

Is hub configured using v3.0.0 schema?

## Usage

``` r
is_v3_hub(hub_path, config = c("tasks", "admin", "target-data"))
```

## Arguments

- hub_path:

  Either a character string path to a local Modeling Hub directory, a
  character string of a URL to a GitHub repository or an object of class
  `<SubTreeFileSystem>` created using functions
  [`arrow::s3_bucket()`](https://arrow.apache.org/docs/r/reference/s3_bucket.html)
  or
  [`arrow::gs_bucket()`](https://arrow.apache.org/docs/r/reference/gs_bucket.html)
  by providing a string S3 or GCS bucket name or path to a Modeling Hub
  directory stored in the cloud. For more details consult the [Using
  cloud storage (S3,
  GCS)](https://arrow.apache.org/docs/r/articles/fs.html) in the `arrow`
  package.

- config:

  Type of config file to read. One of `"tasks"`, `"admin"` or
  `"model-metadata-schema"`. Default is `"tasks"`.

## Value

Logical, whether the hub is configured using v3.0.0 schema or greater.

## Examples

``` r
is_v3_hub(hub_path = system.file("testhubs", "flusight", package = "hubUtils"))
#> [1] FALSE
```
