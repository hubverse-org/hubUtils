# connect_hub works on simple forecasting hub

    Code
      hub_con
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
      [1] ""
      attr(,"hub_path")
      [1] ""
      attr(,"task_id_names")
      [1] "origin_date" "location"    "horizon"    
      attr(,"round_ids")
      [1] "origin_date"
      attr(,"task_ids_by_round")
      [1] FALSE
      attr(,"class")
      [1] "list"           "hub_connection"

# connect_hub works on scenario hub

    Code
      hub_con
    Output
      $`round-1`
      $`round-1`$model_tasks
      $`round-1`$model_tasks[[1]]
      $`round-1`$model_tasks[[1]]$task_ids
      $`round-1`$model_tasks[[1]]$task_ids$origin_date
      $`round-1`$model_tasks[[1]]$task_ids$origin_date$required
      [1] "2022-09-03"
      
      $`round-1`$model_tasks[[1]]$task_ids$origin_date$optional
      NULL
      
      
      $`round-1`$model_tasks[[1]]$task_ids$scenario_id
      $`round-1`$model_tasks[[1]]$task_ids$scenario_id$required
      [1] 1
      
      $`round-1`$model_tasks[[1]]$task_ids$scenario_id$optional
      NULL
      
      
      $`round-1`$model_tasks[[1]]$task_ids$location
      $`round-1`$model_tasks[[1]]$task_ids$location$required
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56"
      
      $`round-1`$model_tasks[[1]]$task_ids$location$optional
      [1] "US"
      
      
      $`round-1`$model_tasks[[1]]$task_ids$target
      $`round-1`$model_tasks[[1]]$task_ids$target$required
      NULL
      
      $`round-1`$model_tasks[[1]]$task_ids$target$optional
      [1] "weekly rate"
      
      
      $`round-1`$model_tasks[[1]]$task_ids$horizon
      $`round-1`$model_tasks[[1]]$task_ids$horizon$required
      NULL
      
      $`round-1`$model_tasks[[1]]$task_ids$horizon$optional
      [1] 1 2
      
      
      
      $`round-1`$model_tasks[[1]]$output_types
      $`round-1`$model_tasks[[1]]$output_types$mean
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id$required
      NULL
      
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id$optional
      [1] NA
      
      
      $`round-1`$model_tasks[[1]]$output_types$mean$value
      $`round-1`$model_tasks[[1]]$output_types$mean$value$type
      [1] "integer"
      
      $`round-1`$model_tasks[[1]]$output_types$mean$value$minimum
      [1] 0
      
      
      
      $`round-1`$model_tasks[[1]]$output_types$quantile
      $`round-1`$model_tasks[[1]]$output_types$quantile$type_id
      $`round-1`$model_tasks[[1]]$output_types$quantile$type_id$required
      [1] 0.25 0.50 0.75
      
      $`round-1`$model_tasks[[1]]$output_types$quantile$type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $`round-1`$model_tasks[[1]]$output_types$quantile$value
      $`round-1`$model_tasks[[1]]$output_types$quantile$value$type
      [1] "integer"
      
      $`round-1`$model_tasks[[1]]$output_types$quantile$value$minimum
      [1] 0
      
      
      
      $`round-1`$model_tasks[[1]]$output_types$cdf
      $`round-1`$model_tasks[[1]]$output_types$cdf$type_id
      $`round-1`$model_tasks[[1]]$output_types$cdf$type_id$required
      [1] 10 20
      
      $`round-1`$model_tasks[[1]]$output_types$cdf$type_id$optional
      NULL
      
      
      $`round-1`$model_tasks[[1]]$output_types$cdf$value
      $`round-1`$model_tasks[[1]]$output_types$cdf$value$type
      [1] "numeric"
      
      $`round-1`$model_tasks[[1]]$output_types$cdf$value$minimum
      [1] 0
      
      $`round-1`$model_tasks[[1]]$output_types$cdf$value$maximum
      [1] 1
      
      
      
      
      
      $`round-1`$model_tasks[[2]]
      $`round-1`$model_tasks[[2]]$task_ids
      $`round-1`$model_tasks[[2]]$task_ids$origin_date
      $`round-1`$model_tasks[[2]]$task_ids$origin_date$required
      [1] "2022-09-03"
      
      $`round-1`$model_tasks[[2]]$task_ids$origin_date$optional
      NULL
      
      
      $`round-1`$model_tasks[[2]]$task_ids$scenario_id
      $`round-1`$model_tasks[[2]]$task_ids$scenario_id$required
      [1] 1
      
      $`round-1`$model_tasks[[2]]$task_ids$scenario_id$optional
      NULL
      
      
      $`round-1`$model_tasks[[2]]$task_ids$location
      $`round-1`$model_tasks[[2]]$task_ids$location$required
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56"
      
      $`round-1`$model_tasks[[2]]$task_ids$location$optional
      [1] "US"
      
      
      $`round-1`$model_tasks[[2]]$task_ids$target
      $`round-1`$model_tasks[[2]]$task_ids$target$required
      NULL
      
      $`round-1`$model_tasks[[2]]$task_ids$target$optional
      [1] "peak week"
      
      
      $`round-1`$model_tasks[[2]]$task_ids$horizon
      $`round-1`$model_tasks[[2]]$task_ids$horizon$required
      NULL
      
      $`round-1`$model_tasks[[2]]$task_ids$horizon$optional
      [1] NA
      
      
      
      $`round-1`$model_tasks[[2]]$output_types
      $`round-1`$model_tasks[[2]]$output_types$cdf
      $`round-1`$model_tasks[[2]]$output_types$cdf$type_id
      $`round-1`$model_tasks[[2]]$output_types$cdf$type_id$required
       [1] "EW202240"  "EW202241"  "EW202242"  "EW202243"  "EW202244"  "EW202245" 
       [7] "EW202246"  "EW202247"  "EW202248"  "EW202249"  "EW202250"  "EW202251" 
      [13] "EW202252"  "EW202301"  "EW202302"  "EW202303"  "EW202304"  "EW202305" 
      [19] "EW202306"  "EW202307"  "EW202308"  "EW202309"  "EW202310"  "EW2023011"
      [25] "EW202312"  "EW202313"  "EW202314"  "EW202315"  "EW202316"  "EW202317" 
      [31] "EW202318"  "EW202319"  "EW202320" 
      
      $`round-1`$model_tasks[[2]]$output_types$cdf$type_id$optional
      NULL
      
      
      $`round-1`$model_tasks[[2]]$output_types$cdf$value
      $`round-1`$model_tasks[[2]]$output_types$cdf$value$type
      [1] "numeric"
      
      $`round-1`$model_tasks[[2]]$output_types$cdf$value$minimum
      [1] 0
      
      
      
      
      
      
      $`round-1`$submissions_due
      $`round-1`$submissions_due$start
      [1] "2022-09-01"
      
      $`round-1`$submissions_due$end
      [1] "2022-09-05"
      
      
      
      $`round-2`
      $`round-2`$model_tasks
      $`round-2`$model_tasks[[1]]
      $`round-2`$model_tasks[[1]]$task_ids
      $`round-2`$model_tasks[[1]]$task_ids$origin_date
      $`round-2`$model_tasks[[1]]$task_ids$origin_date$required
      [1] "2022-10-01"
      
      $`round-2`$model_tasks[[1]]$task_ids$origin_date$optional
      NULL
      
      
      $`round-2`$model_tasks[[1]]$task_ids$scenario_id
      $`round-2`$model_tasks[[1]]$task_ids$scenario_id$required
      NULL
      
      $`round-2`$model_tasks[[1]]$task_ids$scenario_id$optional
      [1] 2 3
      
      
      $`round-2`$model_tasks[[1]]$task_ids$location
      $`round-2`$model_tasks[[1]]$task_ids$location$required
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56"
      
      $`round-2`$model_tasks[[1]]$task_ids$location$optional
      [1] "US"
      
      
      $`round-2`$model_tasks[[1]]$task_ids$target
      $`round-2`$model_tasks[[1]]$task_ids$target$required
      NULL
      
      $`round-2`$model_tasks[[1]]$task_ids$target$optional
      [1] "weekly rate"
      
      
      $`round-2`$model_tasks[[1]]$task_ids$horizon
      $`round-2`$model_tasks[[1]]$task_ids$horizon$required
      NULL
      
      $`round-2`$model_tasks[[1]]$task_ids$horizon$optional
      [1] 1 2
      
      
      
      $`round-2`$model_tasks[[1]]$output_types
      $`round-2`$model_tasks[[1]]$output_types$quantile
      $`round-2`$model_tasks[[1]]$output_types$quantile$type_id
      $`round-2`$model_tasks[[1]]$output_types$quantile$type_id$required
      [1] 0.25 0.50 0.75
      
      $`round-2`$model_tasks[[1]]$output_types$quantile$type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $`round-2`$model_tasks[[1]]$output_types$quantile$value
      $`round-2`$model_tasks[[1]]$output_types$quantile$value$type
      [1] "integer"
      
      $`round-2`$model_tasks[[1]]$output_types$quantile$value$minimum
      [1] 0
      
      
      
      
      
      
      $`round-2`$submissions_due
      $`round-2`$submissions_due$start
      [1] "2022-09-28"
      
      $`round-2`$submissions_due$end
      [1] "2022-10-01"
      
      
      $`round-2`$last_data_date
      [1] "2022-09-30"
      
      
      attr(,"hubmeta_path")
      [1] ""
      attr(,"hub_path")
      [1] ""
      attr(,"task_id_names")
      attr(,"task_id_names")$`round-1`
      [1] "origin_date" "scenario_id" "location"    "target"      "horizon"    
      
      attr(,"task_id_names")$`round-2`
      [1] "origin_date" "scenario_id" "location"    "target"      "horizon"    
      
      attr(,"round_ids")
      [1] "round-1" "round-2"
      attr(,"task_ids_by_round")
      [1] TRUE
      attr(,"class")
      [1] "list"           "hub_connection"

# connect_hub works on yml hubmeta at specified path

    Code
      hub_con
    Output
      $`round-1`
      $`round-1`$model_tasks
      $`round-1`$model_tasks[[1]]
      $`round-1`$model_tasks[[1]]$task_ids
      $`round-1`$model_tasks[[1]]$task_ids$origin_date
      $`round-1`$model_tasks[[1]]$task_ids$origin_date$required
      [1] "2022-09-03"
      
      $`round-1`$model_tasks[[1]]$task_ids$origin_date$optional
      NULL
      
      
      $`round-1`$model_tasks[[1]]$task_ids$location
      $`round-1`$model_tasks[[1]]$task_ids$location$required
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56"
      
      $`round-1`$model_tasks[[1]]$task_ids$location$optional
      [1] "US"
      
      
      
      $`round-1`$model_tasks[[1]]$output_types
      $`round-1`$model_tasks[[1]]$output_types$mean
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id$required
      NULL
      
      $`round-1`$model_tasks[[1]]$output_types$mean$type_id$optional
      [1] NA
      
      
      $`round-1`$model_tasks[[1]]$output_types$mean$value
      $`round-1`$model_tasks[[1]]$output_types$mean$value$type
      [1] "integer"
      
      $`round-1`$model_tasks[[1]]$output_types$mean$value$minimum
      [1] 0
      
      
      
      
      
      
      $`round-1`$submissions_due
      $`round-1`$submissions_due$start
      [1] "2022-09-01"
      
      $`round-1`$submissions_due$end
      [1] "2022-09-05"
      
      
      
      attr(,"hubmeta_path")
      [1] ""
      attr(,"hub_path")
      [1] ""
      attr(,"task_id_names")
      attr(,"task_id_names")$`round-1`
      [1] "origin_date" "location"   
      
      attr(,"round_ids")
      [1] "round-1"
      attr(,"task_ids_by_round")
      [1] TRUE
      attr(,"class")
      [1] "list"           "hub_connection"

