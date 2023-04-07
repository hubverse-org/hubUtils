# connect_hub works on simple forecasting hub

    Code
      str(hub_con)
    Output
      Classes 'hub_connection', 'FileSystemDataset', 'Dataset', 'ArrowObject', 'R6' <hub_connection>
        Inherits from: <FileSystemDataset>
        Public:
          .:xp:.: externalptr
          .class_title: function () 
          .unsafe_delete: function () 
          NewScan: function () 
          ToString: function () 
          WithSchema: function (schema) 
          class_title: function () 
          clone: function (deep = FALSE) 
          files: active binding
          filesystem: active binding
          format: active binding
          initialize: function (xp) 
          metadata: active binding
          num_cols: active binding
          num_rows: active binding
          pointer: function () 
          print: function (...) 
          schema: active binding
          set_pointer: function (xp) 
          type: active binding 
       - attr(*, "hub_name")= chr "Simple Forecast Hub"
       - attr(*, "file_format")= chr "csv"
       - attr(*, "hub_path")= chr "test/hub_path"
       - attr(*, "model_output_dir")= chr "test/model_output_dir"
       - attr(*, "config_admin")=List of 8
        ..$ schema_version: chr "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/admin-schema.json"
        ..$ name          : chr "Simple Forecast Hub"
        ..$ maintainer    : chr "Consortium of Infectious Disease Modeling Hubs"
        ..$ contact       :List of 2
        .. ..$ name : chr "Joe Bloggs"
        .. ..$ email: chr "j.bloggs@cidmh.com"
        ..$ repository_url: chr "https://github.com/Infectious-Disease-Modeling-Hubs/example-simple-forecast-hub"
        ..$ hub_models    :List of 1
        .. ..$ :List of 3
        .. .. ..$ team_abbr : chr "simple_hub"
        .. .. ..$ model_abbr: chr "baseline"
        .. .. ..$ model_type: chr "baseline"
        ..$ file_format   : chr "csv"
        ..$ timezone      : chr "US/Eastern"
       - attr(*, "config_tasks")=List of 2
        ..$ schema_version: chr "https://github.com/Infectious-Disease-Modeling-Hubs/schemas/blob/main/v0.0.1/tasks-schema.json"
        ..$ rounds        :List of 2
        .. ..$ :List of 4
        .. .. ..$ round_id_from_variable: logi TRUE
        .. .. ..$ round_id              : chr "origin_date"
        .. .. ..$ model_tasks           :List of 1
        .. .. .. ..$ :List of 3
        .. .. .. .. ..$ task_ids       :List of 4
        .. .. .. .. .. ..$ origin_date:List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:2] "2022-10-01" "2022-10-08"
        .. .. .. .. .. ..$ target     :List of 2
        .. .. .. .. .. .. ..$ required: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. ..$ horizon    :List of 2
        .. .. .. .. .. .. ..$ required: int 1
        .. .. .. .. .. .. ..$ optional: int [1:3] 2 3 4
        .. .. .. .. .. ..$ location   :List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:54] "US" "01" "02" "04" ...
        .. .. .. .. ..$ output_type    :List of 2
        .. .. .. .. .. ..$ mean    :List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. .. ..$ quantile:List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
        .. .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. ..$ target_metadata:List of 1
        .. .. .. .. .. ..$ :List of 7
        .. .. .. .. .. .. ..$ target_id    : chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_name  : chr "Weekly incident influenza hospitalizations"
        .. .. .. .. .. .. ..$ target_units : chr "count"
        .. .. .. .. .. .. ..$ target_keys  :List of 1
        .. .. .. .. .. .. .. ..$ target: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_type  : chr "continuous"
        .. .. .. .. .. .. ..$ is_step_ahead: logi TRUE
        .. .. .. .. .. .. ..$ time_unit    : chr "week"
        .. .. ..$ submissions_due       :List of 3
        .. .. .. ..$ relative_to: chr "origin_date"
        .. .. .. ..$ start      : int -6
        .. .. .. ..$ end        : int 1
        .. ..$ :List of 4
        .. .. ..$ round_id_from_variable: logi TRUE
        .. .. ..$ round_id              : chr "origin_date"
        .. .. ..$ model_tasks           :List of 1
        .. .. .. ..$ :List of 3
        .. .. .. .. ..$ task_ids       :List of 5
        .. .. .. .. .. ..$ origin_date:List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:4] "2022-10-15" "2022-10-15" "2022-10-22" "2022-10-29"
        .. .. .. .. .. ..$ target     :List of 2
        .. .. .. .. .. .. ..$ required: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. ..$ horizon    :List of 2
        .. .. .. .. .. .. ..$ required: int 1
        .. .. .. .. .. .. ..$ optional: int [1:3] 2 3 4
        .. .. .. .. .. ..$ location   :List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:54] "US" "01" "02" "04" ...
        .. .. .. .. .. ..$ age_group  :List of 2
        .. .. .. .. .. .. ..$ required: chr "65+"
        .. .. .. .. .. .. ..$ optional: chr [1:4] "0-5" "6-18" "19-24" "25-64"
        .. .. .. .. ..$ output_type    :List of 2
        .. .. .. .. .. ..$ mean    :List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. .. ..$ quantile:List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
        .. .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. ..$ target_metadata:List of 1
        .. .. .. .. .. ..$ :List of 7
        .. .. .. .. .. .. ..$ target_id    : chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_name  : chr "Weekly incident influenza hospitalizations"
        .. .. .. .. .. .. ..$ target_units : chr "count"
        .. .. .. .. .. .. ..$ target_keys  :List of 1
        .. .. .. .. .. .. .. ..$ target: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_type  : chr "continuous"
        .. .. .. .. .. .. ..$ is_step_ahead: logi TRUE
        .. .. .. .. .. .. ..$ time_unit    : chr "week"
        .. .. ..$ submissions_due       :List of 3
        .. .. .. ..$ relative_to: chr "origin_date"
        .. .. .. ..$ start      : int -6
        .. .. .. ..$ end        : int 1

# connect_hub print method works

    Code
      hub_con
    Message <cliMessage>
      
      -- <hub_connection/FileSystemDataset> --
      
      * hub_name: "Simple Forecast Hub"
      * hub_path: 'test/hub_path'
      * model_output_dir: "test/model_output_dir"
      * config_admin: 'hub-config/admin.json'
      * config_tasks: 'hub-config/tasks.json'
      
      -- Connection schema 
    Output
      hub_connection with 3 csv files
      origin_date: date32[day]
      target: string
      horizon: int64
      location: string
      type: string
      type_id: double
      value: int64
      team: string

---

    Code
      print(hub_con, verbose = TRUE)
    Message <cliMessage>
      
      -- <hub_connection/FileSystemDataset> --
      
      * hub_name: "Simple Forecast Hub"
      * hub_path: 'test/hub_path'
      * model_output_dir: "test/model_output_dir"
      * config_admin: 'hub-config/admin.json'
      * config_tasks: 'hub-config/tasks.json'
      
      -- Connection schema 
    Output
      hub_connection with 3 csv files
      origin_date: date32[day]
      target: string
      horizon: int64
      location: string
      type: string
      type_id: double
      value: int64
      team: string
      Classes 'hub_connection', 'FileSystemDataset', 'Dataset', 'ArrowObject', 'R6' <hub_connection>
        Inherits from: <FileSystemDataset>
        Public:
          .:xp:.: externalptr
          .class_title: function () 
          .unsafe_delete: function () 
          NewScan: function () 
          ToString: function () 
          WithSchema: function (schema) 
          class_title: function () 
          clone: function (deep = FALSE) 
          files: active binding
          filesystem: active binding
          format: active binding
          initialize: function (xp) 
          metadata: active binding
          num_cols: active binding
          num_rows: active binding
          pointer: function () 
          print: function (...) 
          schema: active binding
          set_pointer: function (xp) 
          type: active binding 
       - attr(*, "hub_name")= chr "Simple Forecast Hub"
       - attr(*, "file_format")= chr "csv"
       - attr(*, "hub_path")= chr "test/hub_path"
       - attr(*, "model_output_dir")= chr "test/model_output_dir"
       - attr(*, "config_admin")=List of 8
        ..$ schema_version: chr "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/admin-schema.json"
        ..$ name          : chr "Simple Forecast Hub"
        ..$ maintainer    : chr "Consortium of Infectious Disease Modeling Hubs"
        ..$ contact       :List of 2
        .. ..$ name : chr "Joe Bloggs"
        .. ..$ email: chr "j.bloggs@cidmh.com"
        ..$ repository_url: chr "https://github.com/Infectious-Disease-Modeling-Hubs/example-simple-forecast-hub"
        ..$ hub_models    :List of 1
        .. ..$ :List of 3
        .. .. ..$ team_abbr : chr "simple_hub"
        .. .. ..$ model_abbr: chr "baseline"
        .. .. ..$ model_type: chr "baseline"
        ..$ file_format   : chr "csv"
        ..$ timezone      : chr "US/Eastern"
       - attr(*, "config_tasks")=List of 2
        ..$ schema_version: chr "https://github.com/Infectious-Disease-Modeling-Hubs/schemas/blob/main/v0.0.1/tasks-schema.json"
        ..$ rounds        :List of 2
        .. ..$ :List of 4
        .. .. ..$ round_id_from_variable: logi TRUE
        .. .. ..$ round_id              : chr "origin_date"
        .. .. ..$ model_tasks           :List of 1
        .. .. .. ..$ :List of 3
        .. .. .. .. ..$ task_ids       :List of 4
        .. .. .. .. .. ..$ origin_date:List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:2] "2022-10-01" "2022-10-08"
        .. .. .. .. .. ..$ target     :List of 2
        .. .. .. .. .. .. ..$ required: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. ..$ horizon    :List of 2
        .. .. .. .. .. .. ..$ required: int 1
        .. .. .. .. .. .. ..$ optional: int [1:3] 2 3 4
        .. .. .. .. .. ..$ location   :List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:54] "US" "01" "02" "04" ...
        .. .. .. .. ..$ output_type    :List of 2
        .. .. .. .. .. ..$ mean    :List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. .. ..$ quantile:List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
        .. .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. ..$ target_metadata:List of 1
        .. .. .. .. .. ..$ :List of 7
        .. .. .. .. .. .. ..$ target_id    : chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_name  : chr "Weekly incident influenza hospitalizations"
        .. .. .. .. .. .. ..$ target_units : chr "count"
        .. .. .. .. .. .. ..$ target_keys  :List of 1
        .. .. .. .. .. .. .. ..$ target: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_type  : chr "continuous"
        .. .. .. .. .. .. ..$ is_step_ahead: logi TRUE
        .. .. .. .. .. .. ..$ time_unit    : chr "week"
        .. .. ..$ submissions_due       :List of 3
        .. .. .. ..$ relative_to: chr "origin_date"
        .. .. .. ..$ start      : int -6
        .. .. .. ..$ end        : int 1
        .. ..$ :List of 4
        .. .. ..$ round_id_from_variable: logi TRUE
        .. .. ..$ round_id              : chr "origin_date"
        .. .. ..$ model_tasks           :List of 1
        .. .. .. ..$ :List of 3
        .. .. .. .. ..$ task_ids       :List of 5
        .. .. .. .. .. ..$ origin_date:List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:4] "2022-10-15" "2022-10-15" "2022-10-22" "2022-10-29"
        .. .. .. .. .. ..$ target     :List of 2
        .. .. .. .. .. .. ..$ required: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. ..$ horizon    :List of 2
        .. .. .. .. .. .. ..$ required: int 1
        .. .. .. .. .. .. ..$ optional: int [1:3] 2 3 4
        .. .. .. .. .. ..$ location   :List of 2
        .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. ..$ optional: chr [1:54] "US" "01" "02" "04" ...
        .. .. .. .. .. ..$ age_group  :List of 2
        .. .. .. .. .. .. ..$ required: chr "65+"
        .. .. .. .. .. .. ..$ optional: chr [1:4] "0-5" "6-18" "19-24" "25-64"
        .. .. .. .. ..$ output_type    :List of 2
        .. .. .. .. .. ..$ mean    :List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: NULL
        .. .. .. .. .. .. .. ..$ optional: logi NA
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. .. ..$ quantile:List of 2
        .. .. .. .. .. .. ..$ type_id:List of 2
        .. .. .. .. .. .. .. ..$ required: num [1:23] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
        .. .. .. .. .. .. .. ..$ optional: NULL
        .. .. .. .. .. .. ..$ value  :List of 2
        .. .. .. .. .. .. .. ..$ type   : chr "integer"
        .. .. .. .. .. .. .. ..$ minimum: int 0
        .. .. .. .. ..$ target_metadata:List of 1
        .. .. .. .. .. ..$ :List of 7
        .. .. .. .. .. .. ..$ target_id    : chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_name  : chr "Weekly incident influenza hospitalizations"
        .. .. .. .. .. .. ..$ target_units : chr "count"
        .. .. .. .. .. .. ..$ target_keys  :List of 1
        .. .. .. .. .. .. .. ..$ target: chr "wk inc flu hosp"
        .. .. .. .. .. .. ..$ target_type  : chr "continuous"
        .. .. .. .. .. .. ..$ is_step_ahead: logi TRUE
        .. .. .. .. .. .. ..$ time_unit    : chr "week"
        .. .. ..$ submissions_due       :List of 3
        .. .. .. ..$ relative_to: chr "origin_date"
        .. .. .. ..$ start      : int -6
        .. .. .. ..$ end        : int 1

# connect_hub works on model_output_dir

    Code
      hub_con
    Message <cliMessage>
      
      -- <hub_connection/FileSystemDataset> --
      
      * hub_name:
      * hub_path: 'test/hub_path'
      * model_output_dir: "test/model_output_dir"
      
      -- Connection schema 
    Output
      hub_connection with 3 csv files
      origin_date: date32[day]
      target: string
      horizon: int64
      location: string
      type: string
      type_id: double
      value: int64
      team: string

---

    Code
      str(hub_con)
    Output
      Classes 'hub_connection', 'FileSystemDataset', 'Dataset', 'ArrowObject', 'R6' <hub_connection>
        Inherits from: <FileSystemDataset>
        Public:
          .:xp:.: externalptr
          .class_title: function () 
          .unsafe_delete: function () 
          NewScan: function () 
          ToString: function () 
          WithSchema: function (schema) 
          class_title: function () 
          clone: function (deep = FALSE) 
          files: active binding
          filesystem: active binding
          format: active binding
          initialize: function (xp) 
          metadata: active binding
          num_cols: active binding
          num_rows: active binding
          pointer: function () 
          print: function (...) 
          schema: active binding
          set_pointer: function (xp) 
          type: active binding 
       - attr(*, "file_format")= chr "csv"
       - attr(*, "model_output_dir")= chr "test/model_output_dir"
       - attr(*, "hub_path")= chr "test/hub_path"

# connect_hub data extraction works on simple forecasting hub

    Code
      hub_con %>% dplyr::filter(origin_date == "2022-10-08", horizon == 2, type_id ==
        0.01) %>% dplyr::collect()
    Output
      # A tibble: 3 x 8
        origin_date target          horizon location type     type_id value team    
        <date>      <chr>             <int> <chr>    <chr>      <dbl> <int> <chr>   
      1 2022-10-08  wk inc flu hosp       2 US       quantile    0.01   135 baseline
      2 2022-10-08  wk inc flu hosp       2 04       quantile    0.01   135 baseline
      3 2022-10-08  wk inc flu hosp       2 01       quantile    0.01   135 baseline

---

    Code
      model_output_con %>% dplyr::filter(origin_date == "2022-10-08", horizon == 2,
      type_id == 0.01) %>% dplyr::collect()
    Output
      # A tibble: 3 x 8
        origin_date target          horizon location type     type_id value team    
        <date>      <chr>             <int> <chr>    <chr>      <dbl> <int> <chr>   
      1 2022-10-08  wk inc flu hosp       2 US       quantile    0.01   135 baseline
      2 2022-10-08  wk inc flu hosp       2 04       quantile    0.01   135 baseline
      3 2022-10-08  wk inc flu hosp       2 01       quantile    0.01   135 baseline

