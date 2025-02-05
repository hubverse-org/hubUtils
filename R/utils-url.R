#' Create a URL to a file in an S3 bucket
#'
#' @param base_fs character string. Path of the base s3 file system (bucket) in the
#'  cloud. Can be extracted from the object of class `<SubTreeFileSystem>` using the
#'  `$base_fs` field, followed by the `$base_path`.
#' @param base_path character string. Path to the file in relation to `base_fs`.
#' Can be extracted from the object of class `<SubTreeFileSystem>` using the
#'  `$base_path`.
#'
#' @returns A character string of the URL to the file in s3.
#' @export
#'
#' @examples
#' create_s3_url(
#'   base_fs = "hubverse/hubutils/testhubs/simple/",
#'   base_path = "hub-config/admin.json"
#' )
#' @examplesIf asNamespace("hubUtils")$not_rcmd_check() && requireNamespace("arrow", quietly = TRUE)
#' # Create a URL from an object of class `<SubTreeFileSystem>` of an s3 hub
#' hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
#' create_s3_url(hub_path$base_path, "hub-config/admin.json")
#' config_path <- hub_path$path("hub-config/admin.json")
#' # Create a URL from an object of class `<SubTreeFileSystem>` of the path to
#' # a config file in an s3 hub
#' create_s3_url(config_path$base_fs$base_path, config_path$base_path)
create_s3_url <- function(base_fs, base_path) {
  checkmate::assert_character(base_fs, len = 1L)
  checkmate::assert_character(base_path, len = 1L)

  split_base_fs <- stringr::str_split(
    base_fs,
    "/", 2
  ) |>
    unlist()

  glue::glue("https://{split_base_fs[1]}.s3.amazonaws.com/{split_base_fs[2]}/{base_path}") |>
    sanitize_url()
}

#' Determine if a string is a URL
#'
#' @param x character string to check if it is a URL. Must contain a protocol to
#' be considered a URL.
#'
#' @returns Logical. `TRUE` if `x` is a URL, `FALSE` otherwise.
#' @export
#'
#' @examples
#' is_url("https://hubverse.io")
#' is_url("www.hubverse.io")
is_url <- function(x) {
  grepl("^(https?|ftp)://[[:alnum:].-]+\\.[a-z]{2,6}(/.*)?$",
    x,
    ignore.case = TRUE
  )
}

#' Determine if a URL is valid and reachable
#'
#' @param url character string of the URL to check.
#'
#' @returns Logical. `TRUE` if the URL is valid and reachable, `FALSE` otherwise.
#' @export
#'
#' @examples
#' is_valid_url("https://hubverse.io")
#' is_valid_url("https://hubverse.io/invalid")
is_valid_url <- function(url) {
  checkmate::assert_character(url, len = 1L)
  if (!curl::has_internet()) {
    cli::cli_abort("No internet connection.")
  }
  # Try to fetch the URL and check the HTTP status code
  tryCatch(
    {
      response <- curl::curl_fetch_memory(url)
      status_code <- response$status_code

      return(status_code >= 200 && status_code < 400) # TRUE if status is 2xx or 3xx
    },
    error = function(e) {
      return(FALSE) # Return FALSE if request fails
    }
  )
}

#' Detect if a URL is a GitHub repository URL
#'
#' @param url character string of the URL to check.
#'
#' @returns Logical. `TRUE` if the URL is a GitHub repository URL, `FALSE` otherwise.
#' @export
#'
#' @examples
#' is_github_repo_url("https://github.com/hubverse-org/example-simple-forecast-hub")
#' raw_url <- paste0(
#'   "https://raw.githubusercontent.com/hubverse-org/",
#'   "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
#' )
#' is_github_repo_url(raw_url)
#' url_to_blob <- "https://github.com/hubverse-org/example-simple-forecast-hub/blob/main/README.md"
#' is_github_repo_url(url_to_blob)
is_github_repo_url <- function(url) {
  grepl("^https?://(www\\.)?github\\.com/[^/]+/[^/]+/?$", url)
}

# Replace multiple slashes with a single slash except after 'https:' and clean up
# any trailing slashes
sanitize_url <- function(url) {
  out <- gsub("([^:])/{2,}", "\\1/", url)
  gsub("/$", "", out)
}

# Convert a GitHub repo URL to a raw GitHub URL prefix. Input must not contain
# file paths within the repo.
convert_to_raw_github_url <- function(repo_url) {
  url <- sub("github.com", "raw.githubusercontent.com", repo_url)  # Replace domain
  paste(url, "refs/heads/main/", sep = "/") |>
    sanitize_url()
}

# Detect a github URL
is_github_url <- function(url) {
  grepl("^https?://(www\\.)?github\\.com/[^/]+/[^/]+", url)
}
