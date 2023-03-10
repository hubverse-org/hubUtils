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
      Caused by error in `check_value_type()`:
      x Argument `value_type` must be length 1, not 2.

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "character",
        value_maximum = 0L)
    Error <purrr_error_indexed>
      i In index: 1.
      Caused by error in `check_value_type()`:
      x Argument `value_type` value is invalid.
      ! Must be one of "numeric", "double", and "integer".
      i Actual value is "character"

---

    Code
      create_output_type_median(is_required = FALSE)
    Error <rlang_error>
      `value_type` is absent but must be supplied.

