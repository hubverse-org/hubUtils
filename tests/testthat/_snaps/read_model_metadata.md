# read_model_metadata reads a test hub metadata file

    Code
      read_model_metadata(path)
    Output
      $team_name
      [1] "Team1"
      
      $team_abbr
      [1] "team1"
      
      $model_name
      [1] "Good Model"
      
      $model_abbr
      [1] "goodmodel"
      
      $model_version
      [1] "1.0"
      
      $model_contributors
      $model_contributors[[1]]
      $model_contributors[[1]]$name
      [1] "Joe Bloggs"
      
      $model_contributors[[1]]$email
      [1] "j.bloggs@email.com"
      
      
      $model_contributors[[2]]
      $model_contributors[[2]]$name
      [1] "J Smith"
      
      $model_contributors[[2]]$email
      [1] "j.smith@email.com"
      
      
      
      $website_url
      [1] "https://team1goodmodel.website"
      
      $license
      [1] "cc-by-4.0"
      
      $include_viz
      [1] TRUE
      
      $include_ensemble
      [1] TRUE
      
      $include_eval
      [1] TRUE
      
      $model_details
      $model_details$methods
      [1] "this the method description of the model."
      
      $model_details$data_inputs
      [1] "description of the data imputs"
      
      
      $ensemble_of_hub_models
      [1] FALSE
      

# read_model_metadata errors on a missing or non-YAML file

    Code
      read_model_metadata("missing.yml")
    Condition
      Error in `read_model_metadata()`:
      ! Assertion on 'path' failed: File does not exist: 'missing.yml'.

---

    Code
      read_model_metadata(path)
    Condition
      Error in `read_model_metadata()`:
      ! Assertion on 'path' failed: File extension must be in {'yml','yaml'} (case insensitive), but file name is '<path>'.

