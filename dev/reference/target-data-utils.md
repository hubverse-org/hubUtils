# Get target data configuration properties

Utility functions for extracting properties from target-data.json
configuration files (v6.0.0 schema). These functions handle defaults and
inheritance patterns for target data configuration.

## Usage

``` r
get_date_col(config_target_data)

get_observable_unit(
  config_target_data,
  dataset = c("time-series", "oracle-output")
)

get_versioned(config_target_data, dataset = c("time-series", "oracle-output"))

get_has_output_type_ids(config_target_data)

get_non_task_id_schema(config_target_data)

has_target_data_config(hub_path)

# Default S3 method
has_target_data_config(hub_path)

# S3 method for class 'SubTreeFileSystem'
has_target_data_config(hub_path)
```

## Arguments

- config_target_data:

  A target-data config object created by
  `read_config(hub_path, "target-data")`.

- dataset:

  Character string specifying the dataset type: either `"time-series"`
  or `"oracle-output"`. Used for functions that extract dataset-specific
  properties.

- hub_path:

  Path to a hub. Can be a local directory path or cloud URL (S3, GCS).

## Value

`get_date_col()` returns a character string: the name of the date column
that stores the date on which observed data actually occurred.

`get_observable_unit()` returns a character vector: column names whose
unique value combinations define the minimum observable unit.

`get_versioned()` returns a logical value: whether the dataset is
versioned using `as_of` dates.

`get_has_output_type_ids()` returns a logical value: whether
oracle-output data has `output_type` and `output_type_id` columns
(default `FALSE` if not specified).

`get_non_task_id_schema()` returns a named list: key-value pairs of
non-task ID column names and their data types, or `NULL` if not
specified.

`has_target_data_config()` returns a logical value: `TRUE` if the
target-data.json file exists in the `hub-config` directory of the hub,
`FALSE` otherwise.

## Details

### Inheritance and Defaults

Some properties can be specified at both the global level and the
dataset level:

- **observable_unit**: Dataset-specific values override global when
  specified, otherwise the global value is used.

- **versioned**: Dataset-specific values override global when specified,
  otherwise inherits from global (default `FALSE` if not specified
  anywhere).

Other properties are dataset-specific only:

- **has_output_type_ids**: Only for oracle-output dataset (default
  `FALSE`)

- **non_task_id_schema**: Only for time-series dataset (default `NULL`)

## Functions

- `get_date_col()`: Get the name of the date column across hub data.

- `get_observable_unit()`: Get observable unit column names. Returns
  dataset-specific observable_unit if configured, otherwise falls back
  to global.

- `get_versioned()`: Get whether target data is versioned for the
  specified dataset. Returns dataset-specific setting if configured,
  otherwise inherits from global (default `FALSE` if not specified).

- `get_has_output_type_ids()`: Get whether oracle-output data has
  output_type/output_type_id columns.

- `get_non_task_id_schema()`: Get the schema for non-task ID columns in
  time-series data.

- `has_target_data_config()`: Check if target data config file exists in
  hub.

## Examples

``` r
hub_path <- system.file("testhubs/v6/target_dir", package = "hubUtils")
config <- read_config(hub_path, "target-data")

# Get the date column name
get_date_col(config)
#> [1] "target_end_date"

# Get observable unit (uses dataset-specific or falls back to global)
get_observable_unit(config, dataset = "time-series")
#> [1] "target_end_date" "target"          "location"       
get_observable_unit(config, dataset = "oracle-output")
#> [1] "target_end_date" "target"          "location"       

# Get versioned setting (inherits from global if not specified)
get_versioned(config, dataset = "time-series")
#> [1] FALSE

# Get oracle-output specific property
get_has_output_type_ids(config)
#> [1] TRUE

# Get time-series specific property
get_non_task_id_schema(config)
#> NULL

# Check if target data config exists
has_target_data_config(hub_path)
#> /home/runner/work/_temp/Library/hubUtils/testhubs/v6/target_dir/hub-config/target-data.json 
#>                                                                                        TRUE 
no_config_hub <- system.file("testhubs/v5/target_file/", package = "hubUtils")
has_target_data_config(no_config_hub)
#> /home/runner/work/_temp/Library/hubUtils/testhubs/v5/target_file/hub-config/target-data.json 
#>                                                                                        FALSE 
```
