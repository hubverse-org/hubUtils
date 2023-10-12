# create_target_metadata_item functions work correctly

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")
    Output
      $target_id
      [1] "inc hosp"
      
      $target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $target_units
      [1] "rate per 100,000 population"
      
      $target_keys
      $target_keys$target
      [1] "inc hosp"
      
      
      $target_type
      [1] "discrete"
      
      $is_step_ahead
      [1] TRUE
      
      $time_unit
      [1] "week"
      
      attr(,"class")
      [1] "target_metadata_item" "list"                
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_type = "discrete",
        is_step_ahead = FALSE)
    Output
      $target_id
      [1] "inc hosp"
      
      $target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $target_units
      [1] "rate per 100,000 population"
      
      $target_keys
      NULL
      
      $target_type
      [1] "discrete"
      
      $is_step_ahead
      [1] FALSE
      
      attr(,"class")
      [1] "target_metadata_item" "list"                
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_target_metadata_item functions error correctly

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "weekly")
    Condition
      Error in `map()`:
      i In index: 6.
      Caused by error in `create_target_metadata_item()`:
      x `time_unit` value is invalid.
      ! Must be one of "day", "week", and "month".
      i Actual value is "weekly"

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = list(target = c(
          "inc hosp", "inc death")), target_type = "discrete", is_step_ahead = TRUE,
        time_unit = "week")
    Condition
      Error in `map2()`:
      i In index: 1.
      i With name: target.
      Caused by error in `create_target_metadata_item()`:
      ! `target_keys` element target must be a <character> vector of length 1 not a <character> vector of length 2

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = c(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week")
    Condition
      Error in `create_target_metadata_item()`:
      ! `target_keys` must be a <list> not a <character>

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_type = "discrete",
        is_step_ahead = TRUE)
    Condition
      Error in `create_target_metadata_item()`:
      ! A value must be provided for `time_unit` when `is_step_ahead` is TRUE

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = 1e+05, target_type = "discrete", is_step_ahead = FALSE)
    Condition
      Error in `map()`:
      i In index: 3.
      Caused by error in `create_target_metadata_item()`:
      x `target_units` is of type <double>.
      ! Must be <character>.

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_type = "invalid_target_type",
        is_step_ahead = FALSE)
    Condition
      Error in `map()`:
      i In index: 4.
      Caused by error in `create_target_metadata_item()`:
      x `target_type` value is invalid.
      ! Must be one of "continuous", "discrete", "date", "binary", "nominal", "ordinal", and "compositional".
      i Actual value is "invalid_target_type"

---

    Code
      create_target_metadata_item(target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = c("rate per 100,000 population", "count"), target_type = "discrete",
        is_step_ahead = FALSE)
    Condition
      Error in `map()`:
      i In index: 3.
      Caused by error in `create_target_metadata_item()`:
      x `target_units` must be length 1, not 2.

