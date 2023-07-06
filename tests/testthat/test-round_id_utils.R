test_that("get_round_ids works correctly", {
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expect_snapshot(get_round_ids(config_tasks))
    expect_snapshot(get_round_ids(config_tasks, flatten = FALSE))

    hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expect_snapshot(get_round_ids(config_tasks))
    expect_snapshot(get_round_ids(config_tasks, flatten = FALSE))
})

test_that("get_round_idx works correctly", {
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expect_snapshot(get_round_idx(config_tasks, "2022-10-01"))
    expect_snapshot(get_round_idx(config_tasks, "2022-10-29"))
    expect_snapshot(get_round_idx(config_tasks), error = TRUE)

    hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expect_snapshot(get_round_idx(config_tasks))
    expect_snapshot(get_round_idx(config_tasks))
})





