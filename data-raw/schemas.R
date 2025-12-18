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
# This script can be used as a pre-push hook and will run every time before
# you push. You can install it with:
#
# ```
# usethis::use_git_hook("pre-push", readLines("data-raw/schemas.R"))
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
# `HUBUTILS_SCHEMA_BRANCH`:
#
# ```
# Sys.setenv("HUBUTILS_SCHEMA_BRANCH" = "br-v4.0.1")
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
# Get the name of the currently running script
#
# When this is run from `Rscript`, then the script name is the `--file`
# component from the command line arguments. This extracts the script name so
# we can use it later to check if we are in a Git hook
script_name <- function() {
  cmd <- commandArgs()
  basename(sub(
    "--file=",
    "",
    cmd[grepl("--file=", cmd, fixed = TRUE)],
    fixed = TRUE
  ))
}

# Check if any schemas are changed but not committed and throw an error
check_status <- function(repo_path) {
  git_stat <- system2(
    "git",
    c("-C", repo_path, "status", "--short", "--porcelain"),
    stdout = TRUE
  )
  # git status --short --porcelain
  #  M inst/schemas/NEWS.md
  # ?? inst/schemas/vX.Y.Z/
  #  M R/blah.R
  paths <- dirname(substring(git_stat, 4, nchar(git_stat)))
  if (any(startsWith(paths, "inst/schemas"))) {
    cli::cli_abort(
      c(
        "New schemas must be committed before pushing."
      )
    )
  }
}

not_hook <- function() interactive() || script_name() != "pre-push"
is_hook <- Negate(not_hook)

check_hook <- function(repo_path) {
  # if this is running as a git hook, then the first thing to do is to make sure
  # it is up to date with the source material. If it's not, error until it is
  # fixed.
  if (not_hook()) {
    return()
  }
  cli::cli_h2("{.strong pre-push}: checking that the hook is up-to-date")
  hook <- fs::path(repo_path, ".git/hooks/pre-push")
  if (fs::file_exists(hook)) {
    schema_script <- fs::path(repo_path, "data-raw/schemas.R")
    okay <- tools::md5sum(hook) == tools::md5sum(schema_script)
    if (isTRUE(okay)) {
      cli::cli_alert_success("OK")
    } else {
      cmd <- r"[usethis::use_git_hook("pre-push", readLines(usethis::proj_path("data-raw/schemas.R")))]" # nolint: object_usage_linter
      cli::cli_abort(
        c(
          "git hook outdated",
          "i" = r"[Use {.code {cmd}} to update your hook.]"
        )
      )
    }
  } else {
    cli::cli_alert("No pre-push hook registered")
  }
}

get_branch <- function(update_cfg_path = "inst/schemas/update.json") {
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

check_main_ahead <- function(the_commit) {
  main_commit <- get_latest_commit("main")
  curr_time <- the_commit$commit$author$date
  main_time <- main_commit$commit$author$date
  newer_main <- curr_time < main_time
  if (newer_main) {
    main_sha <- main_commit$sha |> substr(1, 7) # nolint: object_usage_linter
    old_sha <- the_commit$sha |> substr(1, 7) # nolint: object_usage_linter
    if (not_hook()) {
      # nolint start
      script <- r"[Sys.setenv("HUBUTILS_SCHEMA_BRANCH" = "main");
      source("data-raw/schemas.R")]"
    } else {
      script <- r"[HUBUTILS_SCHEMA_BRANCH=main Rscript data-raw/schemas.R &&
      unsetenv HUBUTILS_SCHEMA_BRANCH]"
      # nolint end
    }
    cli::cli_abort(
      c(
        "{.val schemas@main} ({main_sha}, {main_time}) newer than {.val schemas@{branch}} ({old_sha}, {curr_time})",
        "i" = r"[Run this code to update to the main branch: {.code {script}}]"
      )
    )
  }
}

get_latest_commit <- function(branch) {
  res <- gh::gh(
    "GET /repos/hubverse-org/schemas/branches/{branch}",
    branch = branch
  )
  if (branch != "main") {
    check_main_ahead(res$commit)
  }
  res$commit
}

check_for_update <- function(update_cfg_path, branch) {
  update <- FALSE
  if (is_hook()) {
    cli::cli_h2("{.strong pre-push}: checking that schemas are up-to-date")
  }
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
  # Fetch the main branch commit to check if we need to update
  branch_change <- cfg$branch != branch
  outdated <- cfg$timestamp < the_commit$commit$author$date
  sha_different <- cfg$sha != the_commit$sha

  update <- update || (branch_change || outdated || sha_different)
  if (update) {
    cfg$branch <- branch
    cfg$sha <- the_commit$sha
    cfg$timestamp <- timestamp()
  }
  list(update = update, cfg = cfg)
}

# VARIABLES ------------------------------------------------------------------
if (is_hook()) {
  cli::cli_h1("{.strong pre-push}: schema synchronization")
}
check_hook(usethis::proj_path())
schemas <- usethis::proj_path("inst/schemas")
cfg_path <- fs::path(schemas, "update.json")
branch <- Sys.getenv("HUBUTILS_SCHEMA_BRANCH", unset = get_branch(cfg_path))
new <- check_for_update(cfg_path, branch)

# PROCESS UPDATE IF NEEDED ---------------------------------------------------
if (new$update) {
  cli::cli_alert_success("removing {.file {schemas}}")
  fs::dir_delete(schemas)
  usethis::use_directory("inst/schemas")

  cli::cli_alert_info("Fetching the latest version of the schemas from GitHub")
  tmp <- tempfile()
  system2(
    "git",
    c(
      "clone",
      "--branch",
      branch,
      "https://github.com/hubverse-org/schemas.git",
      tmp
    )
  )

  versions <- as.character(fs::dir_ls(tmp, type = "dir"))
  cli::cli_alert_success(
    "Copying {.file {c(rev(fs::path_file(versions)), 'NEWS.md')}} to {.file inst/schemas}"
  )
  purrr::walk(versions, fs::dir_copy, schemas)
  fs::file_copy(fs::path(tmp, "NEWS.md"), schemas)
  fs::dir_tree(schemas)
  fs::dir_delete(tmp)
  jsonlite::write_json(
    new$cfg,
    path = cfg_path,
    pretty = TRUE,
    auto_unbox = TRUE
  )
  cli::cli_alert_success("Done")
}

# REPORT STATUS --------------------------------------------------------------
cli::cli_alert("branch: {.val {new$cfg$branch}}")
cli::cli_alert("sha: {.val {new$cfg$sha}}")
cli::cli_alert("timestamp: {.val {new$cfg$timestamp}}")
cli::cli_alert_success("OK")

# GIT HOOK: RE-TEST ON UPDATE ------------------------------------------------
# If this is being run as a git hook and the schemas were updated, we need
# to signal that the tests should be run again
if (!interactive() && new$update) {
  cli::cli_h2("{cli::symbol$warning} {.strong schema updated}")
  cli::cli_alert_info("Re-running tests")
  devtools::test(usethis::proj_path())
  cli::cli_alert_success("OK")
}
# GIT HOOK: CHECK FOR UNCOMMITTED CHANGES ------------------------------------
if (is_hook()) {
  cli::cli_h2(
    "{.strong pre-push}: checking for changes in {.path inst/schemas}"
  )
  check_status(usethis::proj_path())
  cli::cli_alert_success("OK")
}
