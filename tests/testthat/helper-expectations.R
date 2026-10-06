# Expect `object` to throw an error whose message contains `message` and whose
# call names the function `call_name`.
expect_error_named <- function(object, call_name, message) {
  err <- testthat::expect_error({{ object }}, message, fixed = TRUE)
  testthat::expect_identical(rlang::call_name(err$call), call_name)
  invisible(err)
}
