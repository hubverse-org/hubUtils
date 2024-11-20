# Update the schemas with our repository
#
# This will delete our existing schemas folder, re-clone the git repository,
# and copy over the schemas and the NEWS to our inst folder.
#
# Since every release is static and the schemas do not materially change, we
# should not see any diffs in the established schemas
schemas <- usethis::proj_path("inst/schemas")
cli::cli_alert_success("removing {.file {schemas}}")
fs::dir_delete(schemas)
usethis::use_directory("inst/schemas")

cli::cli_alert_info("Fetching the latest version of the schemas from GitHub")
tmp <- tempfile()
system2("git", c("clone", "https://github.com/hubverse-org/schemas.git", tmp))

versions <- as.character(fs::dir_ls(tmp, type = "dir"))
cli::cli_alert_success("Copying {.file {c(rev(fs::path_file(versions)), 'NEWS.md')}} to {.file inst/schemas}")
purrr::walk(versions, fs::dir_copy, schemas)
fs::file_copy(fs::path(tmp, "NEWS.md"), schemas)
fs::dir_tree(schemas)
fs::dir_delete(tmp)
cli::cli_alert_success("Done")
