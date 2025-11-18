# Get hub config schema versions

Get hub config schema versions

## Usage

``` r
get_version_config(config)

get_version_file(config_path)

get_version_hub(hub_path, config_type = c("tasks", "admin", "target-data"))
```

## Arguments

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

- config_type:

  Character vector specifying the type of config file to read. One of
  "tasks", "admin" or "target-data". Default is "tasks".

## Value

The schema version number as a character string.

## Functions

- `get_version_config()`: Get schema version from config list
  representation.

- `get_version_file()`: Get schema version from config file at specific
  path.

- `get_version_hub()`: Get schema version from config file at specific
  path.

## Examples

``` r
config <- read_config_file(
  system.file("config", "tasks.json", package = "hubUtils")
)
get_version_config(config)
#> [1] "v3.0.0"
config_path <- system.file("config", "tasks.json", package = "hubUtils")
get_version_file(config_path)
#> [1] "v3.0.0"
# Get version from a URL of a hub config file
url <- paste0(
  "https://raw.githubusercontent.com/hubverse-org/",
  "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
)
get_version_file(url)
#> [1] "v6.0.0"
# Get version from an AWS S3 cloud hub config file
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
config_path <- hub_path$path("hub-config/admin.json")
get_version_file(config_path)
#> ℹ Updating superseded URL `Infectious-Disease-Modeling-hubs` to `hubverse-org`
#> [1] "v2.0.0"
hub_path <- system.file("testhubs/simple", package = "hubUtils")
get_version_hub(hub_path)
#> [1] "v2.0.0"
get_version_hub(hub_path, "admin")
#> [1] "v2.0.0"
# Get version from an AWS S3 cloud hub config file
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
get_version_hub(hub_path)
#> ℹ Updating superseded URL `Infectious-Disease-Modeling-hubs` to `hubverse-org`
#> [1] "v2.0.0"
```
