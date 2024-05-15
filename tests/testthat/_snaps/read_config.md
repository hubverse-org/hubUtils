# read_config works on local hubs

    Code
      read_config(hub_path = system.file("testhubs", "simple", package = "hubUtils"))
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2022-10-01" "2022-10-08"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "integer"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$type
      [1] "integer"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -6
      
      $rounds[[1]]$submissions_due$end
      [1] 1
      
      
      
      $rounds[[2]]
      $rounds[[2]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[2]]$round_id
      [1] "origin_date"
      
      $rounds[[2]]$model_tasks
      $rounds[[2]]$model_tasks[[1]]
      $rounds[[2]]$model_tasks[[1]]$task_ids
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2022-10-15" "2022-10-22" "2022-10-29"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$target
      $rounds[[2]]$model_tasks[[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$target$optional
      NULL
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$required
      [1] "65+"
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$optional
      [1] "0-5"   "6-18"  "19-24" "25-64"
      
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type
      $rounds[[2]]$model_tasks[[1]]$output_type$mean
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "integer"
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$type
      [1] "integer"
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[2]]$submissions_due
      $rounds[[2]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[2]]$submissions_due$start
      [1] -6
      
      $rounds[[2]]$submissions_due$end
      [1] 1
      
      
      
      

---

    Code
      read_config(hub_path = system.file("testhubs", "simple", package = "hubUtils"),
      config = "admin")
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/admin-schema.json"
      
      $name
      [1] "Simple Forecast Hub"
      
      $maintainer
      [1] "Consortium of Infectious Disease Modeling Hubs"
      
      $contact
      $contact$name
      [1] "Joe Bloggs"
      
      $contact$email
      [1] "j.bloggs@cidmh.com"
      
      
      $repository_url
      [1] "https://github.com/Infectious-Disease-Modeling-Hubs/example-simple-forecast-hub"
      
      $hub_models
      $hub_models[[1]]
      $hub_models[[1]]$team_abbr
      [1] "simple_hub"
      
      $hub_models[[1]]$model_abbr
      [1] "baseline"
      
      $hub_models[[1]]$model_type
      [1] "baseline"
      
      
      
      $file_format
      [1] "csv"     "parquet" "arrow"  
      
      $timezone
      [1] "US/Eastern"
      

---

    Code
      read_config(hub_path = system.file("testhubs", "simple", package = "hubUtils"),
      config = "model-metadata-schema")
    Output
      $`$schema`
      [1] "http://json-schema.org/draft-07/schema"
      
      $title
      [1] "ForecastHub model metadata"
      
      $description
      [1] "This is the schema of the model metadata file."
      
      $type
      [1] "object"
      
      $properties
      $properties$team_name
      $properties$team_name$description
      [1] "The name of the team submitting the model"
      
      $properties$team_name$type
      [1] "string"
      
      
      $properties$team_abbr
      $properties$team_abbr$description
      [1] "Abbreviated name of the team submitting the model"
      
      $properties$team_abbr$type
      [1] "string"
      
      $properties$team_abbr$pattern
      [1] "^[a-zA-Z0-9_+]+$"
      
      $properties$team_abbr$maxLength
      [1] 16
      
      
      $properties$model_name
      $properties$model_name$description
      [1] "The name of the model"
      
      $properties$model_name$type
      [1] "string"
      
      
      $properties$model_abbr
      $properties$model_abbr$description
      [1] "Abbreviated name of the model"
      
      $properties$model_abbr$type
      [1] "string"
      
      $properties$model_abbr$pattern
      [1] "^[a-zA-Z0-9_+]+$"
      
      $properties$model_abbr$maxLength
      [1] 16
      
      
      $properties$model_version
      $properties$model_version$description
      [1] "Identifier of the version of the model"
      
      $properties$model_version$type
      [1] "string"
      
      
      $properties$model_contributors
      $properties$model_contributors$type
      [1] "array"
      
      $properties$model_contributors$items
      $properties$model_contributors$items$type
      [1] "object"
      
      $properties$model_contributors$items$properties
      $properties$model_contributors$items$properties$name
      $properties$model_contributors$items$properties$name$type
      [1] "string"
      
      
      $properties$model_contributors$items$properties$email
      $properties$model_contributors$items$properties$email$type
      [1] "string"
      
      $properties$model_contributors$items$properties$email$format
      [1] "email"
      
      
      $properties$model_contributors$items$properties$twitter
      $properties$model_contributors$items$properties$twitter$type
      [1] "string"
      
      
      
      $properties$model_contributors$items$additionalProperties
      [1] FALSE
      
      $properties$model_contributors$items$required
      [1] "name"  "email"
      
      
      
      $properties$website_url
      $properties$website_url$description
      [1] "Public facing website for the model"
      
      $properties$website_url$type
      [1] "string"
      
      $properties$website_url$format
      [1] "uri"
      
      
      $properties$repo_url
      $properties$repo_url$description
      [1] "Repository containing code for the model"
      
      $properties$repo_url$type
      [1] "string"
      
      $properties$repo_url$format
      [1] "uri"
      
      
      $properties$license
      $properties$license$description
      [1] "License for use of model output data"
      
      $properties$license$type
      [1] "string"
      
      $properties$license$enum
      [1] "apache-2.0"      "cc-by-4.0"       "cc-by-nc-4.0"    "cc-by-nc-nd-4.0"
      [5] "cc-by-sa-4.0"    "gpl-3.0"         "lgpl-3.0"        "mit"            
      
      
      $properties$include_viz
      $properties$include_viz$description
      [1] "Indicator for whether the model should be included in the Hub’s visualization"
      
      $properties$include_viz$type
      [1] "boolean"
      
      
      $properties$include_ensemble
      $properties$include_ensemble$description
      [1] "Indicator for whether the model should be included in the Hub’s ensemble"
      
      $properties$include_ensemble$type
      [1] "boolean"
      
      
      $properties$include_eval
      $properties$include_eval$description
      [1] "Indicator for whether the model should be scored for inclusion in the Hub’s evaluations"
      
      $properties$include_eval$type
      [1] "boolean"
      
      
      $properties$model_details
      $properties$model_details$type
      [1] "object"
      
      $properties$model_details$properties
      $properties$model_details$properties$data_inputs
      $properties$model_details$properties$data_inputs$type
      [1] "string"
      
      
      $properties$model_details$properties$methods
      $properties$model_details$properties$methods$type
      [1] "string"
      
      $properties$model_details$properties$methods$maxLength
      [1] 200
      
      
      $properties$model_details$properties$methods_long
      $properties$model_details$properties$methods_long$type
      [1] "string"
      
      
      
      $properties$model_details$additionalProperties
      [1] FALSE
      
      $properties$model_details$required
      [1] "data_inputs" "methods"    
      
      
      $properties$ensemble_of_hub_models
      $properties$ensemble_of_hub_models$description
      [1] "Indicator for whether this model is an ensemble of other Hub models"
      
      $properties$ensemble_of_hub_models$type
      [1] "boolean"
      
      
      
      $additionalProperties
      [1] FALSE
      
      $required
       [1] "team_name"          "team_abbr"          "model_name"        
       [4] "model_abbr"         "model_contributors" "website_url"       
       [7] "license"            "include_viz"        "include_ensemble"  
      [10] "include_eval"       "model_details"     
      

# read_config works on S3 cloud hubs

    Code
      read_config(hub_path = hubData::s3_bucket("hubverse/hubutils/testhubs/simple/"))
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2022-10-01" "2022-10-08"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "integer"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$type
      [1] "integer"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -6
      
      $rounds[[1]]$submissions_due$end
      [1] 1
      
      
      
      $rounds[[2]]
      $rounds[[2]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[2]]$round_id
      [1] "origin_date"
      
      $rounds[[2]]$model_tasks
      $rounds[[2]]$model_tasks[[1]]
      $rounds[[2]]$model_tasks[[1]]$task_ids
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2022-10-15" "2022-10-22" "2022-10-29"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$target
      $rounds[[2]]$model_tasks[[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$target$optional
      NULL
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$required
      [1] "65+"
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$age_group$optional
      [1] "0-5"   "6-18"  "19-24" "25-64"
      
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type
      $rounds[[2]]$model_tasks[[1]]$output_type$mean
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "integer"
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$type
      [1] "integer"
      
      $rounds[[2]]$model_tasks[[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[2]]$submissions_due
      $rounds[[2]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[2]]$submissions_due$start
      [1] -6
      
      $rounds[[2]]$submissions_due$end
      [1] 1
      
      
      
      

# read_config_file works

    Code
      read_config_file(system.file("config", "tasks.json", package = "hubUtils"))
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v3.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "forecast_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$forecast_date$optional
       [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
       [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
      [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
      [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
      [21] "2023-05-01" "2023-05-08" "2023-05-15"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target$optional
      [1] "wk ahead inc flu hosp"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 2
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 1
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02"
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$sample
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$is_required
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$type
      [1] "character"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$min_samples_per_task
      [1] 50
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$max_samples_per_task
      [1] 100
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$type
      [1] "integer"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$minimum
      [1] 0
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "wk ahead inc flu hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "weekly influenza hospitalization incidence"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk ahead inc flu hosp"
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$description
      [1] "This target represents the counts of new hospitalizations per horizon week."
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      $rounds[[1]]$model_tasks[[2]]
      $rounds[[1]]$model_tasks[[2]]$task_ids
      $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date
      $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$forecast_date$optional
       [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
       [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
      [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
      [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
      [21] "2023-05-01" "2023-05-08" "2023-05-15"
      
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$target
      $rounds[[1]]$model_tasks[[2]]$task_ids$target$required
      NULL
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$target$optional
      [1] "wk flu hosp rate change"
      
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[2]]$task_ids$horizon$required
      [1] 2
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$horizon$optional
      [1] 1
      
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$location
      $rounds[[1]]$model_tasks[[2]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[2]]$task_ids$location$optional
      [1] "01" "02"
      
      
      
      $rounds[[1]]$model_tasks[[2]]$output_type
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id$required
      [1] "large_decrease" "decrease"       "stable"         "increase"      
      [5] "large_increase"
      
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$minimum
      [1] 0
      
      $rounds[[1]]$model_tasks[[2]]$output_type$pmf$value$maximum
      [1] 1
      
      
      
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_id
      [1] "wk flu hosp rate change"
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_name
      [1] "weekly influenza hospitalization rate change"
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_keys
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_keys$target
      [1] "wk flu hosp rate change"
      
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$target_type
      [1] "nominal"
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$description
      [1] "This target represents the change in the rate of new hospitalizations per week comparing the week ending two days prior to the forecast_date to the week ending h weeks after the forecast_date."
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[2]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "forecast_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -6
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      

