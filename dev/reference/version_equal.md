# Compare hub config `schema_version`s to specific version numbers from a variety of sources

Compare hub config `schema_version`s to specific version numbers from a
variety of sources

## Usage

``` r
version_equal(
  version,
  config = NULL,
  config_path = NULL,
  hub_path = NULL,
  schema_version = NULL
)

version_gte(
  version,
  config = NULL,
  config_path = NULL,
  hub_path = NULL,
  schema_version = NULL
)

version_gt(
  version,
  config = NULL,
  config_path = NULL,
  hub_path = NULL,
  schema_version = NULL
)

version_lte(
  version,
  config = NULL,
  config_path = NULL,
  hub_path = NULL,
  schema_version = NULL
)

version_lt(
  version,
  config = NULL,
  config_path = NULL,
  hub_path = NULL,
  schema_version = NULL
)
```

## Arguments

- version:

  Character string. Version number to compare against, must be in the
  format `"v#.#.#"`.

- config:

  A `<config>` class object. Usually the output of `read_config` or
  `read_config_file`.

- config_path:

  Either a character string of a path to a local JSON config file, a
  character string of the URL to the **raw contents** of a JSON config
  file (e.g on GitHub) or an object of class `<SubTreeFileSystem>`
  created using functions
  [`arrow::s3_bucket()`](https://arrow.apache.org/docs/r/reference/s3_bucket.html)
  and associated methods for creating paths to JSON config files within
  the bucket.

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

- schema_version:

  Character string. A config `schema_version` property to compare
  against.

## Value

`TRUE` or `FALSE` depending on how the schema version compares to the
version number specified.

## Functions

- `version_equal()`: Check whether a schema version property is equal to
  a specific version number.

- `version_gte()`: Check whether a schema version property is equal to
  or greater than a specific version number.

- `version_gt()`: Check whether a schema version property is greater
  than a specific version number.

- `version_lte()`: Check whether a schema version property is equal to
  or less than a specific version number.

- `version_lt()`: Check whether a schema version property is less than a
  specific version number.

## Examples

``` r
# Actual version "v2.0.0"
hub_path <- system.file("testhubs/simple", package = "hubUtils")
# Actual version "v3.0.0"
config_path <- system.file("config", "tasks.json", package = "hubUtils")
config <- read_config_file(config_path)
schema_version <- config$schema_version
# Check whether schema_version equal to v3.0.0
version_equal("v3.0.0", config = config)
#> [1] TRUE
version_equal("v3.0.0", config_path = config_path)
#> [1] TRUE
version_equal("v3.0.0", hub_path = hub_path)
#> [1] FALSE
version_equal("v3.0.0", schema_version = schema_version)
#> [1] TRUE
# Check whether schema_version equal to or greater than v3.0.0
version_gte("v3.0.0", config = config)
#> [1] TRUE
version_gte("v3.0.0", config_path = config_path)
#> [1] TRUE
version_gte("v3.0.0", hub_path = hub_path)
#> [1] FALSE
version_gte("v3.0.0", schema_version = schema_version)
#> [1] TRUE
# Check whether schema_version greater than v3.0.0
version_gt("v3.0.0", config = config)
#> [1] FALSE
version_gt("v3.0.0", config_path = config_path)
#> [1] FALSE
version_gt("v3.0.0", hub_path = hub_path)
#> [1] FALSE
version_gt("v3.0.0", schema_version = schema_version)
#> [1] FALSE
# Check whether schema_version equal to or less than v3.0.0
version_lte("v3.0.0", config = config)
#> [1] TRUE
version_lte("v3.0.0", config_path = config_path)
#> [1] TRUE
version_lte("v3.0.0", hub_path = hub_path)
#> [1] TRUE
version_lte("v3.0.0", schema_version = schema_version)
#> [1] TRUE
# Check whether schema_version less than v3.0.0
version_lt("v3.0.0", config = config)
#> [1] FALSE
version_lt("v3.0.0", config_path = config_path)
#> [1] FALSE
version_lt("v3.0.0", hub_path = hub_path)
#> [1] TRUE
version_lt("v3.0.0", schema_version = schema_version)
#> [1] FALSE
```
