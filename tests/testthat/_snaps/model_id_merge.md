# merging-splitting model_id works

    Code
      model_id_split(tbl)
    Output
      # A tibble: 92 x 9
         team_abbr model_abbr forecast_date horizon target        location output_type
         <chr>     <chr>      <date>          <int> <chr>         <chr>    <chr>      
       1 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       2 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       3 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       4 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       5 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       6 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       7 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       8 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
       9 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
      10 hub       baseline   2023-05-08          1 wk ahead inc~ US       quantile   
      # i 82 more rows
      # i 2 more variables: output_type_id <chr>, value <dbl>

---

    Code
      model_id_split(tbl)
    Error <rlang_error>
      x Cannot split `model_id` column.
      ! Required column "model_id" missing from `tbl`.

---

    Code
      model_id_merge(tbl)
    Error <rlang_error>
      x Cannot create `model_id` column.
      ! Required columns "model_abbr" and "team_abbr" missing from `tbl`.

