test_that("Errors report launch successful", {
    config_path <- testthat::test_path("testdata", "tasks-errors.json")
    validation <- suppressWarnings(
        validate_config(config_path = config_path)
    )
    set.seed(1)
    skip_on_ci()
    tbl <- view_config_val_errors(validation) %>%
        gt:::render_as_html()
    expect_snapshot(tbl)
})
