test_that("create_model_out_submit_tmpl works correctly", {
    hub_con <- connect_hub(
        system.file("testhubs/flusight", package = "hubUtils")
    )

    expect_snapshot(str(
        create_model_out_submit_tmpl(hub_con)
    ))
    expect_equal(
        unique(suppressMessages(
            create_model_out_submit_tmpl(
                hub_con
            )$forecast_date
        )),
        c("2022-12-12", "2022-12-19", "2022-12-26", "2023-01-02", "2023-01-09",
          "2023-01-16", "2023-01-23", "2023-01-30", "2023-02-06", "2023-02-13",
          "2023-02-20", "2023-02-27", "2023-03-06", "2023-03-13", "2023-03-20",
          "2023-03-27", "2023-04-03", "2023-04-10", "2023-04-17", "2023-04-24",
          "2023-05-01", "2023-05-08", "2023-05-15")
    )

    expect_snapshot(str(
        create_model_out_submit_tmpl(hub_con,
                                     round_id = "2023-01-16")
    ))
    expect_equal(
        unique(suppressMessages(
            create_model_out_submit_tmpl(
                hub_con,
                round_id = "2022-12-19"
            )$forecast_date
        )),
        "2022-12-19"
    )

    expect_snapshot(str(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "2023-01-16",
            required_only = TRUE
        )
    ))
    expect_equal(
        unique(suppressMessages(
            create_model_out_submit_tmpl(
                hub_con,
                round_id = "2022-12-19",
                required_only = TRUE
            )$forecast_date
        )),
        "2022-12-19"
    )


    expect_snapshot(str(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "2023-01-16",
            required_only = TRUE,
            include_opt_cols = TRUE
        )
    ))

    expect_equal(
        unique(suppressMessages(
            create_model_out_submit_tmpl(
                hub_con,
                round_id = "2022-12-19",
                required_only = TRUE,
                include_opt_cols = TRUE
            )$forecast_date
        )),
        "2022-12-19"
    )

    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(
        system.file("testhubs/simple", package = "hubUtils")
    )

    expect_snapshot(str(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "2022-10-01"
        )
    ))

    expect_snapshot(str(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "2022-10-01",
            required_only = TRUE
        )
    ))
    expect_snapshot(str(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "2022-10-29",
            required_only = TRUE
        )
    ))
})

test_that("create_model_out_submit_tmpl errors correctly", {
    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    hub_con <- attr(hub_con, "hub_con")

    expect_snapshot(
        create_model_out_submit_tmpl(
            hub_con,
            round_id = "random_round_id"
        ),
        error = TRUE
    )
    expect_snapshot(
        create_model_out_submit_tmpl(hub_con),
        error = TRUE
    )
})
