# Read a model metadata file into R

Reads a model metadata YAML file into a named list.

## Usage

``` r
read_model_metadata(path)
```

## Arguments

- path:

  A character string of the path to a local model metadata YAML file.

## Value

The contents of the metadata file as a named list, or `NULL` for an
empty file.

## Details

Every array in the file is returned as a list, including an array with a
single element. For example, `methods: ["one"]` is returned as
`list("one")` and not as the string `"one"`.

## Examples

``` r
hub_path <- system.file("testhubs/simple", package = "hubUtils")
path <- fs::path(hub_path, "model-metadata", "team1-goodmodel.yaml")
read_model_metadata(path)
#> $team_name
#> [1] "Team1"
#> 
#> $team_abbr
#> [1] "team1"
#> 
#> $model_name
#> [1] "Good Model"
#> 
#> $model_abbr
#> [1] "goodmodel"
#> 
#> $model_version
#> [1] "1.0"
#> 
#> $model_contributors
#> $model_contributors[[1]]
#> $model_contributors[[1]]$name
#> [1] "Joe Bloggs"
#> 
#> $model_contributors[[1]]$email
#> [1] "j.bloggs@email.com"
#> 
#> 
#> $model_contributors[[2]]
#> $model_contributors[[2]]$name
#> [1] "J Smith"
#> 
#> $model_contributors[[2]]$email
#> [1] "j.smith@email.com"
#> 
#> 
#> 
#> $website_url
#> [1] "https://team1goodmodel.website"
#> 
#> $license
#> [1] "cc-by-4.0"
#> 
#> $include_viz
#> [1] TRUE
#> 
#> $include_ensemble
#> [1] TRUE
#> 
#> $include_eval
#> [1] TRUE
#> 
#> $model_details
#> $model_details$methods
#> [1] "this the method description of the model."
#> 
#> $model_details$data_inputs
#> [1] "description of the data imputs"
#> 
#> 
#> $ensemble_of_hub_models
#> [1] FALSE
#> 
```
