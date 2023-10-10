# create_model_tasks functions work correctly

    Code
      create_model_tasks(create_model_task(task_ids = create_task_ids(create_task_id(
        "origin_date", required = NULL, optional = c("2023-01-02", "2023-01-09",
          "2023-01-16")), create_task_id("location", required = "US", optional = c(
        "01", "02", "04", "05", "06")), create_task_id("horizon", required = 1L,
        optional = 2:4)), output_type = create_output_type(create_output_type_mean(
        is_required = TRUE, value_type = "double", value_minimum = 0L)),
      target_metadata = create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = NULL, target_type = "discrete", is_step_ahead = TRUE,
        time_unit = "week"))))
    Output
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
      
      
      
      
      
      attr(,"class")
      [1] "model_tasks" "list"       
      attr(,"n")
      [1] 1
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_model_tasks(create_model_task(task_ids = create_task_ids(create_task_id(
        "origin_date", required = NULL, optional = c("2023-01-02", "2023-01-09",
          "2023-01-16")), create_task_id("location", required = "US", optional = c(
        "01", "02", "04", "05", "06")), create_task_id("target", required = NULL,
        optional = c("inc death", "inc hosp")), create_task_id("horizon", required = 1L,
        optional = 2:4)), output_type = create_output_type(create_output_type_mean(
        is_required = TRUE, value_type = "double", value_minimum = 0L),
      create_output_type_median(is_required = FALSE, value_type = "double"),
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0)),
      target_metadata = create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc death", target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc death"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))),
      create_model_task(task_ids = create_task_ids(create_task_id("origin_date",
        required = NULL, optional = c("2023-01-02", "2023-01-09", "2023-01-16")),
      create_task_id("location", required = "US", optional = c("01", "02", "04", "05",
        "06")), create_task_id("target", required = "flu hosp rt chng", optional = NULL),
      create_task_id("horizon", required = 1L, optional = 2:4)), output_type = create_output_type(
        create_output_type_pmf(required = c("large_decrease", "decrease", "stable",
          "increase", "large_increase"), optional = NULL, value_type = "double")),
      target_metadata = create_target_metadata(create_target_metadata_item(target_id = "flu hosp rt chng",
        target_name = "Weekly influenza hospitalization rate change", target_units = "rate per 100,000 population",
        target_keys = list(target = "flu hosp rt chng"), target_type = "nominal",
        is_step_ahead = TRUE, time_unit = "week"))))
    Output
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
      
      
      $model_tasks[[1]]$task_ids$target
      $model_tasks[[1]]$task_ids$target$required
      NULL
      
      $model_tasks[[1]]$task_ids$target$optional
      [1] "inc death" "inc hosp" 
      
      
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
      
      
      
      $model_tasks[[1]]$output_type$median
      $model_tasks[[1]]$output_type$median$output_type_id
      $model_tasks[[1]]$output_type$median$output_type_id$required
      NULL
      
      $model_tasks[[1]]$output_type$median$output_type_id$optional
      [1] NA
      
      
      $model_tasks[[1]]$output_type$median$value
      $model_tasks[[1]]$output_type$median$value$type
      [1] "double"
      
      
      
      $model_tasks[[1]]$output_type$quantile
      $model_tasks[[1]]$output_type$quantile$output_type_id
      $model_tasks[[1]]$output_type$quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      $model_tasks[[1]]$output_type$quantile$output_type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $model_tasks[[1]]$output_type$quantile$value
      $model_tasks[[1]]$output_type$quantile$value$type
      [1] "double"
      
      $model_tasks[[1]]$output_type$quantile$value$minimum
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
      $model_tasks[[1]]$target_metadata[[1]]$target_keys$target
      [1] "inc hosp"
      
      
      $model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      $model_tasks[[1]]$target_metadata[[2]]
      $model_tasks[[1]]$target_metadata[[2]]$target_id
      [1] "inc death"
      
      $model_tasks[[1]]$target_metadata[[2]]$target_name
      [1] "Weekly incident influenza deaths"
      
      $model_tasks[[1]]$target_metadata[[2]]$target_units
      [1] "rate per 100,000 population"
      
      $model_tasks[[1]]$target_metadata[[2]]$target_keys
      $model_tasks[[1]]$target_metadata[[2]]$target_keys$target
      [1] "inc death"
      
      
      $model_tasks[[1]]$target_metadata[[2]]$target_type
      [1] "discrete"
      
      $model_tasks[[1]]$target_metadata[[2]]$is_step_ahead
      [1] TRUE
      
      $model_tasks[[1]]$target_metadata[[2]]$time_unit
      [1] "week"
      
      
      
      
      $model_tasks[[2]]
      $model_tasks[[2]]$task_ids
      $model_tasks[[2]]$task_ids$origin_date
      $model_tasks[[2]]$task_ids$origin_date$required
      NULL
      
      $model_tasks[[2]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $model_tasks[[2]]$task_ids$location
      $model_tasks[[2]]$task_ids$location$required
      [1] "US"
      
      $model_tasks[[2]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $model_tasks[[2]]$task_ids$target
      $model_tasks[[2]]$task_ids$target$required
      [1] "flu hosp rt chng"
      
      $model_tasks[[2]]$task_ids$target$optional
      NULL
      
      
      $model_tasks[[2]]$task_ids$horizon
      $model_tasks[[2]]$task_ids$horizon$required
      [1] 1
      
      $model_tasks[[2]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $model_tasks[[2]]$output_type
      $model_tasks[[2]]$output_type$pmf
      $model_tasks[[2]]$output_type$pmf$output_type_id
      $model_tasks[[2]]$output_type$pmf$output_type_id$required
      [1] "large_decrease" "decrease"       "stable"         "increase"      
      [5] "large_increase"
      
      $model_tasks[[2]]$output_type$pmf$output_type_id$optional
      NULL
      
      
      $model_tasks[[2]]$output_type$pmf$value
      $model_tasks[[2]]$output_type$pmf$value$type
      [1] "double"
      
      $model_tasks[[2]]$output_type$pmf$value$minimum
      [1] 0
      
      $model_tasks[[2]]$output_type$pmf$value$maximum
      [1] 1
      
      
      
      
      $model_tasks[[2]]$target_metadata
      $model_tasks[[2]]$target_metadata[[1]]
      $model_tasks[[2]]$target_metadata[[1]]$target_id
      [1] "flu hosp rt chng"
      
      $model_tasks[[2]]$target_metadata[[1]]$target_name
      [1] "Weekly influenza hospitalization rate change"
      
      $model_tasks[[2]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $model_tasks[[2]]$target_metadata[[1]]$target_keys
      $model_tasks[[2]]$target_metadata[[1]]$target_keys$target
      [1] "flu hosp rt chng"
      
      
      $model_tasks[[2]]$target_metadata[[1]]$target_type
      [1] "nominal"
      
      $model_tasks[[2]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $model_tasks[[2]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      attr(,"class")
      [1] "model_tasks" "list"       
      attr(,"n")
      [1] 2
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_model_tasks functions error correctly

    Code
      create_model_tasks(model_task_1, list(a = 10))
    Condition
      Error in `create_model_tasks()`:
      ! All items supplied must inherit from class <model_task>
      x Item 2 does not.

---

    Code
      create_model_tasks(model_task_1, create_model_task(task_ids = create_task_ids(
        create_task_id("origin_date", required = NULL, optional = c("2023-01-02",
          "2023-01-09", "2023-01-16")), create_task_id("location", required = "US",
          optional = c("01", "02", "04", "05", "06")), create_task_id("target",
          required = "flu hosp rt chng", optional = NULL), create_task_id("horizon",
          required = 1L, optional = 2:4)), output_type = create_output_type(
        create_output_type_pmf(required = c("large_decrease", "decrease", "stable",
          "increase", "large_increase"), optional = NULL, value_type = "double")),
      target_metadata = create_target_metadata(create_target_metadata_item(target_id = "flu hosp rt chng",
        target_name = "Weekly influenza hospitalization rate change", target_units = "rate per 100,000 population",
        target_keys = list(target = "flu hosp rt chng"), target_type = "nominal",
        is_step_ahead = TRUE, time_unit = "week"))))
    Condition
      Error in `create_model_tasks()`:
      ! All items supplied must be created against the same Hub schema.
      x `schema_id` attributes are not consistent across all items.
      Item `schema_id` attributes:
      * Item 1 : invalid_schema_id
      * Item 2 : https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json

