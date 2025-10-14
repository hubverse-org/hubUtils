# ------------------------------------------------------------------------------
# This script automates the creation of lightweight test versions of a Hubverse
# forecast hub for use in development, demonstrations, and testing.
#
# Main steps:
# 1. Install required packages and clone the source hub repository from GitHub.
# 2. Define a reduced set of valid values (dates, locations, horizons, etc.) to
#    build simplified `tasks.json` and update `admin.json` for compatibility.
# 3. Validate the generated hub configuration files.
# 4. Remove unnecessary files and directories (.git, internal data, large model
#    output) to reduce repository size.
# 5. Filter and downsample model output and target data files to keep only the
#    specified subsets.
# 6. Validate reduced model outputs to ensure schema compliance.
# 7. Create two reduced test hubs:
#    - **Single-file hub** version.
#    - **Hive-partitioned hub** version, with partitioned target data.
#
# The result is a pair of compact, schema-valid test hubs suitable for faster
# iteration and reproducible examples, while preserving realistic structure.
# ------------------------------------------------------------------------------
# Install dependencies ----
# install.packages(c("hubValidations", "hubData", "hubUtils","hubAdmin"), dependencies = TRUE, repos = c("https://hubverse-org.r-universe.dev", "https://cloud.r-project.org")) # nolint: line_length_linter

# ---- Setup workflow ----
library(dplyr)
library(hubValidations)
library(hubData)
library(hubUtils)
library(hubAdmin)

# Set up paths
options(update.branch = "ak/upgrade-to-v6") # Use to override default
# source branch ('main')
hub_path_source <- fs::path(withr::local_tempdir(), "main")
hub_url <- "https://github.com/hubverse-org/example-complex-forecast-hub.git"
gert::git_clone(
  url = hub_url,
  path = hub_path_source,
  branch = getOption("update.branch", default = "main")
)
initial_size <- sum(fs::dir_info(hub_path_source, recurse = TRUE)$size)

hub_version <- hubUtils::get_version_hub(hub_path_source, "admin")
options(hubAdmin.schema_version = hub_version)
version <- stringr::str_match(hub_version, "v[0-9]+")[1]

hub_path_file <- here::here("inst", "testhubs", version, "target_file")
hub_path_dir <- here::here("inst", "testhubs", version, "target_dir")


# Specify up hub valid values. Will be used to create hub config and subset
# model output and target files.
output_types <- c(
  "pmf",
  "cdf",
  "quantile",
  "sample",
  "mean"
)
locations <- c("US", "01", "02")
horizons <- 1:2
quantiles <- c(0.025, seq(0.1, 0.9, by = 0.1), 0.975)
cdfs <- c(1:12)
pmfs <- c("low", "moderate", "high", "very high")
ref_dates <- c(
  "2022-10-22",
  "2022-10-29",
  "2022-11-05",
  "2022-11-12",
  "2022-11-19",
  "2022-11-26",
  "2022-12-03",
  "2022-12-10",
  "2022-12-17",
  "2022-12-24",
  "2022-12-31"
)

target_dates <- c(ref_dates, as.character(as.Date(ref_dates) + 14)) |>
  unique() |>
  sort()

##### ----- Create new simpler config files ##### ----
cli::cli_h2("Creating simpler hub config files")
# define task_ids for each model task
ref_date_tid <- create_task_id(
  "reference_date",
  required = NULL,
  optional = ref_dates
)
horizon_tid <- create_task_id(
  "horizon",
  required = NULL,
  optional = horizons
)
location_tid <- create_task_id(
  "location",
  required = NULL,
  optional = locations
)
target_end_date_tid <- create_task_id(
  "target_end_date",
  required = NULL,
  optional = target_dates
)

tids_cat <- create_task_ids(
  ref_date_tid,
  create_task_id(
    "target",
    required = NULL,
    optional = "wk flu hosp rate category"
  ),
  horizon_tid,
  location_tid,
  target_end_date_tid
)

tids_cont <- create_task_ids(
  ref_date_tid,
  create_task_id(
    "target",
    required = NULL,
    optional = "wk flu hosp rate"
  ),
  horizon_tid,
  location_tid,
  target_end_date_tid
)

tids_inc <- create_task_ids(
  ref_date_tid,
  create_task_id("target", required = NULL, optional = "wk inc flu hosp"),
  horizon_tid,
  location_tid,
  target_end_date_tid
)

# define the three model tasks
task_cat <- create_model_task(
  task_ids = tids_cat,
  output_type = create_output_type(
    create_output_type_pmf(
      required = pmfs,
      is_required = TRUE,
      value_type = "double"
    )
  ),
  target_metadata = create_target_metadata(
    create_target_metadata_item(
      target_id = "wk flu hosp rate category",
      target_name = "week ahead weekly influenza hospitalization rate category",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "wk flu hosp rate category"),
      target_type = "ordinal",
      description = "This target represents a categorical severity level for rate of new hospitalizations per week for the week ending [horizon] weeks after the reference_date, on target_end_date.", # nolint: line_length_linter
      is_step_ahead = TRUE,
      time_unit = "week"
    )
  )
)

task_cont <- create_model_task(
  task_ids = tids_cont,
  output_type = create_output_type(
    create_output_type_cdf(
      required = cdfs,
      is_required = TRUE,
      value_type = "double"
    )
  ),
  target_metadata = create_target_metadata(
    create_target_metadata_item(
      target_id = "wk flu hosp rate",
      target_name = "week ahead weekly influenza hospitalization rate",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "wk flu hosp rate"),
      target_type = "continuous",
      description = "This target is the weekly rate of new hospitalizations per 100k population for the week ending [horizon] weeks after the reference_date, on target_end_date.", # nolint: line_length_linter
      is_step_ahead = TRUE,
      time_unit = "week"
    )
  )
)

task_inc <- create_model_task(
  task_ids = tids_inc,
  output_type = create_output_type(
    create_output_type_quantile(
      required = quantiles,
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0
    ),
    create_output_type_sample(
      output_type_id_type = "integer",
      min_samples_per_task = 5L,
      max_samples_per_task = 5L,
      compound_taskid_set = c("reference_date", "location"),
      is_required = TRUE,
      value_type = "integer",
      value_minimum = 0
    ),
    create_output_type_mean(
      is_required = FALSE,
      value_type = "double",
      value_minimum = 0
    )
  ),
  target_metadata = create_target_metadata(
    create_target_metadata_item(
      target_id = "wk inc flu hosp",
      target_name = "incident influenza hospitalizations",
      target_units = "count",
      target_keys = list(target = "wk inc flu hosp"),
      target_type = "continuous",
      description = "This target represents the count of new hospitalizations in the week ending on the date [horizon] weeks after the reference_date, on the target_end_date.", # nolint: line_length_linters
      is_step_ahead = TRUE,
      time_unit = "week"
    )
  )
)

# combine into a single round
round <- create_round(
  round_id_from_variable = TRUE,
  round_id = "reference_date",
  model_tasks = create_model_tasks(task_cat, task_cont, task_inc),
  submissions_due = list(relative_to = "reference_date", start = -6L, end = -3L)
)

# Write tasks config
config_tasks <- create_config(
  create_rounds(round),
  derived_task_ids = "target_end_date"
)
write_config(
  config_tasks,
  hub_path = hub_path_source,
  overwrite = TRUE
)

##### ---- Update admin config if required #### ----
tasks_v <- get_version_hub(hub_path_source, "tasks")
admin_v <- get_version_hub(hub_path_source, "admin")

if (admin_v != tasks_v) {
  config_admin <- read_config(hub_path_source, config = "admin")
  admin_id <- gsub(
    admin_v,
    tasks_v,
    config_admin$schema_version,
    fixed = TRUE
  )

  config_admin$schema_version <- admin_id
  attr(config_admin, "schema_id") <- admin_id

  # Manually autobox the file_format
  config_admin$file_format <- list(config_admin$file_format)

  write_config(
    config_admin,
    config_path = fs::path(hub_path_source, "hub-config", "admin.json"),
    overwrite = TRUE,
    silent = FALSE
  )
}
## Validate hub config files ----
validate_hub_config(hub_path = hub_path_source)

cli::cli_alert_success(
  "Hub config files created and validated successfully."
)

# ##### ---- Reduce size of hub ---- ####
# Delete any existing git files
cli::cli_h2("Cleaning up unnecessary files")
fs::dir_ls(
  hub_path_source,
  all = TRUE,
  regexp = "\\.git",
  type = "directory"
) |>
  fs::dir_delete()

fs::dir_ls(
  hub_path_source,
  all = TRUE,
  regexp = "\\.git",
  type = "file"
) |>
  fs::file_delete()

# Delete internal data ----
fs::dir_delete(fs::path(hub_path_source, "internal-data-raw"))

# Reduce number of model output files ----
model_out_files <- fs::dir_ls(
  hub_path_source,
  regexp = "model-output",
  recurse = TRUE,
  type = "file"
)
keep <- grepl(
  "2022-11-19|2022-10-22|README",
  basename(model_out_files)
)
fs::file_delete(model_out_files[!keep])
cli::cli_alert_success(
  "Unnecessary files/directories deleted successfully:"
)
cli::cli_bullets(
  c(
    "x" = "{.path .git} files",
    "x" = "{.path internal-data-raw} directory",
    "x" = "Model output files with round ID greater than {.val 2022-11-19}"
  )
)

##### ---- Reduce size of hub data files ---- ####
cli::cli_h2("Reducing size of model output data files")
reduce_model_out_file <- function(
  x,
  config_tasks,
  horizons,
  locations,
  quantiles,
  pmfs,
  cdfs
) {
  # Read the CSV file
  tbl <- arrow::read_csv_arrow(x) |>
    filter(
      horizon %in% horizons,
      location %in% locations
    )
  spls <- filter(tbl, output_type == "sample")

  tbl <- filter(
    tbl,
    output_type != "sample"
  )
  quant_tbl <- filter(
    tbl,
    output_type == "quantile" & output_type_id %in% quantiles
  )
  pmf_tbl <- filter(
    tbl,
    output_type == "pmf" & output_type_id %in% pmfs
  )
  cdf_tbl <- filter(
    tbl,
    output_type == "cdf" & output_type_id %in% cdfs
  )
  mean_tbl <- filter(tbl, output_type == "mean")

  # Filter samples
  compound_taskids <- get_tbl_compound_taskid_set(
    coerce_to_character(spls),
    config_tasks,
    round_id = parse_file_name(x)$round_id,
    compact = TRUE
  ) |>
    unlist(use.names = FALSE)

  spls <- spls |>
    group_by(across(all_of(compound_taskids))) |>
    slice_head(n = 5)

  tbl <- bind_rows(
    quant_tbl,
    mean_tbl,
    pmf_tbl,
    cdf_tbl,
    spls
  )
  # Write the reduced data back to CSV files
  arrow::write_csv_arrow(
    coerce_to_hub_schema(tbl, config_tasks),
    x
  )
}

# Create a list of model output CSV files to reduce
model_out_csv_files <- fs::dir_ls(
  hub_path_source,
  regexp = "model-output",
  recurse = TRUE,
  type = "file"
)
model_out_csv_files <- model_out_csv_files[
  endsWith(model_out_csv_files, "csv")
]

# Reduce each model output file
purrr::walk(
  model_out_csv_files,
  ~ reduce_model_out_file(
    .x,
    config_tasks = config_tasks,
    horizons = horizons,
    locations = locations,
    quantiles = quantiles,
    pmfs = pmfs,
    cdfs = cdfs
  )
)
# Validate the reduced model output files
res <- purrr::map(
  model_out_csv_files |>
    fs::path_rel(fs::path(hub_path_source, "model-output")),
  ~ {
    validate_submission(
      hub_path = hub_path_source,
      file_path = .x,
      skip_submit_window_check = TRUE
    )
  }
)
check <- purrr::map_lgl(res, ~ check_for_errors(.x))
if (!all(check)) {
  cli::cli_abort(
    "Some model output files did not validate correctly. Please check the
    validation messages."
  )
}
cli::cli_alert_success("Model output files reduced successfully.")
# ---- Reduce target data ----
cli::cli_h2("Reducing target data")
ts_path <- get_target_path(hub_path_source, "time-series")

ts_dat <- read_target_file(
  target_file_path = basename(ts_path),
  hub_path_source
)
if ("date" %in% colnames(ts_dat)) {
  ts_dat <- rename(ts_dat, target_end_date = date)
}
ts_dat <- filter(
  ts_dat,
  target_end_date %in% ref_dates,
  location %in% locations
)

arrow::write_csv_arrow(ts_dat, ts_path)
cli::cli_alert_success(
  "{.field time-series} target data reduced successfully."
)

oo_path <- get_target_path(hub_path_source, "oracle-output")
oo_dat <- read_target_file(
  target_file_path = basename(oo_path),
  hub_path_source
) |>
  filter(
    target_end_date %in% ref_dates,
    location %in% locations
  )

oo_cdf <- filter(oo_dat, output_type == "cdf", output_type_id %in% cdfs)
oo_pmf <- filter(oo_dat, output_type == "pmf", output_type_id %in% pmfs)
oo_rest <- filter(oo_dat, !output_type %in% c("cdf", "pmf", "median"))

oo_dat <- bind_rows(
  oo_cdf,
  oo_pmf,
  oo_rest
)
arrow::write_csv_arrow(
  oo_dat,
  oo_path
)
cli::cli_alert_success(
  "{.field oracle-output} target data reduced successfully."
)
# ---- Create target test hubs ----
cli::cli_h1("Creating target test hubs")
# Write out single file target test hub to inst/testhubs/v5/trg_file
if (fs::dir_exists(hub_path_file)) {
  fs::dir_delete(hub_path_file)
}
cli::cli_h2("Creating {.field file} target test hub")
fs::dir_copy(
  hub_path_source,
  hub_path_file,
  overwrite = TRUE
)
reduced_size_file <- sum(fs::dir_info(hub_path_file, recurse = TRUE)$size)
cli::cli_alert_success(
  "Created {.field file} target test hub at {.path {hub_path_file}}.
  Size reduced from {.val {initial_size}} to {.val {reduced_size_file}}."
)

# Write out hive-partitioned directory target test hub to inst/testhubs/v5/trg_dir
if (fs::dir_exists(hub_path_dir)) {
  fs::dir_delete(hub_path_dir)
}
cli::cli_h2("Creating {.field dir} target test hub")
fs::dir_copy(
  hub_path_source,
  hub_path_dir,
  overwrite = TRUE
)
partition_target_data <- function(
  data,
  hub_path,
  target_type = c(
    "time-series",
    "oracle-output"
  )
) {
  target_type <- rlang::arg_match(target_type)
  target_path <- get_target_path(hub_path, target_type)
  fs::file_delete(target_path)
  target_path <- fs::path_ext_remove(target_path)
  fs::dir_create(target_path)
  arrow::write_dataset(
    dataset = data,
    path = target_path
  )
}

ts_dat |>
  group_by(
    target
  ) |>
  partition_target_data(
    hub_path = hub_path_dir,
    target_type = "time-series"
  )

oo_dat |>
  group_by(
    output_type
  ) |>
  partition_target_data(
    hub_path = hub_path_dir,
    target_type = "oracle-output"
  )

reduced_size_dir <- sum(fs::dir_info(hub_path_dir, recurse = TRUE)$size)
cli::cli_alert_success(
  "Created {.field dir} target test hub at {.path {hub_path_file}}.
  Size reduced from {.val {initial_size}} to {.val {reduced_size_dir}}."
)
