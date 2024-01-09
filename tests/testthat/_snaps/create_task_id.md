# create_task_id works correctly

    Code
      create_task_id("horizon", required = 1L, optional = 2:4)
    Output
      $horizon
      $horizon$required
      [1] 1
      
      $horizon$optional
      [1] 2 3 4
      
      
      attr(,"class")
      [1] "task_id" "list"   
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

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
      
      
      attr(,"class")
      [1] "task_id" "list"   
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

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
      
      
      attr(,"class")
      [1] "task_id" "list"   
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_task_id("scenario_id", required = NULL, optional = c(1L, 2L))
    Output
      $scenario_id
      $scenario_id$required
      NULL
      
      $scenario_id$optional
      [1] 1 2
      
      
      attr(,"class")
      [1] "task_id" "list"   
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_task_id errors correctly

    Code
      create_task_id("horizon", required = NULL, optional = NULL)
    Condition
      Error in `check_prop_not_all_null()`:
      x Both arguments `required` and `optional` cannot be NULL.

---

    Code
      create_task_id("origin_date", required = NULL, optional = c("01/20/2023"))
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `create_task_id()`:
      x `optional` value must be character string of date in valid ISO 8601 format (YYYY-MM-DD).

---

    Code
      create_task_id("scenario_id", required = NULL, optional = c(1L, 1L))
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `create_task_id()`:
      ! All values in `optional` must be unique.
      x Value 1 is duplicated.

---

    Code
      create_task_id("horizon", required = c(TRUE, FALSE), optional = NULL)
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_task_id()`:
      x `required` is of type <logical>.
      ! Must be one of <integer/character>.

