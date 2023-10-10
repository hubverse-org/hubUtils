# create_output_type functions work correctly

    Code
      create_output_type(create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L), create_output_type_median(is_required = FALSE,
        value_type = "double"), create_output_type_quantile(required = c(0.25, 0.5,
        0.75), optional = c(0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double",
      value_minimum = 0))
    Output
      $output_type
      $output_type$mean
      $output_type$mean$output_type_id
      $output_type$mean$output_type_id$required
      [1] NA
      
      $output_type$mean$output_type_id$optional
      NULL
      
      
      $output_type$mean$value
      $output_type$mean$value$type
      [1] "double"
      
      $output_type$mean$value$minimum
      [1] 0
      
      
      
      $output_type$median
      $output_type$median$output_type_id
      $output_type$median$output_type_id$required
      NULL
      
      $output_type$median$output_type_id$optional
      [1] NA
      
      
      $output_type$median$value
      $output_type$median$value$type
      [1] "double"
      
      
      
      $output_type$quantile
      $output_type$quantile$output_type_id
      $output_type$quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      $output_type$quantile$output_type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $output_type$quantile$value
      $output_type$quantile$value$type
      [1] "double"
      
      $output_type$quantile$value$minimum
      [1] 0
      
      
      
      
      attr(,"class")
      [1] "output_type" "list"       
      attr(,"n")
      [1] 3
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v2.0.0/tasks-schema.json"

# create_output_type functions error correctly

    Code
      create_output_type(create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L), create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L))
    Condition
      Error in `create_output_type()`:
      ! `names` must be unique across all items.
      x Item 2 with `name` "mean" is duplicate.

---

    Code
      create_output_type(create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L), list(a = "b"))
    Condition
      Error in `create_output_type()`:
      ! All items supplied must inherit from class <output_type_item>
      x Item 2 does not.

