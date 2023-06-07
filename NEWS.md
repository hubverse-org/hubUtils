# hubUtils 0.0.0.9006

* `hub_connect()` now automatically determines the `output_type_id` column data type from the tasks.json config file coercing to the highest possible data type, "character" being the lowest denominator.
* Introduced function `create_hub_schema()` for determining the schema for data in a hub's model-output directory from a tasks.json config file.
* `hub_connect()` now allows establishing connections to hubs with multiple file type formats.
* `create_output_type_categorical()` function was renamed to `create_output_type_pmf()`.
* Model output data directory partitions inferred when Column renamed from "model" to "model_id".

# hubUtils 0.0.0.9005

* Re-implemented `hub_connect()` function to open connection to `model-output` data
implemented through an `arrow` `FileSystemDataset` object. This allows users to create
custom `dplyr` queries to access model output data.

# hubUtils 0.0.0.9004

* Added functionality to help create json configuration files.

# hubUtils 0.0.0.9003

* Added `validate_config()` function to validate json configuration files against Hub 
schema as well as function `view_config_val_errors()` for viewing a concise and easier to 
navigate table of validation errors.
* Added a `NEWS.md` file to track changes to the package.
