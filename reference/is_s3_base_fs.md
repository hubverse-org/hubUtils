# Detect whether An object of class `<SubTreeFileSystem>` represents the base path of an S3 file system (i.e. the root of a cloud hub)

Detect whether An object of class `<SubTreeFileSystem>` represents the
base path of an S3 file system (i.e. the root of a cloud hub)

## Usage

``` r
is_s3_base_fs(s3_fs)
```

## Arguments

- s3_fs:

  An object of class `<SubTreeFileSystem>`.

## Value

Logical. `TRUE` if the object represents the base path of an S3 file,
`FALSE` otherwise.

## Examples

``` r
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
config_path <- hub_path$path("hub-config/admin.json")
is_s3_base_fs(hub_path)
#> [1] TRUE
is_s3_base_fs(config_path)
#> [1] FALSE
```
