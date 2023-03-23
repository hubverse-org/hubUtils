# create_target_metadata functions work correctly

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc death", target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))
    Output
      $target_metadata
      $target_metadata[[1]]
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
      
      $target_metadata[[2]]
      $target_id
      [1] "inc death"
      
      $target_name
      [1] "Weekly incident influenza deaths"
      
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
      
      
      attr(,"class")
      [1] "target_metadata" "list"           
      attr(,"n")
      [1] 2

# create_target_metadata functions error correctly

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), create_target_metadata_item(
        target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population", target_keys = list(target = "inc hosp"),
        target_type = "discrete", is_step_ahead = TRUE, time_unit = "week"))
    Error <rlang_error>
      ! `target_id`s must be unique across all `target_metadata_item`s.
      x `target_metadata_item` 2 with `target_id` value "inc hosp" is duplicate.

---

    Code
      create_target_metadata(create_target_metadata_item(target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations", target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"), target_type = "discrete",
        is_step_ahead = TRUE, time_unit = "week"), list(a = 10), list(b = 10))
    Error <rlang_error>
      ! All items supplied must inherit from class <target_metadata_item>
      x Items 2 and 3 do not.

