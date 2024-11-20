# v3.0.1

* Introduction of optional `output_type_id_datatype` property to enable hub administrators to configure and communicate the `output_type_id` column data type at a hub level. This will allow hubs to override default behaviour of automatically determinining the simplest data type that can accomodate output type IDs across all output types when creating hub schema. The setting is also useful for administrators to future proof the `output_type_id` column from potential issues arising by changes in data type, introduced by new output types after submissions have begun, by setting `output_type_id_datatype` to the simplest data type from the start, i.e. character (#87).
* Removed restrictive epidemic week formatting requirements for CDF `output_type_id` values. Character output type IDs no longer need to conform to the regex pattern `^EW[0-9]{6}` (e.g. `"EW202240"`) (#80).



# v3.0.0

* Breaking change: introduction of new `sample` output type id schema specification in `tasks.json`. The main breaking change is the removal of the `output_type_id` property in `sample`. Instead, the collection of samples is defined through a new `output_type_id_params` object (#70).
* Breaking change: The `repository_url` and `repository_host` properties in `admin.json` have been deprecated in favour of a sigle `repository` object with separate `host`, `owner` and `name` properties (#67).
* Breaking change: The optional `hub_models` property in `admin.json` has been removed as it's schema could create conflicts with the `model_abbr` and `team_abbr` schema specification in the hub administered `model-metadata-schema.json (#77).
* Additional properties are now allowed at the round item property level (#74).
* Host organisation name changed in schema `id` properties to `hubverse-org` throughout all schema versions.

# v2.0.1

* Non-breaking change: introduced an optional `cloud` group to `admin-schema.json` to support cloud-enabled Hubs:
  * `cloud` group includes a boolean `enabled` property to indicate whether or not the hub will store data in the cloud.
  * `cloud.host` is an object with properties that describe the cloud storage provider and location. It is required when `cloud.enabled` is `true`.

# v2.0.0

* Major breaking change: Output type property `type_id` renamed to `output_type_id` for consistency in with changes in model output data.
* Added `uniqueItem` checks to all `optional` and `required` arrays.
* Added a schema to `task_ids` `additionalProperty` property instead of just setting it to `true`. This schema ensures that any custom task IDs added by hub administrators at least checked for being objects and having `optional` and `required` properties that are either arrays or null.
* Added standard task IDs `forecast_date` (equivalent to `origin_date`), `target_end_date` (equivalent to `target_date`) and `target_variable` & `target_outcome` which can be used to split targets across two task IDs.

# v1.0.0

* Major breaking change: `categorical` output type renamed to `pmf` for consistency in terminology.
* Target type `"categorical"` also renamed to `"nominal"`.
* Minor bug fixes and consistency improvements.
* Added NEWS.md for recording changes to schema.


# v0.0.1

* First stable version of schema for use with Hubs
* Important properties introduced:
  * `schema_version` (required) to link a given congif file to a specific config file schema.
  * `target_metadata` (required) objects to append metadata about targets to model tasks.
  * `file_format` (required in `admin-schema.json` and optional within `tasks-schema.json` rounds) to specify accepted file formats of model output file submissions.
* Removed `model-schema.json`. Examples of these will live in `hubTemplate` repositories and defined by hub administrators.
