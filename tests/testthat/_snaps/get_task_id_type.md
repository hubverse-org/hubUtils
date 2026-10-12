# get_task_id_values fails correctly

    Code
      get_task_id_values(config_tasks)
    Condition
      Error in `get_task_id_values()`:
      ! `task_id_name` is absent but must be supplied.

---

    Code
      get_task_id_values(config_tasks, "random")
    Condition
      Error in `get_task_id_values()`:
      ! `task_id_name` must be one of "origin_date", "target", "horizon", "location", or "age_group", not "random".

---

    Code
      get_task_id_values(config_tasks, 1L)
    Condition
      Error in `get_task_id_values()`:
      ! `task_id_name` must be a single string, not an integer.

---

    Code
      get_task_id_values(config_tasks, round_id = "random")
    Condition
      Error in `get_task_id_values()`:
      ! `task_id_name` is absent but must be supplied.

---

    Code
      get_task_id_values(config_tasks, "age_group", round_id = "2022-10-01")
    Condition
      Error in `get_task_id_values()`:
      ! `task_id_name` must be one of "origin_date", "target", "horizon", or "location", not "age_group".

---

    Code
      get_task_id_values(config_tasks, "horizon", round_id = "random")
    Condition
      Error in `get_task_id_values()`:
      ! `round_id` must be one of "2022-10-01", "2022-10-08", "2022-10-15", "2022-10-22", or "2022-10-29", not "random".

# get_task_id_type errors when a task ID has no values

    Code
      get_task_id_type(config_tasks, "age_group", round_id = "2022-10-01")
    Condition
      Error in `get_task_id_type()`:
      ! Task ID "age_group" has no values in the config to determine a data type from.

