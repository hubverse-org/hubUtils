test_that("is_url works", {
  expect_true(is_url("https://hubverse.io"))
  expect_false(is_url("www.hubverse.io"))
})

test_that("is_valid_url works", {
  skip_if_offline()
  expect_true(is_valid_url("https://hubverse.io"))
  expect_true(
    is_valid_url(
      "https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json"
    )
  )
  expect_false(is_valid_url("https://hubverse.io/invalid"))
  expect_false(
    is_valid_url(
      "https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/random-file"
    )
  )
})

test_that("create_s3_url works", {
  skip_if_offline()
  skip_if_not(arrow::arrow_with_s3())

  expect_equal(
    create_s3_url(
      base_fs = "hubverse/hubutils/testhubs/simple/",
      base_path = "hub-config/admin.json"
    ),
    "https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json"
  )

  hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
  expect_equal(
    create_s3_url(
      base_fs = hub_path$base_path,
      base_path = "hub-config/admin.json"
    ),
    "https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json"
  )

  config_path <- hub_path$path("hub-config/admin.json")
  # Create a URL from an object of class `<SubTreeFileSystem>` of the path to
  # a config file in an s3 hub
  expect_equal(
    create_s3_url(
      base_fs = config_path$base_fs$base_path,
      base_path = config_path$base_path
    ),
    "https://hubverse.s3.amazonaws.com/hubutils/testhubs/simple/hub-config/admin.json"
  )

  expect_error(
    create_s3_url(base_fs = c(
      "hubverse/hubutils/testhubs/simple/",
      "hubverse/hubutils/testhubs/complex/"
    ), base_path = "hub-config/admin.json"),
    regexp = "Assertion on 'base_fs' failed: Must have length 1, but has length 2."
  )

  expect_error(
    create_s3_url(
      base_fs = 1L,
      base_path = "hub-config/admin.json"
    ),
    regexp = "Assertion on 'base_fs' failed: Must be of type 'character', not 'integer'."
  )
})
