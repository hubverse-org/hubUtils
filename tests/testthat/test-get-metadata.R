test_that("get_round_ids works", {
  expect_snapshot_error(get_round_ids(list("round-1" = NA, "round-2" = NA)))
  hub_con <- connect_hub(system.file("hub_1", package = "hubUtils"))
  expect_equal(get_round_ids(hub_con), "origin_date")

  hub_con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))
  expect_equal(get_round_ids(hub_con), c("round-1", "round-2"))
})

test_that("get_task_ids works", {
  hub_con <- connect_hub(system.file("hub_1", package = "hubUtils"))
  expect_equal(get_task_ids(hub_con), c("origin_date", "location", "horizon"))

  hub_con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))
  expect_equal(
    get_task_ids(hub_con, round_id = "round-1"),
    c("origin_date", "scenario_id", "location", "target", "horizon")
  )
  expect_equal(
    get_task_ids(hub_con, round_id = "round-2"),
    c(
      "origin_date", "scenario_id", "location", "target", "age_group",
      "horizon"
    )
  )
  expect_snapshot_error(get_task_ids(hub_con, round_id = "random-round-id"))
})

test_that("get_task_id_vals works", {
  hub_con <- connect_hub(system.file("hub_1", package = "hubUtils"))
  expect_snapshot(get_task_id_vals(hub_con, task_id = "location"))
  expect_snapshot(get_task_id_vals(hub_con, task_id = "horizon"))

  hub_con <- connect_hub(system.file("scnr_hub_1", package = "hubUtils"))


  expect_snapshot(get_task_id_vals(hub_con, round_id = "round-1",
                                   task_id = "location"))
  expect_equal(get_task_id_vals(hub_con, round_id = "round-1",
                                task_id = "horizon"),
               1L:2L)
  expect_snapshot_error(get_task_id_vals(hub_con, round_id = "round-2",
                                         task_id = "random_task_id"))
})
