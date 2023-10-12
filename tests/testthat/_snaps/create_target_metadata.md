# create_target_metadata functions work correctly

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc death", target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc death"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))
    Output
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
      [1] "target_metadata" "list"           
      attr(,"n")
      [1] 2
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_target_metadata functions error correctly

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))
    Condition
      Error in `create_target_metadata()`:
      ! `target_id`s must be unique across all `target_metadata_item`s.
      x `target_metadata_item` 2 with `target_id` value inc hosp is duplicate.

---

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc death", target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))
    Condition
      Error in `create_target_metadata()`:
      ! `target_keys`s must be unique across all `target_metadata_item`s.
      x `target_metadata_item` 2 with `target_keys` value list(target = "inc hosp") is duplicate.

---

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), list(a = 10), list(b = 10))
    Condition
      Error in `create_target_metadata()`:
      ! All items supplied must inherit from class <target_metadata_item>
      x Items 2 and 3 do not.

---

    Code
      create_target_metadata(item_1, create_target_metadata_item(target_id = "inc death",
        target_name = "Weekly incident influenza deaths", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"))
    Condition
      Error in `create_target_metadata()`:
      ! All items supplied must be created against the same Hub schema.
      x `schema_id` attributes are not consistent across all items.
      Item `schema_id` attributes:
      * Item 1 : invalid_schema
      * Item 2 : https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json

