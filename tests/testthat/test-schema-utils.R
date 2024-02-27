test_that("Schema URL created successfully", {
    schema_url <- get_schema_url("tasks", "v0.0.1")
    expect_true(valid_url(schema_url))
    expect_equal(
        schema_url,
        "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"
    )
})

test_that("Invalid branches fail successfully", {
    expect_error(get_schema_url("tasks", "v0.0.1", branch = "random-branch"),
                 regexp = "is not a valid branch in schema repository"
    )
})

test_that("Valid json schema versions detected successfully", {
    expect_equal(
        get_schema_valid_versions(branch = "hubUtils-test"),
        c("v0.0.0.8", "v0.0.0.9")
    )
})
