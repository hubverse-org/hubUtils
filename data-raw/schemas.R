#!/usr/bin/env Rscript
# Update the schemas with our repository
#
# This will delete our existing schemas folder, re-clone the git repository,
# and copy over the schemas and the NEWS to our inst folder.
#
# Since every release is static and the schemas do not materially change, we
# should not see any diffs in the established schemas
#
# This will update the schemas in this repository and update a tracker json file
# called inst/schemas/update.json with the following information:
#
# - branch: The branch the latest version was updated from
# - sha: The schemas repo commit hash of the latest version
# - timestamp: A timestamp of the last update (in ISO 8601 timestamp format,
#   UTC time)
#
# USAGE:
#
# GIT HOOK
# ========
#
# This script can be used as a pre-commit hook and will run every time before
# you commit. You can install it with:
#
# ```
# usethis::use_git_hook("pre-commit", readLines("data-raw/schemas.R"))
# ```
#
# If you run this and the schema updates, then you will need to double-check
# your tests to make sure the updates did not affect your work.
#
# STANDALONE
# ==========
#
# This script will check for updates to be had in the branch defined in
# `inst/schemas/update.json` by default. If are no updates to be had, nothing
# will be done:
#
# ```
# source("data-raw/schemas.R")
# #> ✔ Schemas up-to-date!
# #> ℹ branch: "main"
# #> ℹ sha: "0163a89cc38ba3846cd829545f6d65c1e40501a6"
# #> ℹ timestamp: "2024-12-19T16:26:33Z"
# ```
#
# TO CHANGE THE BRANCH, update the environment variable called
# `HUBUTILS_DEV_BRANCH`:
#
# ```
# Sys.setenv("HUBUTILS_DEV_BRANCH" = "br-v4.0.1")
# source("data-raw/schemas.R")
# #> ✔ removing /path/to/hubUtils/inst/schemas
# #> ✔ Creating inst/schemas/.
# #> ℹ Fetching the latest version of the schemas from GitHub
# #> Cloning into '/var/folders/9p/m996p3_55hjf1hc62552cqfr0000gr/T//Rtmp3Q4dnp/file377d
# #> 71aaebd4'...
# #> ✔ Copying v4.0.1, v4.0.0, v3.0.1, v3.0.0, v2.0.1, v2.0.0, v1.0.0, v0.0.1, v0.0.0.9,
# #>  and NEWS.md to inst/schemas
# #> [ ... snip ... ]
# #> ✔ Done
# #> ✔ Schemas up-to-date!
# #> ℹ branch: "br-v4.0.1"
# #> ℹ sha: "43b2c8aceb3a316b7a1929dbe8d8ead2711d4e84"
# #> ℹ timestamp: "2024-12-19T16:40:16Z"
# ```

# FUNCTIONS -------------------------------------------------------------------
check_hook <- function(repo_path) {
  # if this is running as a git hook, then the first thing to do is to make sure
  # it is up to date with the source material. If it's not, error until it is
  # fixed.
  if (interactive()) {
    return()
  }
  hook <- fs::path(repo_path, ".git/hooks/pre-commit")
  if (fs::file_exists(hook)) {
    schema_script <- fs::path(repo_path, "data-raw/schemas.R")
    okay <- tools::md5sum(hook) == tools::md5sum(schema_script)
    if (!isTRUE(okay)) {
      cmd <- r"[usethis::use_git_hook("pre-commit", readLines("data-raw/schemas.R"))]" # nolint: object_usage_linter
      cli::cli_abort(c("git hook outdated",
        "i" = r"[Use {.code {cmd}} to update your hook.]")
      )
    }
  }
}

get_branch <- function(update_cfg_path) {
  if (fs::file_exists(update_cfg_path)) {
    branch <- jsonlite::read_json(update_cfg_path)$branch
  } else {
    branch <- "main"
  }
  branch
}

timestamp <- function() {
  format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
}

get_latest_commit <- function(branch) {
  res <- gh::gh("GET /repos/hubverse-org/schemas/branches/{branch}",
    branch = branch
  )
  res$commit
}

check_for_update <- function(update_cfg_path, branch) {
  update <- FALSE
  # If there is no config file, then we automatically update
  if (!fs::file_exists(update_cfg_path)) {
    update <- TRUE
    cfg <- list(
      branch = branch,
      sha = NULL,
      timestamp = "2024-07-16T00:00:00Z"
    )
  } else {
    cfg <- jsonlite::read_json(update_cfg_path)
  }
  # Fetch the latest commit, and check if either the branch has changed, or its
  # outdated (based on commit date)
  the_commit <- get_latest_commit(branch)
  branch_change <- cfg$branch != branch
  outdated <- cfg$timestamp < the_commit$commit$author$date
  sha_different <- cfg$sha != the_commit$sha

  update <- update || (branch_change || outdated || sha_different)
  if (update) {
    cfg$branch <- branch
    cfg$sha <- the_commit$sha
    cfg$timestamp <- timestamp()
  }
  return(list(update = update, cfg = cfg))
}

# VARIABLES ------------------------------------------------------------------
check_hook(usethis::proj_path())
schemas <- usethis::proj_path("inst/schemas")
cfg_path <- fs::path(schemas, "update.json")
branch <- Sys.getenv("HUBUTILS_DEV_BRANCH", unset = get_branch(cfg_path))
new <- check_for_update(cfg_path, branch)

# PROCESS UPDATE IF NEEDED ---------------------------------------------------
if (new$update) {
  cli::cli_alert_success("removing {.file {schemas}}")
  fs::dir_delete(schemas)
  usethis::use_directory("inst/schemas")

  cli::cli_alert_info("Fetching the latest version of the schemas from GitHub")
  tmp <- tempfile()
  system2("git", c("clone", "--branch", branch, "https://github.com/hubverse-org/schemas.git", tmp))

  versions <- as.character(fs::dir_ls(tmp, type = "dir"))
  cli::cli_alert_success("Copying {.file {c(rev(fs::path_file(versions)), 'NEWS.md')}} to {.file inst/schemas}")
  purrr::walk(versions, fs::dir_copy, schemas)
  fs::file_copy(fs::path(tmp, "NEWS.md"), schemas)
  fs::dir_tree(schemas)
  fs::dir_delete(tmp)
  jsonlite::write_json(new$cfg,
    path = cfg_path,
    pretty = TRUE,
    auto_unbox = TRUE
  )
  cli::cli_alert_success("Done")
}

# REPORT STATUS --------------------------------------------------------------
cli::cli_alert_success("Schemas up-to-date!")
cli::cli_alert_info("branch: {.val {new$cfg$branch}}")
cli::cli_alert_info("sha: {.val {new$cfg$sha}}")
cli::cli_alert_info("timestamp: {.val {new$cfg$timestamp}}")

# GIT HOOK: RE-TEST ON UPDATE ------------------------------------------------
# If this is being run as a git hook and the schemas were updated, we need
# to signal that the tests should be run again
if (!interactive() && new$update) {
  cli::cli_alert_warning("Schema updated. Re-running tests.")
  devtools::test(usethis::proj_path())
}
