# Determine if a URL is valid and reachable

Determine if a URL is valid and reachable

## Usage

``` r
is_valid_url(url)
```

## Arguments

- url:

  character string of the URL to check.

## Value

Logical. `TRUE` if the URL is valid and reachable, `FALSE` otherwise.

## Examples

``` r
is_valid_url("https://docs.hubverse.io")
#> [1] TRUE
is_valid_url("https://docs.hubverse.io/invalid")
#> [1] FALSE
```
