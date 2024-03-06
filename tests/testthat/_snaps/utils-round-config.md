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

