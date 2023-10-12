# create_task_ids functions work correctly

    Code
      create_task_ids(create_task_id("origin_date", required = NULL, optional = c(
        "2023-01-02", "2023-01-09", "2023-01-16")), create_task_id("scenario_id",
        required = NULL, optional = c("A-2021-03-28", "B-2021-03-28")),
      create_task_id("location", required = "US", optional = c("01", "02", "04", "05",
        "06")), create_task_id("target", required = "inc hosp", optional = NULL),
      create_task_id("horizon", required = 1L, optional = 2:4))
    Output
      $task_ids
      $task_ids$origin_date
      $task_ids$origin_date$required
      NULL
      
      $task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $task_ids$scenario_id
      $task_ids$scenario_id$required
      NULL
      
      $task_ids$scenario_id$optional
      [1] "A-2021-03-28" "B-2021-03-28"
      
      
      $task_ids$location
      $task_ids$location$required
      [1] "US"
      
      $task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $task_ids$target
      $task_ids$target$required
      [1] "inc hosp"
      
      $task_ids$target$optional
      NULL
      
      
      $task_ids$horizon
      $task_ids$horizon$required
      [1] 1
      
      $task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      attr(,"class")
      [1] "task_ids" "list"    
      attr(,"n")
      [1] 5
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_task_ids functions error correctly

    Code
      create_task_ids(create_task_id("origin_date", required = NULL, optional = c(
        "2023-01-02", "2023-01-09", "2023-01-16")), create_task_id("origin_date",
        required = NULL, optional = c("2023-01-02", "2023-01-09", "2023-01-16")))
    Condition
      Error in `create_task_ids()`:
      ! `names` must be unique across all items.
      x Item 2 with `name` "origin_date" is duplicate.

---

    Code
      create_task_ids(create_task_id("origin_date", required = NULL, optional = c(
        "2023-01-02", "2023-01-09", "2023-01-16")), list(a = 10), list(b = 10))
    Condition
      Error in `create_task_ids()`:
      ! All items supplied must inherit from class <task_id>
      x Items 2 and 3 do not.

---

    Code
      create_task_ids(item_1, create_task_id("scenario_id", required = NULL,
        optional = c("A-2021-03-28", "B-2021-03-28")))
    Condition
      Error in `create_task_ids()`:
      ! All items supplied must be created against the same Hub schema.
      x `schema_id` attributes are not consistent across all items.
      Item `schema_id` attributes:
      * Item 1 : invalid_schema
      * Item 2 : https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json

