test_that("read_model_metadata reads a test hub metadata file", {
  hub_path <- system.file("testhubs", "simple", package = "hubUtils")
  path <- fs::path(hub_path, "model-metadata", "team1-goodmodel.yaml")
  expect_snapshot(read_model_metadata(path))
})

test_that("read_model_metadata returns arrays as lists", {
  path <- withr::local_tempfile(fileext = ".yml")
  writeLines(
    c(
      'model_abbr: "model"',
      "designated_model: true",
      'methods: ["one method"]',
      'data_sources: ["source one", "source two"]',
      'model_contributors: [{name: "Joe Bloggs", affiliations: ["UMass"]}]'
    ),
    path
  )
  metadata <- read_model_metadata(path)

  expect_identical(metadata$model_abbr, "model")
  expect_identical(metadata$designated_model, TRUE)
  expect_identical(metadata$methods, list("one method"))
  expect_identical(metadata$data_sources, list("source one", "source two"))
  expect_identical(
    metadata$model_contributors,
    list(list(name = "Joe Bloggs", affiliations = list("UMass")))
  )
})

test_that("read_model_metadata errors on a missing or non-YAML file", {
  expect_snapshot(
    read_model_metadata("missing.yml"),
    error = TRUE
  )
  path <- withr::local_tempfile(fileext = ".json")
  writeLines("{}", path)
  expect_snapshot(
    read_model_metadata(path),
    error = TRUE,
    transform = function(x) sub(path, "<path>", x, fixed = TRUE)
  )
})
