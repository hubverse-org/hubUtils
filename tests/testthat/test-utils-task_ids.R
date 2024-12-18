test_that("subset_task_id_names works", {
  x <- c(
    "origin_date", "horizon", "target_date",
    "location", "output_type", "output_type_id", "value"
  )
  subset_task_id_names(x)
  expect_equal(
    subset_task_id_names(x),
    c("origin_date", "horizon", "target_date", "location")
  )
  expect_length(
    subset_task_id_names(std_colnames),
    0L
  )
  expect_error(
    subset_task_id_names(1L),
    regexp = "Assertion on 'x' failed: Must be of type 'character', not 'integer'."
  )
})
