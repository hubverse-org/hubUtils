# get_round_value_sets_config works

    Code
      str(get_round_value_sets_config(config_tasks, round_id = "2022-10-22"))
    Output
      List of 3
       $ :List of 2
        ..$ task_ids       :List of 5
        .. ..$ reference_date : chr "2022-10-22"
        .. ..$ target         : chr "flu_hosp_rate_cat"
        .. ..$ horizon        : int [1:2] 1 2
        .. ..$ location       : chr [1:3] "US" "01" "02"
        .. ..$ target_end_date: chr [1:13] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" ...
        ..$ output_type_ids:List of 1
        .. ..$ pmf: chr [1:4] "low" "moderate" "high" "very high"
       $ :List of 2
        ..$ task_ids       :List of 5
        .. ..$ reference_date : chr "2022-10-22"
        .. ..$ target         : chr "flu_hosp_rate"
        .. ..$ horizon        : int [1:2] 1 2
        .. ..$ location       : chr [1:3] "US" "01" "02"
        .. ..$ target_end_date: chr [1:13] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" ...
        ..$ output_type_ids:List of 1
        .. ..$ cdf: int [1:12] 1 2 3 4 5 6 7 8 9 10 ...
       $ :List of 2
        ..$ task_ids       :List of 5
        .. ..$ reference_date : chr "2022-10-22"
        .. ..$ target         : chr "flu_hosp_inc"
        .. ..$ horizon        : int [1:2] 1 2
        .. ..$ location       : chr [1:3] "US" "01" "02"
        .. ..$ target_end_date: chr [1:13] "2022-10-22" "2022-10-29" "2022-11-05" "2022-11-12" ...
        ..$ output_type_ids:List of 3
        .. ..$ quantile: num [1:11] 0.025 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ...
        .. ..$ sample  : logi NA
        .. ..$ mean    : logi NA

---

    Code
      str(get_round_value_sets_config(config_tasks, round_id = "2023-05-08",
        required_vals_only = TRUE))
    Output
      List of 2
       $ :List of 2
        ..$ task_ids       :List of 5
        .. ..$ forecast_date: chr "2023-05-08"
        .. ..$ target       : logi NA
        .. ..$ horizon      : int 2
        .. ..$ target_date  : logi NA
        .. ..$ location     : chr "US"
        ..$ output_type_ids: Named list()
       $ :List of 2
        ..$ task_ids       :List of 5
        .. ..$ forecast_date: chr "2023-05-08"
        .. ..$ target       : logi NA
        .. ..$ horizon      : int 2
        .. ..$ target_date  : logi NA
        .. ..$ location     : chr "US"
        ..$ output_type_ids: Named list()

# get_round_value_sets_config fails correctly

    Code
      get_round_value_sets_config(config_tasks, round_id = "2022-10-22",
        output_types = c("mean", "median"))
    Condition
      Error in `get_round_value_sets_config()`:
      x "median" is not valid output type.
      i `output_types` must be members of: "pmf", "cdf", "quantile", "sample", and "mean"

---

    Code
      value_sets <- get_round_value_sets_config(config_tasks, round_id = "2022-10-22",
        derived_task_ids = c("target_end_date", "random_task_id"))
    Condition
      Warning in `get_round_value_sets_config()`:
      x "random_task_id" is not valid task ID. Ignored.
      i `derived_task_ids` must be a member of: "reference_date", "target", "horizon", "location", and "target_end_date"

---

    Code
      get_round_value_sets_config(config_tasks, round_id = "2023-05-08",
        derived_task_ids = "location")
    Condition
      Error in `get_round_value_sets_config()`:
      x Derived task IDs cannot have required task ID values.
      ! "location" has required task ID values.

---

    Code
      get_round_value_sets_config(config_tasks_omitted, round_id = "2023-05-08",
        derived_task_ids = "location")
    Condition
      Error in `get_round_value_sets_config()`:
      x Derived task IDs cannot have required task ID values.
      ! "location" has required task ID values.

# get_round_value_sets_config reports conditions against `call`

    Code
      wrapper(output_types = "cdf")
    Condition
      Error in `wrapper()`:
      x "cdf" is not valid output type.
      i `output_types` must be members of: "pmf", "quantile", and "mean"

---

    Code
      wrapper(derived_task_ids = "location")
    Condition
      Error in `wrapper()`:
      x Derived task IDs cannot have required task ID values.
      ! "location" has required task ID values.

---

    Code
      value_sets <- wrapper(derived_task_ids = "random_task_id")
    Condition
      Warning in `wrapper()`:
      x "random_task_id" is not valid task ID. Ignored.
      i `derived_task_ids` must be a member of: "forecast_date", "target", "horizon", "target_date", and "location"

