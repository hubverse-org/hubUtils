# get_round_ids works

    Assertion on 'con' failed: Must inherit from class 'hub_connection', but has class 'list'.

# get_task_ids works

    x "random-round-id" is not a valid `round_id` value.
    x No valid `round_id` value supplied.
    i Accepted `round_id` values are "round-1" and "round-2"

# get_task_id_vals works

    Code
      get_task_id_vals(hub_con, task_id = "location")
    Output
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56" "72" "78" "US"

---

    Code
      get_task_id_vals(hub_con, task_id = "horizon")
    Output
      [1] 1 2 3 4

---

    Code
      get_task_id_vals(hub_con, round_id = "round-1", task_id = "location")
    Output
       [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
      [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
      [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
      [46] "50" "51" "53" "54" "55" "56" "US"

---

    x "random_task_id" is not a valid `task_id`for "round-2".
    x No valid task ids suppliedfor "round-2".
    i Accepted `task_id` values are "origin_date", "scenario_id", "location", "target", "age_group", and "horizon".

