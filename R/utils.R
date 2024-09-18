# avoid running examples on R CMD check
# by Gábor Csárdi 2024-09-11
is_rcmd_check <- function() {
  if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    FALSE
  } else {
    Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != ""
  }
}

not_rcmd_check <- function() !is_rcmd_check()
