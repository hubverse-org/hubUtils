test_that("create_task_id works correctly", {
  expect_snapshot(create_task_id("horizon",
    required = 1L,
    optional = 2:4
  ))

  expect_snapshot(create_task_id("origin_date",
    required = NULL,
    optional = c(
      "2023-01-02",
      "2023-01-09",
      "2023-01-16"
    )
  ))
  expect_snapshot(create_task_id("scenario_id",
    required = NULL,
    optional = c(
      "A-2021-03-28",
      "B-2021-03-28"
    )
  ))
  expect_snapshot(create_task_id("scenario_id",
    required = NULL,
    optional = c(
      1L,
      2L
    )
  ))
})


test_that("create_task_id errors correctly", {
  expect_snapshot(
    create_task_id("horizon",
      required = NULL,
      optional = NULL
    ),
    error = TRUE
  )

  expect_snapshot(
    create_task_id("origin_date",
      required = NULL,
      optional = c("01/20/2023")
    ),
    error = TRUE
  )
  expect_snapshot(
    create_task_id("scenario_id",
      required = NULL,
      optional = c(
        1L,
        1L
      )
    ),
    error = TRUE
  )
  expect_snapshot(
    create_task_id("horizon",
      required = c(TRUE, FALSE),
      optional = NULL
    ),
    error = TRUE
  )
})

test_that("create_task_id name matching works correctly", {
  expect_equal(
    names(
      suppressMessages(
        create_task_id("scenario_ids",
          required = NULL,
          optional = c(
            "A-2021-03-28",
            "B-2021-03-28"
          )
        )
      )
    ),
    "scenario_id"
  )

  mockery::stub(match_element_name, "utils::askYesNo", FALSE)
  expect_equal(
    match_element_name("scenario_ids", "scenario_id", "task_id"),
    "scenario_ids"
  )

  mockery::stub(match_element_name, "utils::askYesNo", NA)
  expect_error(match_element_name("scenario_ids", "scenario_id", "task_id"))
})
