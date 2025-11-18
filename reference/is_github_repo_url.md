# Detect if a URL is a GitHub repository URL

Detect if a URL is a GitHub repository URL

## Usage

``` r
is_github_repo_url(url)
```

## Arguments

- url:

  character string of the URL to check.

## Value

Logical. `TRUE` if the URL is a GitHub repository URL, `FALSE`
otherwise.

## Examples

``` r
is_github_repo_url("https://github.com/hubverse-org/example-simple-forecast-hub")
#> [1] TRUE
raw_url <- paste0(
  "https://raw.githubusercontent.com/hubverse-org/",
  "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
)
is_github_repo_url(raw_url)
#> [1] FALSE
url_to_blob <- "https://github.com/hubverse-org/example-simple-forecast-hub/blob/main/README.md"
is_github_repo_url(url_to_blob)
#> [1] FALSE
```
