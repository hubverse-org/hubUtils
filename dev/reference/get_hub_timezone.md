# Get hub configuration fields

Get hub configuration fields

## Usage

``` r
get_hub_timezone(hub_path)

get_hub_model_output_dir(hub_path)

get_hub_file_formats(hub_path, round_id = NULL)

get_hub_derived_task_ids(hub_path, round_id = NULL)
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

- round_id:

  Character string. Round identifier. If the round is set to
  `round_id_from_variable: true`, IDs are values of the task ID defined
  in the round's `round_id` property of `config_tasks`. Otherwise should
  match round's `round_id` value in config. Ignored if hub contains only
  a single round.

## Value

- `get_hub_timezone`: The timezone of the hub

&nbsp;

- `get_hub_model_output_dir`: The model output directory name

&nbsp;

- `get_hub_file_formats`: character vector accepted hub or round level
  file formats. If `round_id` is `NULL` or the round does not have a
  round level `file_format` setting, returns the hub level `file_format`
  setting.

&nbsp;

- `get_hub_derived_task_ids`: character vector of hub or round level
  derived task ID names. If `round_id` is `NULL` or the round does not
  have a round level `derived_tasks_ids` setting, returns the hub level
  `derived_tasks_ids` setting.

## Functions

- `get_hub_timezone()`: Get the hub timezone

- `get_hub_model_output_dir()`: Get the model output directory name

- `get_hub_file_formats()`: Get the hub or round level file formats

- `get_hub_derived_task_ids()`: Get the hub or round level
  `derived_tasks_ids`

## Examples

``` r
hub_path <- system.file("testhubs", "flusight", package = "hubUtils")
get_hub_timezone(hub_path)
#> [1] "US/Eastern"
get_hub_model_output_dir(hub_path)
#> [1] "forecasts"
get_hub_file_formats(hub_path)
#> [1] "csv"     "parquet" "arrow"  
get_hub_file_formats(hub_path, "2022-12-12")
#> [1] "csv"     "parquet" "arrow"  
```
