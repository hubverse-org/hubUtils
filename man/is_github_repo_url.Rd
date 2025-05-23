% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-url.R
\name{is_github_repo_url}
\alias{is_github_repo_url}
\title{Detect if a URL is a GitHub repository URL}
\usage{
is_github_repo_url(url)
}
\arguments{
\item{url}{character string of the URL to check.}
}
\value{
Logical. \code{TRUE} if the URL is a GitHub repository URL, \code{FALSE} otherwise.
}
\description{
Detect if a URL is a GitHub repository URL
}
\examples{
is_github_repo_url("https://github.com/hubverse-org/example-simple-forecast-hub")
raw_url <- paste0(
  "https://raw.githubusercontent.com/hubverse-org/",
  "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
)
is_github_repo_url(raw_url)
url_to_blob <- "https://github.com/hubverse-org/example-simple-forecast-hub/blob/main/README.md"
is_github_repo_url(url_to_blob)
}
