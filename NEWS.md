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
