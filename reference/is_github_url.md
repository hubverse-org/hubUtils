# Detect a URL on github.com

Detect a URL on github.com

## Usage

``` r
is_github_url(url)
```

## Arguments

- url:

  character string of the URL to check.

## Value

Logical. `TRUE` if the URL on `github.com`, `FALSE` otherwise.

## Examples

``` r
# Returns TRUE
is_github_url("https://github.com/hubverse-org/example-simple-forecast-hub")
#> [1] TRUE
is_github_url("https://github.com/hubverse-org/schemas/tree/main/v5.0.0")
#> [1] TRUE
# Returns FALSE
is_github_url("https://gitlab.com/hubverse-org/schemas/tree/main/v5.0.0")
#> [1] FALSE
raw_url <- paste0(
  "https://raw.githubusercontent.com/hubverse-org/",
  "example-simple-forecast-hub/refs/heads/main/hub-config/tasks.json"
)
is_github_url(raw_url)
#> [1] FALSE
```
