test_that("create_task_ids functions work correctly", {
  expect_snapshot(
    create_task_ids(
      create_task_id("origin_date",
        required = NULL,
        optional = c(
          "2023-01-02",
          "2023-01-09",
          "2023-01-16"
        )
      ),
      create_task_id("scenario_id",
        required = NULL,
        optional = c(
          "A-2021-03-28",
          "B-2021-03-28"
        )
      ),
      create_task_id("location",
        required = "US",
        optional = c("01", "02", "04", "05", "06")
      ),
      create_task_id("target",
        required = "inc hosp",
        optional = NULL
      ),
      create_task_id("horizon",
        required = 1L,
        optional = 2:4
      )
    )
  )
})


test_that("create_task_ids functions error correctly", {
  expect_snapshot(
    create_task_ids(
      create_task_id("origin_date",
        required = NULL,
        optional = c(
          "2023-01-02",
          "2023-01-09",
          "2023-01-16"
        )
      ),
      create_task_id("origin_date",
        required = NULL,
        optional = c(
          "2023-01-02",
          "2023-01-09",
          "2023-01-16"
        )
      )
    ),
    error = TRUE
  )

  expect_snapshot(
    create_task_ids(
      create_task_id("origin_date",
        required = NULL,
        optional = c(
          "2023-01-02",
          "2023-01-09",
          "2023-01-16"
        )
      ),
      list(a = 10),
      list(b = 10)
    ),
    error = TRUE
  )

  item_1 <- create_task_id("origin_date",
    required = NULL,
    optional = c(
      "2023-01-02",
      "2023-01-09",
      "2023-01-16"
    )
  )
  attr(item_1, "schema_id") <- "invalid_schema"
  expect_snapshot(
    create_task_ids(
      item_1,
      create_task_id("scenario_id",
        required = NULL,
        optional = c(
          "A-2021-03-28",
          "B-2021-03-28"
        )
      )
    ),
    error = TRUE
  )
})
