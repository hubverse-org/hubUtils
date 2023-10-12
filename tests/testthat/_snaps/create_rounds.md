# create_rounds functions work correctly

    Code
      create_rounds(create_round(round_id_from_variable = TRUE, round_id = "origin_date",
        model_tasks = model_tasks, submissions_due = list(relative_to = "origin_date",
          start = -4L, end = 2L)))
    Output
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
      [1] "rounds" "list"  
      attr(,"n")
      [1] 1
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_rounds(create_round(round_id_from_variable = FALSE, round_id = "round_1",
        model_tasks = create_model_tasks(create_model_task(task_ids = create_task_ids(
          create_task_id("origin_date", required = NULL, optional = c("2023-01-09")),
          create_task_id("location", required = "US", optional = c("01", "02", "04",
            "05", "06")), create_task_id("horizon", required = 1L, optional = 2:4)),
        output_type = create_output_type(create_output_type_mean(is_required = TRUE,
          value_type = "double", value_minimum = 0L)), target_metadata = create_target_metadata(
          create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
            target_units = "rate per 100,000 population", target_keys = NULL,
            target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))),
        submissions_due = list(start = "2023-01-05", end = "2023-01-11"),
        last_data_date = "2023-01-06"), create_round(round_id_from_variable = FALSE,
        round_id = "round_2", model_tasks = create_model_tasks(create_model_task(
          task_ids = create_task_ids(create_task_id("origin_date", required = NULL,
            optional = c("2023-01-16")), create_task_id("location", required = "US",
            optional = c("01", "02", "04", "05", "06")), create_task_id("horizon",
            required = 1L, optional = 2:4)), output_type = create_output_type(
            create_output_type_mean(is_required = TRUE, value_type = "double",
              value_minimum = 0L)), target_metadata = create_target_metadata(
            create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
              target_units = "rate per 100,000 population", target_keys = NULL,
              target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))),
        submissions_due = list(start = "2023-01-12", end = "2023-01-18"),
        last_data_date = "2023-01-13"))
    Output
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] FALSE
      
      $rounds[[1]]$round_id
      [1] "round_1"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-09"
      
      
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
      $rounds[[1]]$submissions_due$start
      [1] "2023-01-05"
      
      $rounds[[1]]$submissions_due$end
      [1] "2023-01-11"
      
      
      $rounds[[1]]$last_data_date
      [1] "2023-01-06"
      
      
      $rounds[[2]]
      $rounds[[2]]$round_id_from_variable
      [1] FALSE
      
      $rounds[[2]]$round_id
      [1] "round_2"
      
      $rounds[[2]]$model_tasks
      $rounds[[2]]$model_tasks[[1]]
      $rounds[[2]]$model_tasks[[1]]$task_ids
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-16"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[2]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type
      $rounds[[2]]$model_tasks[[1]]$output_type$mean
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[2]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[2]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[2]]$submissions_due
      $rounds[[2]]$submissions_due$start
      [1] "2023-01-12"
      
      $rounds[[2]]$submissions_due$end
      [1] "2023-01-18"
      
      
      $rounds[[2]]$last_data_date
      [1] "2023-01-13"
      
      
      
      attr(,"class")
      [1] "rounds" "list"  
      attr(,"n")
      [1] 2
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_round errors correctly

    Code
      create_rounds(round_1, round_1)
    Condition
      Error in `collect_items()`:
      x <round> object 2 is a duplicate of object 1

