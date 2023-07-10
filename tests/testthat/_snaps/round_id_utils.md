# get_round_ids works correctly

    Code
      get_round_ids(config_tasks)
    Output
      [1] "2022-10-01" "2022-10-08" "2022-10-15" "2022-10-22" "2022-10-29"

---

    Code
      get_round_ids(config_tasks, flatten = FALSE)
    Output
      [[1]]
      [1] "2022-10-01" "2022-10-08"
      
      [[2]]
      [1] "2022-10-15" "2022-10-22" "2022-10-29"
      

---

    Code
      get_round_ids(config_tasks)
    Output
       [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
       [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
      [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
      [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
      [21] "2023-05-01" "2023-05-08" "2023-05-15"

---

    Code
      get_round_ids(config_tasks, flatten = FALSE)
    Output
      [[1]]
       [1] "2022-12-12" "2022-12-19" "2022-12-26" "2023-01-02" "2023-01-09"
       [6] "2023-01-16" "2023-01-23" "2023-01-30" "2023-02-06" "2023-02-13"
      [11] "2023-02-20" "2023-02-27" "2023-03-06" "2023-03-13" "2023-03-20"
      [16] "2023-03-27" "2023-04-03" "2023-04-10" "2023-04-17" "2023-04-24"
      [21] "2023-05-01" "2023-05-08" "2023-05-15"
      

# get_round_idx works correctly

    Code
      get_round_idx(config_tasks, "2022-10-01")
    Output
      [1] 1

---

    Code
      get_round_idx(config_tasks, "2022-10-29")
    Output
      [1] 2

---

    Code
      get_round_idx(config_tasks)
    Error <rlang_error>
      `round_id` must be a character vector, not absent.

---

    Code
      get_round_idx(config_tasks, round_id = "2023-01-02")
    Output
      [1] 1

---

    Code
      get_round_idx(config_tasks)
    Error <rlang_error>
      `round_id` must be a character vector, not absent.

