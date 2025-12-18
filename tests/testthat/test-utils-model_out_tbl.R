test_that("subsetting model_out_tbls works", {
  model_out_tbl_path <- system.file(
    "testhubs",
    "v4",
    "simple",
    "model-output",
    "hub-baseline",
    "2022-10-15-hub-baseline.parquet",
    package = "hubUtils"
  )
  model_out_tbl <- arrow::read_parquet(model_out_tbl_path) |>
    tibble::add_column(model_id = "hub-baseline", .before = 1L) |>
    as_model_out_tbl()

  subset_task_ids <- subset_task_id_cols(model_out_tbl)
  expect_equal(
    names(subset_task_ids),
    c("origin_date", "target", "horizon", "location", "age_group")
  )
  expect_equal(nrow(subset_task_ids), nrow(model_out_tbl))
  expect_s3_class(subset_task_ids, class(model_out_tbl), exact = TRUE)

  subset_std <- subset_std_cols(model_out_tbl)
  expect_equal(
    names(subset_std),
    c("model_id", "output_type", "output_type_id", "value")
  )
  expect_equal(nrow(subset_std), nrow(model_out_tbl))
  expect_s3_class(subset_std, class(model_out_tbl), exact = TRUE)

  # Ensure zero column objects returned when input contains no relevant columns
  expect_length(subset_task_id_cols(subset_std), 0L)
  expect_length(subset_std_cols(subset_task_ids), 0L)
})

test_that("subsetting submission tbls works", {
  tbl_path <- system.file(
    "testhubs",
    "v4",
    "simple",
    "model-output",
    "hub-baseline",
    "2022-10-15-hub-baseline.parquet",
    package = "hubUtils"
  )
  tbl <- arrow::read_parquet(tbl_path)
  subset_task_ids <- subset_task_id_cols(tbl)
  expect_equal(
    names(subset_task_ids),
    c("origin_date", "target", "horizon", "location", "age_group")
  )
  expect_equal(nrow(subset_task_ids), nrow(tbl))
  expect_s3_class(subset_task_ids, class(tbl))

  subset_std <- subset_std_cols(tbl)
  expect_equal(
    names(subset_std),
    c("output_type", "output_type_id", "value")
  )
  expect_equal(nrow(subset_std), nrow(tbl))
  expect_s3_class(subset_std, class(tbl))

  # Ensure zero column objects returned when input contains no relevant columns
  expect_length(subset_task_id_cols(subset_std), 0L)
  expect_length(subset_std_cols(subset_task_ids), 0L)
})
