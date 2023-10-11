# create_model_task functions work correctly

    Code
      create_model_task(task_ids = create_task_ids(create_task_id("origin_date",
        required = NULL, optional = c("2023-01-02", "2023-01-09", "2023-01-16")),
      create_task_id("location", required = "US", optional = c("01", "02", "04", "05",
        "06")), create_task_id("horizon", required = 1L, optional = 2:4)),
      output_type = create_output_type(create_output_type_mean(is_required = TRUE,
        value_type = "double", value_minimum = 0L)), target_metadata = create_target_metadata(
        create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population", target_keys = NULL,
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))
    Output
      $task_ids
      $task_ids$origin_date
      $task_ids$origin_date$required
      NULL
      
      $task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $task_ids$location
      $task_ids$location$required
      [1] "US"
      
      $task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $task_ids$horizon
      $task_ids$horizon$required
      [1] 1
      
      $task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $output_type
      $output_type$mean
      $output_type$mean$output_type_id
      $output_type$mean$output_type_id$required
      [1] NA
      
      $output_type$mean$output_type_id$optional
      NULL
      
      
      $output_type$mean$value
      $output_type$mean$value$type
      [1] "double"
      
      $output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $target_metadata
      $target_metadata[[1]]
      $target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $target_metadata[[1]]$target_keys
      NULL
      
      $target_metadata[[1]]$target_type
      [1] "discrete"
      
      $target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      attr(,"class")
      [1] "model_task" "list"      
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_model_task(task_ids = create_task_ids(create_task_id("origin_date",
        required = NULL, optional = c("2023-01-02", "2023-01-09", "2023-01-16")),
      create_task_id("location", required = "US", optional = c("01", "02", "04", "05",
        "06")), create_task_id("target", required = NULL, optional = c("inc death",
        "inc hosp")), create_task_id("horizon", required = 1L, optional = 2:4)),
      output_type = create_output_type(create_output_type_mean(is_required = TRUE,
        value_type = "double", value_minimum = 0L), create_output_type_median(
        is_required = FALSE, value_type = "double"), create_output_type_quantile(
        required = c(0.25, 0.5, 0.75), optional = c(0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8,
          0.9), value_type = "double", value_minimum = 0)), target_metadata = create_target_metadata(
        create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"),
        create_target_metadata_item(target_id = "inc death", target_name = "Weekly incident influenza deaths",
          target_units = "rate per 100,000 population", target_keys = list(target = "inc death"),
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))
    Output
      $task_ids
      $task_ids$origin_date
      $task_ids$origin_date$required
      NULL
      
      $task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $task_ids$location
      $task_ids$location$required
      [1] "US"
      
      $task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $task_ids$target
      $task_ids$target$required
      NULL
      
      $task_ids$target$optional
      [1] "inc death" "inc hosp" 
      
      
      $task_ids$horizon
      $task_ids$horizon$required
      [1] 1
      
      $task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $output_type
      $output_type$mean
      $output_type$mean$output_type_id
      $output_type$mean$output_type_id$required
      [1] NA
      
      $output_type$mean$output_type_id$optional
      NULL
      
      
      $output_type$mean$value
      $output_type$mean$value$type
      [1] "double"
      
      $output_type$mean$value$minimum
      [1] 0
      
      
      
      $output_type$median
      $output_type$median$output_type_id
      $output_type$median$output_type_id$required
      NULL
      
      $output_type$median$output_type_id$optional
      [1] NA
      
      
      $output_type$median$value
      $output_type$median$value$type
      [1] "double"
      
      
      
      $output_type$quantile
      $output_type$quantile$output_type_id
      $output_type$quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      $output_type$quantile$output_type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $output_type$quantile$value
      $output_type$quantile$value$type
      [1] "double"
      
      $output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      $target_metadata
      $target_metadata[[1]]
      $target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $target_metadata[[1]]$target_keys
      $target_metadata[[1]]$target_keys$target
      [1] "inc hosp"
      
      
      $target_metadata[[1]]$target_type
      [1] "discrete"
      
      $target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $target_metadata[[1]]$time_unit
      [1] "week"
      
      
      $target_metadata[[2]]
      $target_metadata[[2]]$target_id
      [1] "inc death"
      
      $target_metadata[[2]]$target_name
      [1] "Weekly incident influenza deaths"
      
      $target_metadata[[2]]$target_units
      [1] "rate per 100,000 population"
      
      $target_metadata[[2]]$target_keys
      $target_metadata[[2]]$target_keys$target
      [1] "inc death"
      
      
      $target_metadata[[2]]$target_type
      [1] "discrete"
      
      $target_metadata[[2]]$is_step_ahead
      [1] TRUE
      
      $target_metadata[[2]]$time_unit
      [1] "week"
      
      
      
      attr(,"class")
      [1] "model_task" "list"      
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_output_type_point functions error correctly

    Code
      create_model_task(task_ids = task_ids, output_type = output_type,
        target_metadata = create_target_metadata(create_target_metadata_item(
          target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_model_task()`:
      x `task_ids` target values must match `target_metadata` `target_keys` definitions.
      > `target_keys` target values: "inc hosp"
      > `task_ids` target values: "inc death" and "inc hosp"

---

    Code
      create_model_task(task_ids = task_ids, output_type = output_type,
        target_metadata = create_target_metadata(create_target_metadata_item(
          target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population", target_keys = list(targets = "inc hosp"),
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))
    Condition
      Error in `create_model_task()`:
      ! `target_metadata` target_keys names must match valid `task_ids` property names: "origin_date", "target", and "horizon"
      x target_keys name "targets" does not.

---

    Code
      create_model_task(task_ids = task_ids, output_type = list(a = 10),
      target_metadata = create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(targets = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week")))
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `create_model_task()`:
      x `output_type` must inherit from class <output_type> but does not

---

    Code
      create_model_task(task_ids = task_ids, output_type = output_type,
        target_metadata = create_target_metadata(create_target_metadata_item(
          target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population", target_keys = NULL,
          target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")))
    Condition
      Error in `create_model_task()`:
      ! All arguments supplied must be created against the same Hub schema.
      x `schema_id` attributes are not consistent across all arguments.
      Argument `schema_id` attributes:
      * task_ids : invalid_schema_id
      * output_type : https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json
      * target_metadata : https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json

