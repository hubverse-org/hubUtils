#!/usr/bin/env Rscript
# Update the schemas with our repository
#
# This will delete our existing schemas folder, re-clone the git repository,
# and copy over the schemas and the NEWS to our inst folder.
#
# Since every release is static and the schemas do not materially change, we
# should not see any diffs in the established schemas
#
# This will update the schemas in this repository and update a tracker yaml file
# called inst/schemas/update.yml with the following information:
#
# - branch: The branch the latest version was updated from
# - sha: The schemas repo commit hash of the latest version
# - timestamp: A timestamp of the last update (in ISO 8601 timestamp format,
#   UTC time)
#
# USAGE:
#
#
# The script will check for any updates to the main branch by default. If there
# are no updates to be had, nothing will be done:
#
# ```
# source("data-raw/schemas.R")
# #> ✔ Schemas up-to-date with the `main` branch!
# ```
#
# TO CHANGE THE BRANCH, update the environment variable called
# `hubUtils.dev.branch`:
#
# ```
# Sys.setenv("hubUtils.dev.branch" = "br-4.0.1")
# source("data-raw/schemas.R")
# ```

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

  update <- update || (branch_change || outdated)
  if (update) {
    cfg$branch <- branch
    cfg$sha <- the_commit$sha
    cfg$timestamp <- timestamp()
  }
  return(list(update = update, cfg = cfg))
}

schemas <- usethis::proj_path("inst/schemas")
cfg_path <- fs::path(schemas, "update.json")
branch <- Sys.getenv("hubUtils.dev.branch", unset = get_branch(cfg_path))
new <- check_for_update(cfg_path, branch)

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

cli::cli_alert_success("Schemas up-to-date!")
cli::cli_alert_info("branch: {.val {new$cfg$branch}}")
cli::cli_alert_info("sha: {.val {new$cfg$sha}}")
cli::cli_alert_info("timestamp: {.val {new$cfg$timestamp}}")


if (!interactive() && new$update) {
  stop("Schema updated. Double-check your tests.")
} 
