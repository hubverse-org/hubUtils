# connect_hub works on local simple forecasting hub

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
       - attr(*, "file_system")=Classes 'LocalFileSystem', 'FileSystem', 'ArrowObject', 'R6' <LocalFileSystem>
        Inherits from: <FileSystem>
        Public:
          .:xp:.: externalptr
          .unsafe_delete: function () 
          CopyFile: function (src, dest) 
          CreateDir: function (path, recursive = TRUE) 
          DeleteDir: function (path) 
          DeleteDirContents: function (path) 
          DeleteFile: function (path) 
          DeleteFiles: function (paths) 
          GetFileInfo: function (x) 
          Move: function (src, dest) 
          OpenAppendStream: function (path) 
          OpenInputFile: function (path) 
          OpenInputStream: function (path) 
          OpenOutputStream: function (path) 
          cd: function (x) 
          class_title: function () 
          clone: function (deep = FALSE) 
          initialize: function (xp) 
          ls: function (path = "", ...) 
          path: function (x) 
          pointer: function () 
          print: function (...) 
          set_pointer: function (xp) 
          type_name: active binding
          url_scheme: active binding 
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

# connect_model_output works on local model_output_dir

    Code
      mod_out_con
    Message <cliMessage>
      
      -- <mod_out_connection/FileSystemDataset> --
      
      * file_format: "csv"
      * file_system: "LocalFileSystem"
      * model_output_dir: "test/model_output_dir"
      
      -- Connection schema 
    Output
      mod_out_connection with 4 csv files
      origin_date: date32[day]
      target: string
      horizon: int64
      location: string
      type: string
      type_id: double
      value: int64
      age_group: string
      model: string

---

    Code
      str(mod_out_con)
    Output
      Classes 'mod_out_connection', 'FileSystemDataset', 'Dataset', 'ArrowObject', 'R6' <mod_out_connection>
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
       - attr(*, "file_system")=Classes 'LocalFileSystem', 'FileSystem', 'ArrowObject', 'R6' <LocalFileSystem>
        Inherits from: <FileSystem>
        Public:
          .:xp:.: externalptr
          .unsafe_delete: function () 
          CopyFile: function (src, dest) 
          CreateDir: function (path, recursive = TRUE) 
          DeleteDir: function (path) 
          DeleteDirContents: function (path) 
          DeleteFile: function (path) 
          DeleteFiles: function (paths) 
          GetFileInfo: function (x) 
          Move: function (src, dest) 
          OpenAppendStream: function (path) 
          OpenInputFile: function (path) 
          OpenInputStream: function (path) 
          OpenOutputStream: function (path) 
          cd: function (x) 
          class_title: function () 
          clone: function (deep = FALSE) 
          initialize: function (xp) 
          ls: function (path = "", ...) 
          path: function (x) 
          pointer: function () 
          print: function (...) 
          set_pointer: function (xp) 
          type_name: active binding
          url_scheme: active binding 
       - attr(*, "model_output_dir")= chr "test/model_output_dir"

# hub_connection print method works

    Code
      hub_con
    Message <cliMessage>
      
      -- <hub_connection/FileSystemDataset> --
      
      * hub_name: "Simple Forecast Hub"
      * hub_path: 'test/hub_path'
      * file_format: "csv"
      * file_system: "LocalFileSystem"
      * model_output_dir: "test/model_output_dir"
      * config_admin: 'hub-config/admin.json'
      * config_tasks: 'hub-config/tasks.json'
      
      -- Connection schema 
    Output
      hub_connection with 4 csv files
      origin_date: date32[day]
      target: string
      horizon: int32
      location: string
      type: string
      type_id: double
      value: int32
      age_group: string
      model: string

---

    Code
      print(hub_con, verbose = TRUE)
    Message <cliMessage>
      
      -- <hub_connection/FileSystemDataset> --
      
      * hub_name: "Simple Forecast Hub"
      * hub_path: 'test/hub_path'
      * file_format: "csv"
      * file_system: "LocalFileSystem"
      * model_output_dir: "test/model_output_dir"
      * config_admin: 'hub-config/admin.json'
      * config_tasks: 'hub-config/tasks.json'
      
      -- Connection schema 
    Output
      hub_connection with 4 csv files
      origin_date: date32[day]
      target: string
      horizon: int32
      location: string
      type: string
      type_id: double
      value: int32
      age_group: string
      model: string
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
       - attr(*, "file_system")=Classes 'LocalFileSystem', 'FileSystem', 'ArrowObject', 'R6' <LocalFileSystem>
        Inherits from: <FileSystem>
        Public:
          .:xp:.: externalptr
          .unsafe_delete: function () 
          CopyFile: function (src, dest) 
          CreateDir: function (path, recursive = TRUE) 
          DeleteDir: function (path) 
          DeleteDirContents: function (path) 
          DeleteFile: function (path) 
          DeleteFiles: function (paths) 
          GetFileInfo: function (x) 
          Move: function (src, dest) 
          OpenAppendStream: function (path) 
          OpenInputFile: function (path) 
          OpenInputStream: function (path) 
          OpenOutputStream: function (path) 
          cd: function (x) 
          class_title: function () 
          clone: function (deep = FALSE) 
          initialize: function (xp) 
          ls: function (path = "", ...) 
          path: function (x) 
          pointer: function () 
          print: function (...) 
          set_pointer: function (xp) 
          type_name: active binding
          url_scheme: active binding 
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

# mod_out_connection print method works

    Code
      mod_out_con
    Message <cliMessage>
      
      -- <mod_out_connection/FileSystemDataset> --
      
      * file_format: "csv"
      * file_system: "LocalFileSystem"
      * model_output_dir: "test/model_output_dir"
      
      -- Connection schema 
    Output
      mod_out_connection with 4 csv files
      origin_date: date32[day]
      target: string
      horizon: int64
      location: string
      type: string
      type_id: double
      value: int64
      age_group: string
      model: string

# connect_hub data extraction works on simple forecasting hub

    Code
      hub_con %>% dplyr::filter(origin_date == "2022-10-08", horizon == 2, type_id ==
        0.01) %>% dplyr::collect() %>% str()
    Output
      tibble [3 x 9] (S3: tbl_df/tbl/data.frame)
       $ origin_date: Date[1:3], format: "2022-10-08" "2022-10-08" ...
       $ target     : chr [1:3] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp"
       $ horizon    : int [1:3] 2 2 2
       $ location   : chr [1:3] "US" "04" "01"
       $ type       : chr [1:3] "quantile" "quantile" "quantile"
       $ type_id    : num [1:3] 0.01 0.01 0.01
       $ value      : int [1:3] 135 135 135
       $ age_group  : chr [1:3] NA NA NA
       $ model      : chr [1:3] "baseline" "baseline" "baseline"

---

    Code
      hub_con %>% dplyr::filter(horizon == 2, age_group == "65+") %>% dplyr::collect() %>%
        str()
    Output
      tibble [69 x 9] (S3: tbl_df/tbl/data.frame)
       $ origin_date: Date[1:69], format: "2022-10-15" "2022-10-15" ...
       $ target     : chr [1:69] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" ...
       $ horizon    : int [1:69] 2 2 2 2 2 2 2 2 2 2 ...
       $ location   : chr [1:69] "US" "US" "US" "US" ...
       $ type       : chr [1:69] "quantile" "quantile" "quantile" "quantile" ...
       $ type_id    : num [1:69] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
       $ value      : int [1:69] 135 137 139 140 141 141 142 143 144 145 ...
       $ age_group  : chr [1:69] "65+" "65+" "65+" "65+" ...
       $ model      : chr [1:69] "baseline" "baseline" "baseline" "baseline" ...

---

    Code
      model_output_con %>% dplyr::filter(origin_date == "2022-10-08", horizon == 2,
      type_id == 0.01) %>% dplyr::collect() %>% str()
    Output
      tibble [3 x 9] (S3: tbl_df/tbl/data.frame)
       $ origin_date: Date[1:3], format: "2022-10-08" "2022-10-08" ...
       $ target     : chr [1:3] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp"
       $ horizon    : int [1:3] 2 2 2
       $ location   : chr [1:3] "US" "04" "01"
       $ type       : chr [1:3] "quantile" "quantile" "quantile"
       $ type_id    : num [1:3] 0.01 0.01 0.01
       $ value      : int [1:3] 135 135 135
       $ age_group  : chr [1:3] NA NA NA
       $ model      : chr [1:3] "baseline" "baseline" "baseline"

# connect_hub works on S3 bucket simple forecasting hub on AWS

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
       - attr(*, "file_system")=Classes 'S3FileSystem', 'FileSystem', 'ArrowObject', 'R6' <S3FileSystem>
        Inherits from: <FileSystem>
        Public:
          .:xp:.: externalptr
          .unsafe_delete: function () 
          CopyFile: function (src, dest) 
          CreateDir: function (path, recursive = TRUE) 
          DeleteDir: function (path) 
          DeleteDirContents: function (path) 
          DeleteFile: function (path) 
          DeleteFiles: function (paths) 
          GetFileInfo: function (x) 
          Move: function (src, dest) 
          OpenAppendStream: function (path) 
          OpenInputFile: function (path) 
          OpenInputStream: function (path) 
          OpenOutputStream: function (path) 
          cd: function (x) 
          class_title: function () 
          clone: function (deep = FALSE) 
          initialize: function (xp) 
          ls: function (path = "", ...) 
          path: function (x) 
          pointer: function () 
          print: function (...) 
          region: active binding
          set_pointer: function (xp) 
          type_name: active binding
          url_scheme: active binding 
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

---

    Code
      hub_con %>% dplyr::filter(horizon == 2, age_group == "65+") %>% dplyr::collect() %>%
        str()
    Output
      tibble [69 x 9] (S3: tbl_df/tbl/data.frame)
       $ origin_date: Date[1:69], format: "2022-10-15" "2022-10-15" ...
       $ target     : chr [1:69] "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" "wk inc flu hosp" ...
       $ horizon    : int [1:69] 2 2 2 2 2 2 2 2 2 2 ...
       $ location   : chr [1:69] "US" "US" "US" "US" ...
       $ type       : chr [1:69] "quantile" "quantile" "quantile" "quantile" ...
       $ type_id    : num [1:69] 0.01 0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ...
       $ value      : int [1:69] 135 137 139 140 141 141 142 143 144 145 ...
       $ age_group  : chr [1:69] "65+" "65+" "65+" "65+" ...
       $ model      : chr [1:69] "baseline" "baseline" "baseline" "baseline" ...

# connect_hub & connect_model_output fail correctly

    Code
      connect_hub("random/hub/path")
    Error <rlang_error>
      x Directory 'random/hub/path' does not exist.

---

    Code
      connect_model_output("random/model-output/")
    Error <rlang_error>
      x Directory 'random/model-output/' does not exist.

---

    Code
      connect_hub(temp_dir)
    Error <rlang_error>
      x 'hub-config' directory not found in root of Hub.

