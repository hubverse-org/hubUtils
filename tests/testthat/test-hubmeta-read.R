test_that("hubmeta files read in & processed correctly", {
    ## Setup ----
    json_path <- system.file("hubmeta/scnr_hubmeta_ref.json",
                             package = "hubUtils")
    yml_path <- system.file("hubmeta/scnr_hubmeta_ref.yml",
                            package = "hubUtils")
    random_path <- "random/path"
    tmp_dir <- tempdir()
    on.exit(rm(tmp_dir))
    write.csv(mtcars,
              file.path(tmp_dir, "mtcars.csv"))

    ## Tests ----
    expect_snapshot(read_hubmeta(json_path))
    expect_named(
        read_hubmeta(json_path, drop_defs = FALSE),
        c("round-1", "$defs"))
    expect_equal(read_hubmeta(json_path),
                 read_hubmeta(yml_path))
    expect_error(read_hubmeta(random_path),
                 regexp = "File .* does not exist")
    expect_error(
        read_hubmeta(file.path(tmp_dir, "mtcars.csv")),
        regexp = "file extension should be one of"
    )
})
