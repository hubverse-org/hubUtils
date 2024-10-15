# as_config succeeds with valid config

    Code
      as_config(config_tasks)
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "nowcast_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$nowcast_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$nowcast_date$required
      [1] "2024-09-11"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$nowcast_date$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$target_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$target_date$optional
      [1] "2024-09-11" "2024-09-04" "2024-08-28" "2024-08-21"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
       [1] "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "DC" "FL" "GA" "HI" "ID" "IL" "IN"
      [16] "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH"
      [31] "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX" "UT"
      [46] "VT" "VA" "WA" "WV" "WI" "WY" "PR"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$variant
      $rounds[[1]]$model_tasks[[1]]$task_ids$variant$required
      [1] "24A"         "24B"         "24C"         "other"       "recombinant"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$variant$optional
      NULL
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$sample
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$is_required
      [1] FALSE
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$type
      [1] "character"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$max_length
      [1] 15
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$min_samples_per_task
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$output_type_id_params$max_samples_per_task
      [1] 500
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$minimum
      [1] 0
      
      $rounds[[1]]$model_tasks[[1]]$output_type$sample$value$maximum
      [1] 1
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "variant prop"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly nowcasted variant proportions"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "proportion"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "compositional"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "nowcast_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -7
      
      $rounds[[1]]$submissions_due$end
      [1] 1
      
      
      
      
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"class")
      [1] "config" "list"  

# invalid schema_id flagged

    Code
      as_config(config_tasks)
    Condition
      Error in `as_config()`:
      x Invalid schema_version property. Should start with: "https://raw.githubusercontent.com/hubverse-org/schemas/main/"

# invalid config_tasks properties flagged

    Code
      as_config(config_tasks)
    Condition
      Error in `as_config()`:
      x Invalid properties in `config_list`: "random_property"
      ! Must be members of "schema_version", "rounds", and "output_type_id_datatype"

