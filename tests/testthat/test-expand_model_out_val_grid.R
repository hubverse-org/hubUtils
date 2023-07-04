test_that("expand_model_out_val_grid works correctly", {
    hub_con <- connect_hub(
        system.file("testhubs/flusight", package = "hubUtils")
    )
    config_tasks <- attr(hub_con, "config_tasks")

    expect_snapshot(str(
        expand_model_out_val_grid(config_tasks)
    ))
    expect_snapshot(str(
        expand_model_out_val_grid(
            config_tasks,
            required_only = TRUE
        )
    ))

    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(
        system.file("testhubs/simple", package = "hubUtils")
    )
    config_tasks <- attr(hub_con, "config_tasks")

    expect_snapshot(str(
        expand_model_out_val_grid(
            config_tasks,
            round_id = "2022-10-01"
        )
    ))

    expect_snapshot(str(
        expand_model_out_val_grid(
            config_tasks,
            round_id = "2022-10-01",
            required_only = TRUE
        )
    ))
    expect_snapshot(str(
        expand_model_out_val_grid(
            config_tasks,
            round_id = "2022-10-29",
            required_only = TRUE
        )
    ))
})

test_that("Setting of round_id value works correctly", {
    hub_con <- connect_hub(
        system.file("testhubs/simple", package = "hubUtils")
    )
    config_tasks <- attr(hub_con, "config_tasks")
    expect_equal(
        unique(
            expand_model_out_val_grid(
                config_tasks,
                round_id = "2022-10-01"
            )$origin_date
        ),
        "2022-10-01"
    )

    expect_equal(
        unique(
            expand_model_out_val_grid(
                config_tasks,
                required_only = TRUE,
                round_id = "2022-10-29"
            )$origin_date
        ),
        "2022-10-29"
    )


    # Test in hub with single round
    hub_con <- connect_hub(
        system.file("testhubs/flusight", package = "hubUtils")
    )
    config_tasks <- attr(hub_con, "config_tasks")

    expect_equal(
        unique(
            expand_model_out_val_grid(
                config_tasks,
                required_only = TRUE,
                round_id = "2023-01-30"
            )$forecast_date
        ),
        "2023-01-30"
    )
    expect_false(
        "forecast_date" %in% names(
            expand_model_out_val_grid(
                config_tasks,
                required_only = TRUE
            )
        )
    )
})


test_that("expand_model_out_val_grid errors correctly", {
    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")

    expect_snapshot(
        expand_model_out_val_grid(
            config_tasks,
            round_id = "random_round_id"
        ),
        error = TRUE
    )
    expect_snapshot(
        expand_model_out_val_grid(config_tasks),
        error = TRUE
    )
})
