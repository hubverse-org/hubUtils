test_that("create_output_type_point functions work correctly", {
  expect_snapshot(
      create_output_type_mean(is_required = TRUE,
                              value_type = "double",
                              value_minimum = 0L)
      )
    expect_snapshot(
        create_output_type_mean(is_required = FALSE,
                                value_type = "integer",
                                value_maximum = 0L)
    )
    expect_snapshot(
        create_output_type_median(is_required = FALSE,
                                value_type = "numeric")
    )
})


test_that("create_output_type_point functions error correctly", {
    expect_snapshot(
        create_output_type_mean(is_required = "TRUE",
                                value_type = "double"),
        error = TRUE
    )
    expect_snapshot(
        create_output_type_mean(is_required = TRUE,
                                value_type = c("double", "numeric")),
        error = TRUE
    )
    expect_snapshot(
        create_output_type_mean(is_required = FALSE,
                                value_type = "character",
                                value_maximum = 0L),
        error = TRUE
    )
    expect_snapshot(
        create_output_type_median(is_required = FALSE),
        error = TRUE
    )
})
