# get_round_task_id_names works

    Code
      get_round_task_id_names(config_tasks, round_id = "2022-10-01")
    Output
      [1] "origin_date" "target"      "horizon"     "location"   

---

    Code
      get_round_task_id_names(config_tasks, round_id = "2022-10-22")
    Output
      [1] "origin_date" "target"      "horizon"     "location"    "age_group"  

# get_round_task_id_names fails correctly

    Code
      get_round_task_id_names(config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01")
    Condition
      Error in `get_round_ids()`:
      ! Assertion on 'config_tasks' failed: Must be of type 'list', not 'character'.

---

    Code
      get_round_task_id_names(config_tasks, round_id = c("2022-10-01", "2022-10-22"))
    Condition
      Error in `get_round_idx()`:
      ! Assertion on 'round_id' failed: Must have length 1.

# get_round_model_tasks works

    Code
      get_round_model_tasks(config_tasks, round_id = "2022-10-01")
    Output
      [[1]]
      [[1]]$task_ids
      [[1]]$task_ids$origin_date
      [[1]]$task_ids$origin_date$required
      NULL
      
      [[1]]$task_ids$origin_date$optional
      [1] "2022-10-01" "2022-10-08"
      
      
      [[1]]$task_ids$target
      [[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      [[1]]$task_ids$target$optional
      NULL
      
      
      [[1]]$task_ids$horizon
      [[1]]$task_ids$horizon$required
      [1] 1
      
      [[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      [[1]]$task_ids$location
      [[1]]$task_ids$location$required
      NULL
      
      [[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      
      [[1]]$output_type
      [[1]]$output_type$mean
      [[1]]$output_type$mean$output_type_id
      [[1]]$output_type$mean$output_type_id$required
      NULL
      
      [[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      [[1]]$output_type$mean$value
      [[1]]$output_type$mean$value$type
      [1] "integer"
      
      [[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      [[1]]$output_type$quantile
      [[1]]$output_type$quantile$output_type_id
      [[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      [[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      [[1]]$output_type$quantile$value
      [[1]]$output_type$quantile$value$type
      [1] "integer"
      
      [[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      [[1]]$target_metadata
      [[1]]$target_metadata[[1]]
      [[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      [[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      [[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      [[1]]$target_metadata[[1]]$target_keys
      [[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      [[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      [[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      [[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      

---

    Code
      get_round_model_tasks(config_tasks, round_id = "2022-10-22")
    Output
      [[1]]
      [[1]]$task_ids
      [[1]]$task_ids$origin_date
      [[1]]$task_ids$origin_date$required
      NULL
      
      [[1]]$task_ids$origin_date$optional
      [1] "2022-10-15" "2022-10-22" "2022-10-29"
      
      
      [[1]]$task_ids$target
      [[1]]$task_ids$target$required
      [1] "wk inc flu hosp"
      
      [[1]]$task_ids$target$optional
      NULL
      
      
      [[1]]$task_ids$horizon
      [[1]]$task_ids$horizon$required
      [1] 1
      
      [[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      [[1]]$task_ids$location
      [[1]]$task_ids$location$required
      NULL
      
      [[1]]$task_ids$location$optional
       [1] "US" "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17"
      [16] "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32"
      [31] "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48"
      [46] "49" "50" "51" "53" "54" "55" "56" "72" "78"
      
      
      [[1]]$task_ids$age_group
      [[1]]$task_ids$age_group$required
      [1] "65+"
      
      [[1]]$task_ids$age_group$optional
      [1] "0-5"   "6-18"  "19-24" "25-64"
      
      
      
      [[1]]$output_type
      [[1]]$output_type$mean
      [[1]]$output_type$mean$output_type_id
      [[1]]$output_type$mean$output_type_id$required
      NULL
      
      [[1]]$output_type$mean$output_type_id$optional
      [1] NA
      
      
      [[1]]$output_type$mean$value
      [[1]]$output_type$mean$value$type
      [1] "integer"
      
      [[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      [[1]]$output_type$quantile
      [[1]]$output_type$quantile$output_type_id
      [[1]]$output_type$quantile$output_type_id$required
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      [[1]]$output_type$quantile$output_type_id$optional
      NULL
      
      
      [[1]]$output_type$quantile$value
      [[1]]$output_type$quantile$value$type
      [1] "integer"
      
      [[1]]$output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      [[1]]$target_metadata
      [[1]]$target_metadata[[1]]
      [[1]]$target_metadata[[1]]$target_id
      [1] "wk inc flu hosp"
      
      [[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      [[1]]$target_metadata[[1]]$target_units
      [1] "count"
      
      [[1]]$target_metadata[[1]]$target_keys
      [[1]]$target_metadata[[1]]$target_keys$target
      [1] "wk inc flu hosp"
      
      
      [[1]]$target_metadata[[1]]$target_type
      [1] "continuous"
      
      [[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      [[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      

# get_round_model_tasks fails correctly

    Code
      get_round_model_tasks(config_tasks = c("random", "character", "vector"),
      round_id = "2022-10-01")
    Condition
      Error in `get_round_ids()`:
      ! Assertion on 'config_tasks' failed: Must be of type 'list', not 'character'.

---

    Code
      get_round_model_tasks(config_tasks, round_id = c("2022-10-01", "2022-10-22"))
    Condition
      Error in `get_round_idx()`:
      ! Assertion on 'round_id' failed: Must have length 1.

