# hubUtils (development version)

# hubUtils 0.6.0

* Added `convert_output_type()` function to convert model outputs from one output type to another (currently only supports sample to mean, median, and quantile) (#212, #214, #215)
* `convert_output_type()` now supports transformations involving output type IDs dependent on task ID variable values (#222)
* Added last schema version (v5.1.0)

# hubUtils 0.5.0

* `read_config_file` now accepts a URL to the **raw contents** of a JSON config file as well as an object of class `<SubTreeFileSystem>` pointing to a config file in an S3 cloud hub  (#209). This enables reading config files directly from GitHub S3 cloud hubs without having to clone the contents of a hub locally.   
* `read_config` now also accepts a URL to of a fully configured hub repository hosted on GitHub.
* Added utilities for working with URLs:
  - `is_url()`: checks whether a character string is a URL.
  - `is_valid_url()`: checks whether a URL is valid and reachable.
  - `is_github_url()`: checks whether a URL is a `github.com` URL.
  - `is_github_repo_url()`: checks whether a URL is a GitHub repository URL.
  - `create_s3_url()`: creates an S3 URL from a bucket name and object path.
  - `is_s3_base_fs()`: checks whether an object of class `<SubTreeFileSystem>` is a base file system (i.e. the root of a cloud hub).

# hubUtils 0.4.0

* Released schemas are now shipped with the package, so an internet connection
  is no longer necessary for local validation. Released versions of `hubUtils` will always only contain released versions of schemas while dev versions from `hubUtils` (installed from GitHub) may contain versions of schema under active development.
* Added `subset_task_id_names()` function to subset task ID names from a character vector of column names (#149).
* Added functions `subset_task_id_cols()` and `subset_std_cols()` to subset a `model_out_tbl` or submission `tbl` to task ID or standard (non-task ID) columns respectively (#149).

# hubUtils 0.3.0

* `schema_id` version checks silenced by default in `read_config()` and `read_config_file()`.  
* Add and export `hubValidations` functions `get_hub_timezone()`, `get_hub_model_output_dir()` and `get_hub_file_formats()`  for extracting hub metadata to `hubUtils` package.
* Add new function `get_hub_derived_task_ids()` to extract round or hub level derived task ID values from a `tasks.json` config file.

# hubUtils 0.2.0

* Add family of functions for extracting the version number from a variety of sources:
  - `get_version_config()`: extract version from a `<config>` class object.
  - `get_version_config_file()`: extract version from a config file by specifying a `config_path`.
  - `get_version_hub()`: extract version from a config file by specifying a `hub_path`.
* Add family of functions for comparing the version number extracted from a variety of sources to a given version number (#171):
  - `version_equal()`: Check whether a schema version property is equal to.
  - `version_gte()`: Check whether a schema version property is equal to or greater than.
  - `version_gt()`: Check whether a schema version property is greater than.
  - `version_lte()`: Check whether a schema version property is equal to or less than.
  - `version_lt()`: Check whether a schema version property is less than.
* `<config>` class objects now have a `type` attribute to track what type of config they contain (i.e `"tasks"` or `"admin"`).
* `read_config()` and `read_config_file()` will attempt to coerce their output a `<config>` class object, with a warning if unsuccessful (#173).
* Add `as_config()` function to coerce a config list to a `<config>` class object (from the `hubAdmin` package) (#173).
* Fix bug in `extract_schema_version()` where only single digits from each version component were being extracted.
* Fix documentation for `get_schema_version_latest()` to no longer use `v1.0.0`

# hubUtils 0.1.7

* First submission to CRAN
* Removed `hubData` dependency

# hubUtils 0.1.2

* Bug fix: Corrected bug in v3 config utilities so that configs are detected as `v3` if they are `v3.0.0` or above, not just `v3.0.0`. Thanks to @M-7th for reporting.

# hubUtils 0.1.1

* Remove `hubAdmin` Suggests dependency by moving test hub configuration validation to CI
  (resolved: @annakrystalli, https://github.com/hubverse-org/hubUtils/issues/158)


# hubUtils 0.1.0

* Add `read_config_file()` helper function to read a JSON config file from a file path.
* Add `extract_schema_version()` helper function to extract the schema version from a schema `id` or config `schema_version` property character string.
* Add helpers `is_v3_config`, `is_v3_config_file` and `is_v3_config_hub` to check whether a config object, file or hub is using schema version 3.

# hubUtils 0.0.2

* Missing dependency (`jsonlite`) bug fix.

# hubUtils 0.0.1 MAJOR RELEASE

* First **major release of `hubUtils` package** containing significant breaking changes. Much of the package has been moved and split across two smaller and more dedicated packages:
  - **`hubData` package**: contains functions for connecting to and interacting with hub data. 
    * Exported functions moved to `hubData`: `connect_hub()`, `connect_model_output()`, `expand_model_out_val_grid()`, `create_model_out_submit_tmpl()`, `coerce_to_character()`, `coerce_to_hub_schema()` and `create_hub_schema()`.
    * `hubUtils` functions re-exported to `hubData`: `as_model_out_tbl()`, `validate_model_out_tbl()`, `model_id_split()` and `model_id_merge()`.
  - **`hubAdmin` package**: contains functions for administering Hubs, in particular creating and validating hub configuration files. Exported functions moved to `hubAdmin`: 
    * Functions for creating config files: `create_config()`, `create_model_task()`, `create_model_tasks()`, `create_output_type()`, `create_output_type_cdf()`, `create_output_type_mean()`, `create_output_type_median()`, `create_output_type_pmf()`, `create_output_type_quantile()`, `create_output_type_sample()`, `create_round()`, `create_rounds()`, `create_target_metadata()`, `create_target_metadata_item()`, `create_task_id()`, `create_task_ids()`.
    * Functions for validating config files: `validate_config()`,`validate_model_metadata_schema()`, `validate_hub_config()`, `view_config_val_errors()`.

# hubUtils 0.0.0.9019

* Minor internal bug fixes and documentation updates.

# hubUtils 0.0.0.9018

* Added US and European location datasets. These can be used e.g. when assigning location task ID values for `tasks.json` config files programmatically (#127).

# hubUtils 0.0.0.9017

* `connect_hub()` and `connect_model_output()` now identify and report on files that are present and should have been opened but for which a connection was not successful (#124)
* Introduced a number of minor documentation clarifications and bug fixes (#129, #128, #121, #130)

# hubUtils 0.0.0.9016

* Added `validate_model_metadata_schema()` function and included it as part of `validate_hub_config()` (#110 & #112).

# hubUtils 0.0.0.9015

* Added `load_model_metadata()` function to compile hub model metadata.

# hubUtils 0.0.0.9014

* Added `coerce_to_character()` function for coercing all model output columns to character. This can be much faster than coercing to `coerce_to_hub_schema()`, especially for dates.
* Added the following parameters to `expand_model_out_val_grid()`:
  - `all_character`: allow for returning all character columns.
  - `as_arrow_table`: allow for returning an arrow data table.
  - `bind_model_tasks`: allow for returning list of model task level grids.
* Bug fix. Handle situation in `expand_model_out_val_grid()` when `required_vals_only = TRUE` yet required task ID columns are not consistent across modeling tasks. The function now pads missing task ID column values with `NA`s.

# hubUtils 0.0.0.9013

* Introduced `coerce_to_hub_schema()` function and applied it to `create_model_out_submit_tmpl()` & `expand_model_out_val_grid()` to ensure column data types in returned tibbles are consistent with the hub's schema (#100).
* Fixed bug where optional `mean`/`median` output types where being included erroneously when `required_vals_only = TRUE`.
* Exported function `get_round_task_id_names()` (#99).
* Memoized function `read_config()` (#101).


# hubUtils 0.0.0.9012

* Fixed bug (#95 & #97) which was causing `connect_hub()` to error when `"csv"` was an accepted hub file format but there were no CSV in the model output directory. Now `connect_hub()` checks for the presence of files of each accepted file format and only opens datasets for file formats of which files exists. If there are no files of any accepted file_format in the model output directory, the S3 `hub_connection` object returned consists of an empty list. 
* Fixed bug (#96) which was required `hubUtils` to be loaded for `std_colnames` to be internally available.


# hubUtils 0.0.0.9011

* Changed default behavior of `create_model_out_submit_tmpl()`. Function now, by default, returns rows of complete cases only and the behavior is controlled by argument `complete_cases_only`. Argument `remove_empty_cols` was also removed.

# hubUtils 0.0.0.9010

* **Support for Hubs using schema earlier than v2.0.0 deprecated**. Currently a warning is issued when interacting with such Hubs. Support will eventually be retired completely and errors will be produced with Hubs using older config schema.
* Added `create_model_out_submit_tmpl()` for generating round specific model output template tibbles (#82).
* Added lower level utilities:
    * `expand_model_out_val_grid()` for creating an expanded grid of valid task ID and output type ID across round modeling tasks and output types.
    * `get_round_idx()`: for getting an integer index of the element in `config_tasks$rounds` that a character round identifier maps to.
    * `get_round_ids()`: for getting a list or character vector of Hub round IDs.
* Added additional `tasks.json` validation checks via `validate_config()`:
    * Check that all task_id and output_type_id values are unique across `required` and `optional` properties.
    * In rounds where `round_id_from_variable` is `TRUE`, check that the specification of the task_id set as `round_id` is consistent across modeling tasks.
    * Check that `round_id` values are unique across rounds.
* Exported object `std_colnames` which contains standard column names used in hubverse model output data files, for use in other hubverse packages (#88).


# hubUtils 0.0.0.9009

* Added `as_model_out_tbl()` function to standardize model output data by converting to a `model_out_tbl` S3 class object. (#32, #33, #63, #64, #66)
* To support back-compatibility with model output data in older hubs, added functions `model_id_merge()` and `model_id_split()` to create `model_id` column from separate `team_abbr` and `model_abbr` columns and vice versa (#63).


# hubUtils 0.0.0.9008

* Added argument `output_type_id_datatype` to `connect_hub()` to allow overriding default behavior of automatically detecting the `output_type_id` column data type from the `tasks.json` config file (#70).
* Exposed `create_hub_schema()` argument `partitions` to `connect_hub()` function to accommodate custom hub partitioning.
* Added argument `partition_names` to `connect_model_output()` to accommodate custom hub partitioning.
* Added argument `schema` to `connect_model_output()` to allow for overriding default `arrow` schema auto-detection.
* Moved `jsonvalidate` package to Imports so Hub administrator functionality accessible through standard installation.
* Removed argument `format` from `create_hub_schema()` which now creates the same schema from a `tasks.json` config file, regardless of the data file format (#80).



# hubUtils 0.0.0.9007

* New function `validate_hub_config()` allows maintainers to check the validity of hub config files in a single call. Function `view_config_val_errors()` also modified to create combined report for hub config files from output of `validate_hub_config()`.
* Breaking change: All `model-output` data are expected to have `output_type` & `output_type_id` instead of `type` & `type_id` respectively.

# hubUtils 0.0.0.9006

* `connect_hub()` now automatically determines the `output_type_id` column data type from the `tasks.json` config file coercing to the highest possible data type, "character" being the lowest denominator.
* Introduced function `create_hub_schema()` for determining the schema for data in a hub's model-output directory from a `tasks.json` config file.
* `connect_hub()` now allows establishing connections to hubs with multiple file type formats.
* `create_output_type_categorical()` function was renamed to `create_output_type_pmf()`.
* When extracting data via a hub connection, the column containing model identification information, inferred from `model-output` data directory partitions, was renamed from "model" to "model_id".

# hubUtils 0.0.0.9005

* Re-implemented `connect_hub()` function to open connection to `model-output` data
implemented through an `arrow` `FileSystemDataset` object. This allows users to create
custom `dplyr` queries to access model output data.

# hubUtils 0.0.0.9004

* Added functionality to help create JSON configuration files.

# hubUtils 0.0.0.9003

* Added `validate_config()` function to validate JSON configuration files against Hub 
schema as well as function `view_config_val_errors()` for viewing a concise and easier to 
navigate table of validation errors.
* Added a `NEWS.md` file to track changes to the package.
