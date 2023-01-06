# connect_hub works on simple forecasting hub

    Code
      str(hub_con)
    Output
      List of 1
       $ round_id_from_variable:List of 3
        ..$ model_tasks      :List of 1
        .. ..$ :List of 2
        .. .. ..$ task_ids    :List of 3
        .. .. .. ..$ origin_date:List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr [1:24] "2022-01-08" "2022-01-15" "2022-01-22" "2022-01-29" ...
        .. .. .. ..$ location   :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr [1:54] "01" "02" "04" "05" ...
        .. .. .. ..$ horizon    :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: int [1:4] 1 2 3 4
        .. .. ..$ output_types:List of 2
        .. .. .. ..$ mean    :List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        .. .. .. ..$ quantile:List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. ..$ optional: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        ..$ round_id_variable: chr "origin_date"
        ..$ submissions_due  :List of 3
        .. ..$ relative_to: chr "origin_date"
        .. ..$ start      : int -4
        .. ..$ end        : int 2
       - attr(*, "hubmeta_path")= chr "test/hubmeta_path"
       - attr(*, "hub_path")= chr "test/hub_path"
       - attr(*, "task_id_names")= chr [1:3] "origin_date" "location" "horizon"
       - attr(*, "round_ids")= chr "origin_date"
       - attr(*, "task_ids_by_round")= logi FALSE
       - attr(*, "class")= chr "hub_connection"

# connect_hub works on scenario hub

    Code
      str(hub_con)
    Output
      List of 2
       $ round-1:List of 2
        ..$ model_tasks    :List of 2
        .. ..$ :List of 2
        .. .. ..$ task_ids    :List of 5
        .. .. .. ..$ origin_date:List of 2
        .. .. .. .. ..$ required: chr "2022-09-03"
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ scenario_id:List of 2
        .. .. .. .. ..$ required: int 1
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ location   :List of 2
        .. .. .. .. ..$ required: chr [1:51] "01" "02" "04" "05" ...
        .. .. .. .. ..$ optional: chr "US"
        .. .. .. ..$ target     :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr "weekly rate"
        .. .. .. ..$ horizon    :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: int [1:2] 1 2
        .. .. ..$ output_types:List of 3
        .. .. .. ..$ mean    :List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        .. .. .. ..$ quantile:List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: num [1:3] 0.25 0.5 0.75
        .. .. .. .. .. ..$ optional: num [1:8] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        .. .. .. ..$ cdf     :List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: num [1:2] 10 20
        .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. ..$ value  :List of 3
        .. .. .. .. .. ..$ type   : chr "numeric"
        .. .. .. .. .. ..$ minimum: num 0
        .. .. .. .. .. ..$ maximum: num 1
        .. ..$ :List of 2
        .. .. ..$ task_ids    :List of 5
        .. .. .. ..$ origin_date:List of 2
        .. .. .. .. ..$ required: chr "2022-09-03"
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ scenario_id:List of 2
        .. .. .. .. ..$ required: int 1
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ location   :List of 2
        .. .. .. .. ..$ required: chr [1:51] "01" "02" "04" "05" ...
        .. .. .. .. ..$ optional: chr "US"
        .. .. .. ..$ target     :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr "peak week"
        .. .. .. ..$ horizon    :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: logi NA
        .. .. ..$ output_types:List of 1
        .. .. .. ..$ cdf:List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: chr [1:33] "EW202240" "EW202241" "EW202242" "EW202243" ...
        .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "numeric"
        .. .. .. .. .. ..$ minimum: int 0
        ..$ submissions_due:List of 2
        .. ..$ start: chr "2022-09-01"
        .. ..$ end  : chr "2022-09-05"
       $ round-2:List of 3
        ..$ model_tasks    :List of 1
        .. ..$ :List of 2
        .. .. ..$ task_ids    :List of 6
        .. .. .. ..$ origin_date:List of 2
        .. .. .. .. ..$ required: chr "2022-10-01"
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ scenario_id:List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: int [1:2] 2 3
        .. .. .. ..$ location   :List of 2
        .. .. .. .. ..$ required: chr [1:51] "01" "02" "04" "05" ...
        .. .. .. .. ..$ optional: chr "US"
        .. .. .. ..$ target     :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr "weekly rate"
        .. .. .. ..$ age_group  :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: chr [1:5] "0-5" "6-18" "19-24" "25-64" ...
        .. .. .. ..$ horizon    :List of 2
        .. .. .. .. ..$ required: NULL
        .. .. .. .. ..$ optional: int [1:2] 1 2
        .. .. ..$ output_types:List of 1
        .. .. .. ..$ quantile:List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: num [1:3] 0.25 0.5 0.75
        .. .. .. .. .. ..$ optional: num [1:8] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        ..$ submissions_due:List of 2
        .. ..$ start: chr "2022-09-28"
        .. ..$ end  : chr "2022-10-01"
        ..$ last_data_date : chr "2022-09-30"
       - attr(*, "hubmeta_path")= chr "test/hubmeta_path"
       - attr(*, "hub_path")= chr "test/hub_path"
       - attr(*, "task_id_names")=List of 2
        ..$ round-1: chr [1:5] "origin_date" "scenario_id" "location" "target" ...
        ..$ round-2: chr [1:6] "origin_date" "scenario_id" "location" "target" ...
       - attr(*, "round_ids")= chr [1:2] "round-1" "round-2"
       - attr(*, "task_ids_by_round")= logi TRUE
       - attr(*, "class")= chr "hub_connection"

# connect_hub works on yml hubmeta at specified path

    Code
      str(hub_con)
    Output
      List of 1
       $ round-1:List of 2
        ..$ model_tasks    :List of 1
        .. ..$ :List of 2
        .. .. ..$ task_ids    :List of 2
        .. .. .. ..$ origin_date:List of 2
        .. .. .. .. ..$ required: chr "2022-09-03"
        .. .. .. .. ..$ optional: NULL
        .. .. .. ..$ location   :List of 2
        .. .. .. .. ..$ required: chr [1:51] "01" "02" "04" "05" ...
        .. .. .. .. ..$ optional: chr "US"
        .. .. ..$ output_types:List of 1
        .. .. .. ..$ mean:List of 2
        .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. ..$ minimum: int 0
        ..$ submissions_due:List of 2
        .. ..$ start: chr "2022-09-01"
        .. ..$ end  : chr "2022-09-05"
       - attr(*, "hubmeta_path")= chr "test/hubmeta_path"
       - attr(*, "hub_path")= chr "test/hub_path"
       - attr(*, "task_id_names")=List of 1
        ..$ round-1: chr [1:2] "origin_date" "location"
       - attr(*, "round_ids")= chr "round-1"
       - attr(*, "task_ids_by_round")= logi TRUE
       - attr(*, "class")= chr "hub_connection"

# connect_hub print method works

    Code
      hub_con
    Message <cliMessage>
      
      -- <hub_connection> --
      
      i Connected to Hub at 'test/hub_path'
      i Connection configured using hubmeta file 'test/hubmeta_path'
      * task_ids_by_round: FALSE

---

    Code
      print(hub_con, verbose = TRUE)
    Message <cliMessage>
      
      -- <hub_connection> --
      
      i Connected to Hub at 'test/hub_path'
      i Connection configured using hubmeta file 'test/hubmeta_path'
      * task_ids_by_round: FALSE
    Output
      $round_id_from_variable
      $round_id_from_variable$model_tasks
      $round_id_from_variable$model_tasks[[1]]
      $round_id_from_variable$model_tasks[[1]]$task_ids
      $round_id_from_variable$model_tasks[[1]]$task_ids$origin_date
      $round_id_from_variable$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $round_id_from_variable$model_tasks[[1]]$task_ids$origin_date$optional
       [1] "2022-01-08" "2022-01-15" "2022-01-22" "2022-01-29" "2022-02-05"
       [6] "2022-02-12" "2022-02-19" "2022-02-26" "2022-03-05" "2022-03-12"
      [11] "2022-03-19" "2022-03-26" "2022-04-02" "2022-04-09" "2022-04-16"
      [16] "2022-04-23" "2022-04-30" "2022-05-07" "2022-05-14" "2022-05-21"
      [21] "2022-05-28" "2022-06-04" "2022-06-11" "2022-06-18"
      
      
      $round_id_from_variable$model_tasks[[1]]$task_ids$location
      $round_id_from_variable$model_tasks[[1]]$task_ids$location$required
      NULL
      
      $round_id_from_variable$model_tasks[[1]]$task_ids$location$optional
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56" "72" "78" "US"
      
      
      $round_id_from_variable$model_tasks[[1]]$task_ids$horizon
      $round_id_from_variable$model_tasks[[1]]$task_ids$horizon$required
      NULL
      
      $round_id_from_variable$model_tasks[[1]]$task_ids$horizon$optional
      [1] 1 2 3 4
      
      
      
      $round_id_from_variable$model_tasks[[1]]$output_types
      $round_id_from_variable$model_tasks[[1]]$output_types$mean
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$type_id
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$type_id$required
      NULL
      
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$type_id$optional
      [1] NA
      
      
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$value
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$value$type
      [1] "integer"
      
      $round_id_from_variable$model_tasks[[1]]$output_types$mean$value$minimum
      [1] 0
      
      
      
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$type_id
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$type_id$required
      NULL
      
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$type_id$optional
       [1] 0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
      [13] 0.550 0.600 0.650 0.700 0.750 0.800 0.850 0.900 0.950 0.975 0.990
      
      
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$value
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$value$type
      [1] "integer"
      
      $round_id_from_variable$model_tasks[[1]]$output_types$quantile$value$minimum
      [1] 0
      
      
      
      
      
      
      $round_id_from_variable$round_id_variable
      [1] "origin_date"
      
      $round_id_from_variable$submissions_due
      $round_id_from_variable$submissions_due$relative_to
      [1] "origin_date"
      
      $round_id_from_variable$submissions_due$start
      [1] -4
      
      $round_id_from_variable$submissions_due$end
      [1] 2
      
      
      
      attr(,"hubmeta_path")
      [1] "test/hubmeta_path"
      attr(,"hub_path")
      [1] "test/hub_path"
      attr(,"task_id_names")
      [1] "origin_date" "location"    "horizon"    
      attr(,"round_ids")
      [1] "origin_date"
      attr(,"task_ids_by_round")
      [1] FALSE
      attr(,"class")
      [1] "hub_connection"

