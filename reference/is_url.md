# Determine if a string is a URL

Determine if a string is a URL

## Usage

``` r
is_url(x)
```

## Arguments

- x:

  character string to check if it is a URL. Must contain a protocol to
  be considered a URL.

## Value

Logical. `TRUE` if `x` is a URL, `FALSE` otherwise.

## Examples

``` r
is_url("https://docs.hubverse.io")
#> [1] TRUE
is_url("www.hubverse.io")
#> [1] FALSE
```
