# create_config functions work correctly

    Code
      create_config(rounds)
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
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -4
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      
      attr(,"class")
      [1] "config" "list"  
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_config functions error correctly

    Code
      create_config(list(a = 10))
    Condition
      Error in `create_config()`:
      x `rounds` must inherit from class <rounds> but does not

