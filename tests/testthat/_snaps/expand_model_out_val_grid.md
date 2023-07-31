# expand_model_out_val_grid works correctly

    Code
      str(expand_model_out_val_grid(config_tasks, round_id = "2023-01-02"))
    Output
      tibble [3,132 x 6] (S3: tbl_df/tbl/data.frame)
       $ forecast_date : Date[1:3132], format: "2023-01-02" "2023-01-02" ...
       $ target        : chr [1:3132] "wk flu hosp rate change" "wk flu hosp rate change" "wk flu hosp rate change" "wk flu hosp rate change" ...
       $ horizon       : int [1:3132] 2 1 2 1 2 1 2 1 2 1 ...
       $ location      : chr [1:3132] "US" "US" "01" "01" ...
       $ output_type   : chr [1:3132] "pmf" "pmf" "pmf" "pmf" ...
       $ output_type_id: chr [1:3132] "large_decrease" "large_decrease" "large_decrease" "large_decrease" ...
       - attr(*, "out.attrs")=List of 2
        ..$ dim     : Named int [1:6] 1 1 2 54 1 5
        .. ..- attr(*, "names")= chr [1:6] "forecast_date" "target" "horizon" "location" ...
        ..$ dimnames:List of 6
        .. ..$ forecast_date : chr "forecast_date=2023-01-02"
        .. ..$ target        : chr "target=wk flu hosp rate change"
        .. ..$ horizon       : chr [1:2] "horizon=2" "horizon=1"
        .. ..$ location      : chr [1:54] "location=US" "location=01" "location=02" "location=04" ...
        .. ..$ output_type   : chr "output_type=pmf"
        .. ..$ output_type_id: chr [1:5] "output_type_id=large_decrease" "output_type_id=decrease" "output_type_id=stable" "output_type_id=increase" ...

---

    Code
      str(expand_model_out_val_grid(config_tasks, round_id = "2023-01-02",
        required_vals_only = TRUE))
    Output
      tibble [28 x 5] (S3: tbl_df/tbl/data.frame)
       $ forecast_date : Date[1:28], format: "2023-01-02" "2023-01-02" ...
       $ horizon       : int [1:28] 2 2 2 2 2 2 2 2 2 2 ...
       $ location      : chr [1:28] "US" "US" "US" "US" ...
       $ output_type   : chr [1:28] "pmf" "pmf" "pmf" "pmf" ...
       $ output_type_id: chr [1:28] "large_decrease" "decrease" "stable" "increase" ...
       - attr(*, "out.attrs")=List of 2
        ..$ dim     : Named int [1:5] 1 1 1 1 5
        .. ..- attr(*, "names")= chr [1:5] "forecast_date" "horizon" "location" "output_type" ...
        ..$ dimnames:List of 5
        .. ..$ forecast_date : chr "forecast_date=2023-01-02"
        .. ..$ horizon       : chr "horizon=2"
        .. ..$ location      : chr "location=US"
        .. ..$ output_type   : chr "output_type=pmf"
        .. ..$ output_type_id: chr [1:5] "output_type_id=large_decrease" "output_type_id=decrease" "output_type_id=stable" "output_type_id=increase" ...

---

    Code
      str(expand_model_out_val_grid(config_tasks, round_id = "2022-10-01"))
    Output
      tibble [5,184 x 6] (S3: tbl_df/tbl/data.frame)
       $ origin_date   : Date[1:5184], format: "2022-10-01" "2022-10-01" ...
       $ target        : chr [1:5184] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" ...
       $ horizon       : int [1:5184] 1 2 3 4 1 2 3 4 1 2 ...
       $ location      : chr [1:5184] "US" "US" "US" "US" ...
       $ output_type   : chr [1:5184] "mean" "mean" "mean" "mean" ...
       $ output_type_id: num [1:5184] NA NA NA NA NA NA NA NA NA NA ...

---

    Code
      str(expand_model_out_val_grid(config_tasks, round_id = "2022-10-01",
        required_vals_only = TRUE))
    Output
      tibble [23 x 5] (S3: tbl_df/tbl/data.frame)
       $ origin_date   : Date[1:23], format: "2022-10-01" "2022-10-01" ...
       $ target        : chr [1:23] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" ...
       $ horizon       : int [1:23] 1 1 1 1 1 1 1 1 1 1 ...
       $ output_type   : chr [1:23] "quantile" "quantile" "quantile" "quantile" ...
       $ output_type_id: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
       - attr(*, "out.attrs")=List of 2
        ..$ dim     : Named int [1:5] 1 1 1 1 23
        .. ..- attr(*, "names")= chr [1:5] "origin_date" "target" "horizon" "output_type" ...
        ..$ dimnames:List of 5
        .. ..$ origin_date   : chr "origin_date=2022-10-01"
        .. ..$ target        : chr "target=wk inc flu hosp"
        .. ..$ horizon       : chr "horizon=1"
        .. ..$ output_type   : chr "output_type=quantile"
        .. ..$ output_type_id: chr [1:23] "output_type_id=0.010" "output_type_id=0.025" "output_type_id=0.050" "output_type_id=0.100" ...

---

    Code
      str(expand_model_out_val_grid(config_tasks, round_id = "2022-10-29",
        required_vals_only = TRUE))
    Output
      tibble [23 x 6] (S3: tbl_df/tbl/data.frame)
       $ origin_date   : Date[1:23], format: "2022-10-29" "2022-10-29" ...
       $ target        : chr [1:23] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" ...
       $ horizon       : int [1:23] 1 1 1 1 1 1 1 1 1 1 ...
       $ age_group     : chr [1:23] "65+" "65+" "65+" "65+" ...
       $ output_type   : chr [1:23] "quantile" "quantile" "quantile" "quantile" ...
       $ output_type_id: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
       - attr(*, "out.attrs")=List of 2
        ..$ dim     : Named int [1:6] 1 1 1 1 1 23
        .. ..- attr(*, "names")= chr [1:6] "origin_date" "target" "horizon" "age_group" ...
        ..$ dimnames:List of 6
        .. ..$ origin_date   : chr "origin_date=2022-10-29"
        .. ..$ target        : chr "target=wk inc flu hosp"
        .. ..$ horizon       : chr "horizon=1"
        .. ..$ age_group     : chr "age_group=65+"
        .. ..$ output_type   : chr "output_type=quantile"
        .. ..$ output_type_id: chr [1:23] "output_type_id=0.010" "output_type_id=0.025" "output_type_id=0.050" "output_type_id=0.100" ...

# expand_model_out_val_grid errors correctly

    Code
      expand_model_out_val_grid(config_tasks, round_id = "random_round_id")
    Error <rlang_error>
      `round_id` must be one of "2022-10-01", "2022-10-08", "2022-10-15", "2022-10-22", or "2022-10-29", not "random_round_id".

---

    Code
      expand_model_out_val_grid(config_tasks)
    Error <rlang_error>
      `round_id` must be a character vector, not absent.

---

    Code
      expand_model_out_val_grid(config_tasks)
    Error <rlang_error>
      `round_id` must be a character vector, not absent.

