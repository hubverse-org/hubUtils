# Source https://stackoverflow.com/questions/52911812/check-if-url-exists-in-r
valid_url <- function(url_in, t = 2) {
  con <- url(url_in)
  check <- suppressWarnings(
    try(open.connection(con, open = "rt", timeout = t), silent = TRUE)[1]
  )
  suppressWarnings(try(close.connection(con), silent = TRUE))
  ifelse(is.null(check), TRUE, FALSE)
}
