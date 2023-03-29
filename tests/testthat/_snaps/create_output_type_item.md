# create_output_type_point functions work correctly

    Code
      create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L)
    Output
      $mean
      $mean$type_id
      $mean$type_id$required
      [1] NA
      
      $mean$type_id$optional
      NULL
      
      
      $mean$value
      $mean$value$type
      [1] "double"
      
      $mean$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "integer",
        value_maximum = 0L)
    Output
      $mean
      $mean$type_id
      $mean$type_id$required
      NULL
      
      $mean$type_id$optional
      [1] NA
      
      
      $mean$value
      $mean$value$type
      [1] "integer"
      
      $mean$value$maximum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_median(is_required = FALSE, value_type = "numeric")
    Output
      $median
      $median$type_id
      $median$type_id$required
      NULL
      
      $median$type_id$optional
      [1] NA
      
      
      $median$value
      $median$value$type
      [1] "numeric"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

# create_output_type_point functions error correctly

    Code
      create_output_type_mean(is_required = "TRUE", value_type = "double")
    Error <rlang_error>
      x Argument `is_required` must be <logical> and have length 1.

---

    Code
      create_output_type_mean(is_required = TRUE, value_type = c("double", "numeric"))
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` must be length 1, not 2.

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "character",
        value_maximum = 0L)
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` value is invalid.
      ! Must be one of "numeric", "double", and "integer".
      i Actual value is "character"

---

    Code
      create_output_type_median(is_required = FALSE)
    Error <rlang_error>
      `value_type` is absent but must be supplied.

# create_output_type_dist functions work correctly

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0)
    Output
      $quantile
      $quantile$type_id
      $quantile$type_id$required
      [1] 0.25 0.50 0.75
      
      $quantile$type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $quantile$value
      $quantile$value$type
      [1] "double"
      
      $quantile$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_cdf(required = c(10, 20), optional = NULL, value_type = "double")
    Output
      $cdf
      $cdf$type_id
      $cdf$type_id$required
      [1] 10 20
      
      $cdf$type_id$optional
      NULL
      
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW202242"), value_type = "double")
    Output
      $cdf
      $cdf$type_id
      $cdf$type_id$required
      NULL
      
      $cdf$type_id$optional
      [1] "EW202240" "EW202241" "EW202242"
      
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_categorical(required = NULL, optional = c("low", "moderate",
        "high", "extreme"), value_type = "double")
    Output
      $categorical
      $categorical$type_id
      $categorical$type_id$required
      NULL
      
      $categorical$type_id$optional
      [1] "low"      "moderate" "high"     "extreme" 
      
      
      $categorical$value
      $categorical$value$type
      [1] "double"
      
      $categorical$value$minimum
      [1] 0
      
      $categorical$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

---

    Code
      create_output_type_sample(required = 1:10, optional = 11:15, value_type = "double")
    Output
      $sample
      $sample$type_id
      $sample$type_id$required
       [1]  1  2  3  4  5  6  7  8  9 10
      
      $sample$type_id$optional
      [1] 11 12 13 14 15
      
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json"

# create_output_type_dist functions error correctly

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW2022423"), value_type = "double")
    Error <purrr_error_indexed>
      i In index: 2.
      Caused by error in `create_output_type_cdf()`:
      ! The maximum number of characters allowed for values in `optional` is 8.
      x Value "EW2022423" has more characters than allowed

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.6, 0.75), optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double",
      value_minimum = 0)
    Error <rlang_error>
      x Values across arguments `required` and `optional` must be unique.
      ! Provided value 0.6 is duplicated.

---

    Code
      create_output_type_sample(required = 0:10, optional = 11:15, value_type = "double")
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      ! All values in `required` must be equal to or greater than 1.
      x Value 0 is less.

---

    Code
      create_output_type_sample(required = 1:10, optional = 11:15, value_type = "character")
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      x `value_type` value is invalid.
      ! Must be one of "numeric", "double", and "integer".
      i Actual value is "character"

