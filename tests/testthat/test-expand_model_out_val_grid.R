test_that("expand_model_out_val_grid works correctly", {
    hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")

    str(expand_model_out_val_grid(config_tasks))
    expand_model_out_val_grid(config_tasks)
    expand_model_out_val_grid(config_tasks, required_only = TRUE)
    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expand_model_out_val_grid(config_tasks, round_id = "2022-10-01")
    expand_model_out_val_grid(config_tasks, round_id = "2022-10-29")
})


test_that("expand_model_out_val_grid errors correctly", {
    hub_con <- connect_hub(system.file("testhubs/flusight", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expand_model_out_val_grid(config_tasks)
    expand_model_out_val_grid(config_tasks, required_only = TRUE)
    # Specifying a round in a hub with multiple rounds
    hub_con <- connect_hub(system.file("testhubs/simple", package = "hubUtils"))
    config_tasks <- attr(hub_con, "config_tasks")
    expand_model_out_val_grid(config_tasks, round_id = "2022-10-01")
    expand_model_out_val_grid(config_tasks, round_id = "2022-10-29")
})
