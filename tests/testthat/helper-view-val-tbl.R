expect_tab <- function(tab) {
  # Expect that the object has the correct classes
  expect_s3_class(tab, "gt_tbl")
  expect_type(tab, "list")

  # Expect certain named attributes
  expect_gt_attr_names(object = tab)

  # Expect that the attribute obejcts are of certain classes
  expect_s3_class(gt:::dt_boxhead_get(data = tab), "data.frame")
  expect_type(gt:::dt_stub_df_get(data = tab), "list")
  expect_type(gt:::dt_row_groups_get(data = tab), "character")
  expect_s3_class(gt:::dt_stub_df_get(data = tab), "data.frame")
  expect_type(gt:::dt_heading_get(data = tab), "list")
  expect_s3_class(gt:::dt_spanners_get(data = tab), "data.frame")
  expect_type(gt:::dt_stubhead_get(data = tab), "list")
  expect_s3_class(gt:::dt_footnotes_get(data = tab), "data.frame")
  expect_type(gt:::dt_source_notes_get(data = tab), "list")
  expect_type(gt:::dt_formats_get(data = tab), "list")
  expect_type(gt:::dt_substitutions_get(data = tab), "list")
  expect_s3_class(gt:::dt_styles_get(data = tab), "data.frame")
  expect_s3_class(gt:::dt_options_get(data = tab), "data.frame")
  expect_type(gt:::dt_transforms_get(data = tab), "list")

  (gt:::dt_boxhead_get(data = tab) %>%
    dim())[2] %>% # nolint: indentation_linter
    expect_equal(8)

  gt:::dt_stub_df_get(data = tab) %>%
    dim() %>%
    expect_equal(c(3, 6))

  gt:::dt_heading_get(data = tab) %>%
    length() %>%
    expect_equal(3)

  gt:::dt_spanners_get(data = tab) %>%
    dim() %>%
    expect_equal(c(3, 8))

  gt:::dt_stubhead_get(data = tab) %>%
    length() %>%
    expect_equal(1)

  gt:::dt_footnotes_get(data = tab) %>%
    dim() %>%
    expect_equal(c(0, 8))

  gt:::dt_source_notes_get(data = tab) %>%
    length() %>%
    expect_equal(1)

  gt:::dt_formats_get(data = tab) %>%
    length() %>%
    expect_equal(1)

  gt:::dt_substitutions_get(data = tab) %>%
    length() %>%
    expect_equal(0)

  gt:::dt_styles_get(data = tab) %>%
    dim() %>%
    expect_equal(c(18, 7))

  gt:::dt_transforms_get(data = tab) %>%
    length() %>%
    expect_equal(0)


  # Expect that extracted df has the same number of
  # rows as the original dataset
  expect_equal(
    tab %>% gt:::dt_data_get() %>% nrow(),
    3
  )

  # Expect specific column names within the `stub_df` object
  expect_equal(
    colnames(gt:::dt_stub_df_get(data = tab)),
    c(
      "rownum_i", "row_id", "group_id", "group_label",
      "indent", "built_group_label"
    )
  )
}


gt_attr_names <- function() {
  c(
    "_data", "_boxhead",
    "_stub_df", "_row_groups",
    "_heading", "_spanners", "_stubhead",
    "_footnotes", "_source_notes", "_formats", "_substitutions", "_styles",
    "_summary", "_options", "_transforms", "_locale", "_has_built"
  )
}

expect_gt_attr_names <- function(object) {
  # The `groups` attribute appears when we call dplyr::group_by()
  # on the input table
  expect_equal(
    sort(names(object)),
    sort(gt_attr_names())
  )
}


recode_font <- function(tbl) {
  tbl_font_nm_idx <- which(tbl$`_options`$parameter == "table_font_names")
  tbl$`_options`$value[[tbl_font_nm_idx]] <- "test-font"

  tbl
}
