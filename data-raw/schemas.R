# Update the schemas with our repository
#
# This will delete our existing schemas folder, re-clone the git repository,
# and copy over the schemas and the NEWS to our inst folder.
#
# Since every release is static and the schemas do not materially change, we
# should not see any diffs in the established schemas
#
# For traceability, I also think inclusion of an additional file (yml?) in the
# inst folder that records:
# - The branch the latest version was updated from
# - The schemas repo commit hash of the latest version
# - A timestamp of the last update

branch <- Sys.getenv("hubUtils.dev.branch", unset = "main")

timestamp <- function() {
  format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
}

get_latest_commit <- function(branch) {
  res <- tryCatch({
    gh::gh("GET /repos/hubverse-org/schemas/branches/{branch}", branch = branch)
  },
    github_error = function(e) {
      cli::cli_alert_danger("something went wrong")
      cli::cli_alert(e$message)
      e
    }
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
    cfg <- yaml::read_yaml(update_cfg_path, eval.expr = FALSE)
  }
  # Fetch the latest commit, and check if either the branch has changed, or its
  # outdated (based on commit date)
  the_commit <- get_latest_commit(branch)
  branch_change <- cfg$branch != branch
  outdated <- cfg$timestamp < the_commit$commit$author$date

  update <- update || (branch_change || outdated)
  cfg$branch <- branch
  cfg$sha <- the_commit$sha
  cfg$timestamp <- timestamp()
  return(list(update = update, cfg = cfg))
}

schemas <- usethis::proj_path("inst/schemas")
new <- check_for_update(fs::path(schemas, "update.yml"), branch)
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
  yaml::write_yaml(new$cfg, fs::path(schemas, "update.yml"))
  cli::cli_alert_success("Done")
} else {
  cli::cli_alert_success("Schemas up-to-date with the {.var {branch}} branch!")
}
