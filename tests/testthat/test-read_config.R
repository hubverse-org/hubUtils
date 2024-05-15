test_that("read_config works on local hubs", {
    expect_snapshot(
        read_config(
            hub_path = system.file("testhubs", "simple", package = "hubUtils")
        )
    )
    expect_snapshot(
        read_config(
            hub_path = system.file("testhubs", "simple", package = "hubUtils"),
            config = "admin"
        )
    )
    expect_snapshot(
        read_config(
            hub_path = system.file("testhubs", "simple", package = "hubUtils"),
            config = "model-metadata-schema"
        )
    )
})

test_that("read_config works on S3 cloud hubs", {
    expect_snapshot(
        read_config(
            hub_path = hubData::s3_bucket("hubverse/hubutils/testhubs/simple/")
        )
    )
})

test_that("read_config_file works", {
    expect_snapshot(
        read_config_file(
            system.file("config", "tasks.json", package = "hubUtils")
        )
    )
})
