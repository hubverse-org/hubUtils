# create_task_id works correctly

    Code
      create_task_id("horizon", required = 1L, optional = 2:4)
    Output
      $horizon
      $horizon$required
      [1] 1
      
      $horizon$optional
      [1] 2 3 4
      
      

---

    Code
      create_task_id("origin_date", required = NULL, optional = c("2023-01-02",
        "2023-01-09", "2023-01-16"))
    Output
      $origin_date
      $origin_date$required
      NULL
      
      $origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      

---

    Code
      create_task_id("scenario_id", required = NULL, optional = c("A-2021-03-28",
        "B-2021-03-28"))
    Output
      $scenario_id
      $scenario_id$required
      NULL
      
      $scenario_id$optional
      [1] "A-2021-03-28" "B-2021-03-28"
      
      

---

    Code
      create_task_id("scenario_id", required = NULL, optional = c(1L, 2L))
    Output
      $scenario_id
      $scenario_id$required
      NULL
      
      $scenario_id$optional
      [1] 1 2
      
      

# create_task_id errors correctly

    Code
      create_task_id("horizon", required = NULL, optional = NULL)
    Error <rlang_error>
      x Both arguments `required` and `optional` cannot be NULL.

---

    Code
      create_task_id("origin_date", required = NULL, optional = c("01/20/2023"))
    Error <purrr_error_indexed>
      i In index: 2.
      Caused by error in `check_task_id_input()`:
      x Argument `optional` must be valid ISO 8601 date format (YYYY-MM-DD).

---

    Code
      create_task_id("scenario_id", required = NULL, optional = c(1L, 1L))
    Error <rlang_error>
      x Values across arguments `required` and `optional` must be unique.
      ! Provided value 1 is duplicated.

---

    Code
      create_task_id("horizon", required = c(TRUE, FALSE), optional = NULL)
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `check_task_id_input()`:
      x Argument `required` is of type <logical>.
      ! Must be one of <integer/character>.
