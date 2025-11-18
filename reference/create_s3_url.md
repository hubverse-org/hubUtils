# Create a URL to a file in an S3 bucket

Create a URL to a file in an S3 bucket

## Usage

``` r
create_s3_url(base_fs, base_path)
```

## Arguments

- base_fs:

  character string. Path of the base s3 file system (bucket) in the
  cloud. Can be extracted from the object of class `<SubTreeFileSystem>`
  using the `$base_fs` field, followed by the `$base_path`.

- base_path:

  character string. Path to the file in relation to `base_fs`. Can be
  extracted from the object of class `<SubTreeFileSystem>` using the
  `$base_path`.

## Value

A character string of the URL to the file in s3.

## Examples

``` r
create_s3_url(
  base_fs = "hubverse/hubutils/testhubs/simple/",
  base_path = "hub-config/admin.json"
)
#> https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json
# Create a URL from an object of class `<SubTreeFileSystem>` of an s3 hub
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
create_s3_url(hub_path$base_path, "hub-config/admin.json")
#> https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json
config_path <- hub_path$path("hub-config/admin.json")
# Create a URL from an object of class `<SubTreeFileSystem>` of the path to
# a config file in an s3 hub
create_s3_url(config_path$base_fs$base_path, config_path$base_path)
#> https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json
```
