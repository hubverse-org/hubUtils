test_that("connect_hub works on simple forecasting hub", {
    # Simple forecasting Hub example ----

    hub_path <- system.file("hub_1", package = "hubUtils")
    hub_con <- connect_hub(hub_path)


    # Tests that paths are assigned to attributes correctly
    expect_equal(
        attr(hub_con, "hubmeta_path"),
        fs::path(hub_path, "hubmeta.json")
    )
    expect_equal(
        attr(hub_con, "hub_path"),
        hub_path
    )
    expect_false(
        attr(hub_con, "task_ids_by_round")
    )

    # overwrite path attributes to make snapshot portable
    attr(hub_con, "hubmeta_path") <- ""
    attr(hub_con, "hub_path") <- ""
    expect_snapshot(hub_con)
})


test_that("connect_hub works on scenario hub", {
    # Scenario Hub example ----
    scnr_path <- system.file("scnr_hub_1", package = "hubUtils")
    hub_con <- connect_hub(scnr_path)

    attr(hub_con, "hubmeta_path") <- ""
    attr(hub_con, "hub_path") <- ""

    expect_true(
        attr(hub_con, "task_ids_by_round")
    )
    expect_snapshot(hub_con)

    # More detailed tests in case snapshot update creates unnexpected behaviour
    expect_s3_class(hub_con,
                    c("list", "hub_connection"))
    expect_length(hub_con, 2)
    expect_equal(attr(hub_con, "round_ids"),
                 c("round-1", "round-2"))
    expect_equal(
        attr(hub_con, "task_id_names"),
        list(`round-1` = c("origin_date", "scenario_id", "location",
                           "target", "horizon"),
             `round-2` = c("origin_date", "scenario_id",
                           "location", "target", "age_group", "horizon"))
    )

})


test_that("connect_hub works on yml hubmeta at specified path", {
    # hubmeta is yml & in different location
    humeta_path <- system.file("hubmeta/scnr_hubmeta_ref.yml",
                               package = "hubUtils"
    )
    scnr_path <- system.file("scnr_hub_1", package = "hubUtils")


    hub_con <- connect_hub(
        scnr_path,
        hubmeta_path = humeta_path,
        hubmeta_format = "yml"
    )

    expect_equal(
        basename(attr(hub_con, "hubmeta_path")),
        "scnr_hubmeta_ref.yml"
    )
    attr(hub_con, "hubmeta_path") <- ""
    attr(hub_con, "hub_path") <- ""
    expect_snapshot(hub_con)


    ## Expect error with random path
    expect_error(connect_hub("random/path"))
})
