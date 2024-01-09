# create_round functions work correctly

    Code
      create_round(round_id_from_variable = FALSE, round_id = "round_1", model_tasks = model_tasks,
        submissions_due = list(start = "2023-01-12", end = "2023-01-18"),
        last_data_date = "2023-01-02")
    Output
      $round_id_from_variable
      [1] FALSE
      
      $round_id
      [1] "round_1"
      
      $model_tasks
      $model_tasks[[1]]
      $model_tasks[[1]]$task_ids
      $model_tasks[[1]]$task_ids$origin_date
      $model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $model_tasks[[1]]$task_ids$location
      $model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $model_tasks[[1]]$task_ids$horizon
      $model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $model_tasks[[1]]$output_type
      $model_tasks[[1]]$output_type$mean
      $model_tasks[[1]]$output_type$mean$output_type_id
      $model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $model_tasks[[1]]$output_type$mean$value
      $model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $model_tasks[[1]]$target_metadata
      $model_tasks[[1]]$target_metadata[[1]]
      $model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $submissions_due
      $submissions_due$start
      [1] "2023-01-12"
      
      $submissions_due$end
      [1] "2023-01-18"
      
      
      $last_data_date
      [1] "2023-01-02"
      
      attr(,"class")
      [1] "round" "list" 
      attr(,"round_id")
      [1] "round_1"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_round(round_id_from_variable = TRUE, round_id = "origin_date",
        model_tasks = model_tasks, submissions_due = list(relative_to = "origin_date",
          start = -4L, end = 2L), last_data_date = "2023-01-02")
    Output
      $round_id_from_variable
      [1] TRUE
      
      $round_id
      [1] "origin_date"
      
      $model_tasks
      $model_tasks[[1]]
      $model_tasks[[1]]$task_ids
      $model_tasks[[1]]$task_ids$origin_date
      $model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $model_tasks[[1]]$task_ids$location
      $model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $model_tasks[[1]]$task_ids$horizon
      $model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $model_tasks[[1]]$output_type
      $model_tasks[[1]]$output_type$mean
      $model_tasks[[1]]$output_type$mean$output_type_id
      $model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $model_tasks[[1]]$output_type$mean$value
      $model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $model_tasks[[1]]$target_metadata
      $model_tasks[[1]]$target_metadata[[1]]
      $model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $submissions_due
      $submissions_due$relative_to
      [1] "origin_date"
      
      $submissions_due$start
      [1] -4
      
      $submissions_due$end
      [1] 2
      
      
      $last_data_date
      [1] "2023-01-02"
      
      attr(,"class")
      [1] "round" "list" 
      attr(,"round_id")
      [1] "origin_date"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_round name matching works correctly

    Code
      create_round(round_id_from_variable = FALSE, round_id = "round_1", model_tasks = model_tasks,
        submissions_due = list(start = "01/12/2023", end = "2023-01-18"),
        last_data_date = "2023-01-02")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_round()`:
      x `start` value must be character string of date in valid ISO 8601 format (YYYY-MM-DD).

---

    Code
      create_round(round_id_from_variable = FALSE, round_id = "round_1", model_tasks = model_tasks,
        submissions_due = list(start = -4L, end = 2), last_data_date = "2023-01-02")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_round()`:
      x `start` value must be character string of date in valid ISO 8601 format (YYYY-MM-DD). Date object format not accepted. Consider using `as.character()` to convert to character.

---

    Code
      create_round(round_id_from_variable = TRUE, round_id = "origin_dates",
        model_tasks = model_tasks, submissions_due = list(relative_to = "origin_date",
          start = -4L, end = 2L), last_data_date = "2023-01-02")
    Condition
      Error in `create_round()`:
      ! `round_id` value must correspond to a valid `task_id` variable in every `model_task` object.
      x `round_id` value "origin_dates" does not correspond to a valid variable in provided `model_tasks` `model_task` object 1.

---

    Code
      create_round(round_id_from_variable = TRUE, round_id = "origin_date",
        model_tasks = model_tasks, submissions_due = list(relative = "origin_date",
          start = -4L, end = 2L), last_data_date = "2023-01-02")
    Condition
      Error in `create_round()`:
      x Property "relative" in `submissions_due` is invalid.
      ! Valid `submissions_due` properties: "relative_to", "start", and "end"

---

    Code
      create_round(round_id_from_variable = TRUE, round_id = "origin_date",
        model_tasks = "model_tasks", submissions_due = list(relative_to = "origin_date",
          start = -4L, end = 2L), last_data_date = "2023-01-02")
    Condition
      Error in `create_round()`:
      x `model_tasks` must inherit from class <model_tasks> but does not

