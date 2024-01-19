# create_output_type_point functions work correctly

    Code
      create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L)
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      [1] NA
      
      $mean$output_type_id$optional
      NULL
      
      
      $mean$value
      $mean$value$type
      [1] "double"
      
      $mean$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "integer",
        value_maximum = 0L)
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      NULL
      
      $mean$output_type_id$optional
      [1] NA
      
      
      $mean$value
      $mean$value$type
      [1] "integer"
      
      $mean$value$maximum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_median(is_required = FALSE, value_type = "double")
    Output
      $median
      $median$output_type_id
      $median$output_type_id$required
      NULL
      
      $median$output_type_id$optional
      [1] NA
      
      
      $median$value
      $median$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_median(is_required = FALSE, value_type = "double",
        schema_version = "v1.0.0")
    Condition
      Warning:
      Hub configured using schema version v1.0.0. Support for schema earlier than v2.0.0 was deprecated in hubUtils 0.0.0.9010.
      i Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as soon as possible.
    Output
      $median
      $median$type_id
      $median$type_id$required
      NULL
      
      $median$type_id$optional
      [1] NA
      
      
      $median$value
      $median$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v1.0.0/tasks-schema.json"

# create_output_type_point functions error correctly

    Code
      create_output_type_mean(is_required = "TRUE", value_type = "double")
    Condition
      Error in `create_output_type_point()`:
      x Argument `is_required` must be <logical> and have length 1.

---

    Code
      create_output_type_mean(is_required = TRUE, value_type = c("double", "integer"))
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` must be length 1, not 2.

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "character",
        value_maximum = 0L)
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` value is invalid.
      ! Must be one of "double" and "integer".
      i Actual value is "character"

---

    Code
      create_output_type_median(is_required = FALSE)
    Condition
      Error in `create_output_type_point()`:
      ! `value_type` is absent but must be supplied.

# create_output_type_dist functions work correctly

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0)
    Output
      $quantile
      $quantile$output_type_id
      $quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      $quantile$output_type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $quantile$value
      $quantile$value$type
      [1] "double"
      
      $quantile$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_cdf(required = c(10, 20), optional = NULL, value_type = "double")
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      [1] 10 20
      
      $cdf$output_type_id$optional
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
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW202242"), value_type = "double")
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      NULL
      
      $cdf$output_type_id$optional
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
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_pmf(required = NULL, optional = c("low", "moderate", "high",
        "extreme"), value_type = "double")
    Output
      $pmf
      $pmf$output_type_id
      $pmf$output_type_id$required
      NULL
      
      $pmf$output_type_id$optional
      [1] "low"      "moderate" "high"     "extreme" 
      
      
      $pmf$value
      $pmf$value$type
      [1] "double"
      
      $pmf$value$minimum
      [1] 0
      
      $pmf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_sample(required = 1:10, optional = 11:15, value_type = "double")
    Output
      $sample
      $sample$output_type_id
      $sample$output_type_id$required
       [1]  1  2  3  4  5  6  7  8  9 10
      
      $sample$output_type_id$optional
      [1] 11 12 13 14 15
      
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0,
      schema_version = "v1.0.0")
    Condition
      Warning:
      Hub configured using schema version v1.0.0. Support for schema earlier than v2.0.0 was deprecated in hubUtils 0.0.0.9010.
      i Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as soon as possible.
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
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v1.0.0/tasks-schema.json"

# create_output_type_dist functions error correctly

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW2022423"), value_type = "double")
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `create_output_type_cdf()`:
      ! The maximum number of characters allowed for values in `optional` is 8.
      x Value "EW2022423" has more characters than allowed

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.6, 0.75), optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double",
      value_minimum = 0)
    Condition
      Error in `check_prop_dups()`:
      x Values across arguments `required` and `optional` must be unique.
      ! Provided value 0.6 is duplicated.

---

    Code
      create_output_type_sample(required = 0:10, optional = 11:15, value_type = "double")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      ! All values in `required` must be equal to or greater than 1.
      x Value 0 is less.

---

    Code
      create_output_type_sample(required = 1:10, optional = 11:15, value_type = "character")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      x `value_type` value is invalid.
      ! Must be one of "double" and "integer".
      i Actual value is "character"

# create_output_type_dist functions creates expected warnings

    Code
      create_output_type_sample(required = 1:50, optional = NULL, value_type = "double",
      value_minimum = 0L, value_maximum = 1L)
    Condition
      Warning in `create_output_type_sample()`:
      ! Cannot determine appropriate type for argument `value_minimum`, type validation skipped.  Schema may be invalid. Consult relevant schema and consider opening an issue at <https://github.com/Infectious-Disease-Modeling-Hubs/schemas/issues>
      Warning in `create_output_type_sample()`:
      ! Cannot determine appropriate type for argument `value_maximum`, type validation skipped.  Schema may be invalid. Consult relevant schema and consider opening an issue at <https://github.com/Infectious-Disease-Modeling-Hubs/schemas/issues>
    Output
      $sample
      $sample$output_type_id
      $sample$output_type_id$required
       [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
      [26] 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50
      
      $sample$output_type_id$optional
      NULL
      
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      $sample$value$minimum
      [1] 0
      
      $sample$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

