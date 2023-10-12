# Errors report launch successful

    Code
      tbl$`_source_notes`
    Output
      [[1]]
      [1] "For more information, please consult the\n                                 [**`hubDocs` documentation**.](https://hubdocs.readthedocs.io/en/latest/)"
      attr(,"class")
      [1] "from_markdown"
      

---

    Code
      tbl$`_heading`
    Output
      $title
      [1] "**`hubUtils` config validation error report**"
      attr(,"class")
      [1] "from_markdown"
      
      $subtitle
      [1] "Report for file **`testdata/tasks-errors.json`** using\nschema version [**v0.0.0.9**](https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json)"
      attr(,"class")
      [1] "from_markdown"
      
      $preheader
      NULL
      

---

    Code
      str(tbl$`_data`)
    Output
      tibble [3 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr [1:3] "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**task_ids** \n └────**target** \n └─────**required**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**output_type** \n └────**mean** \n └─────**type_id**" "**rounds** \n └**1** \n └─**submissions_due**"
       $ schemaPath  : chr [1:3] "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__ "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__ "properties \n └**rounds** \n └─items \n └──properties \n └───**submissions_due** \n └────**oneOf**"
       $ keyword     : chr [1:3] "type" "oneOf" "oneOf"
       $ message     : chr [1:3] "❌ must be array,null" "❌ must match exactly one schema in oneOf" "❌ must match exactly one schema in oneOf"
       $ schema      : chr [1:3] "array, null" "**1** \n **required-description:** When mean is required, property set to single element 'NA' array \n **requir"| __truncated__ "**1** \n **relative_to-description:** Name of task id variable in relation to which submission start and end da"| __truncated__
       $ data        : chr [1:3] "wk inc flu hosp" "required: NA, optional: NA" "start: -6, end: 1"

---

    Code
      tbl$`_styles`
    Output
      # A tibble: 18 x 7
         locname grpname colname      locnum rownum colnum styles    
         <chr>   <chr>   <chr>         <dbl>  <int>  <int> <list>    
       1 data    <NA>    instancePath      5      1     NA <cll_styl>
       2 data    <NA>    schemaPath        5      1     NA <cll_styl>
       3 data    <NA>    schema            5      1     NA <cll_styl>
       4 data    <NA>    instancePath      5      2     NA <cll_styl>
       5 data    <NA>    schemaPath        5      2     NA <cll_styl>
       6 data    <NA>    schema            5      2     NA <cll_styl>
       7 data    <NA>    instancePath      5      3     NA <cll_styl>
       8 data    <NA>    schemaPath        5      3     NA <cll_styl>
       9 data    <NA>    schema            5      3     NA <cll_styl>
      10 data    <NA>    schema            5      1     NA <cll_styl>
      11 data    <NA>    schema            5      2     NA <cll_styl>
      12 data    <NA>    schema            5      3     NA <cll_styl>
      13 data    <NA>    message           5      1     NA <cll_styl>
      14 data    <NA>    data              5      1     NA <cll_styl>
      15 data    <NA>    message           5      2     NA <cll_styl>
      16 data    <NA>    data              5      2     NA <cll_styl>
      17 data    <NA>    message           5      3     NA <cll_styl>
      18 data    <NA>    data              5      3     NA <cll_styl>

# length 1 paths and related type & enum errors handled correctly

    Code
      str(tbl$`_data`)
    Output
      tibble [2 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr [1:2] "**file_format** \n └**1**" "**timezone**"
       $ schemaPath  : chr [1:2] "properties \n └**file_format** \n └─items \n └──**enum**" "properties \n └**timezone** \n └─**type**"
       $ keyword     : chr [1:2] "enum" "type"
       $ message     : chr [1:2] "❌ must be equal to one of the allowed values" "❌ must be string"
       $ schema      : chr [1:2] "csv, parquet, arrow" "string"
       $ data        : chr [1:2] "csvs" "US/Eastern"

# Data column handled correctly when required property missing

    Code
      str(tbl$`_data`)
    Output
      tibble [2 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr [1:2] "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**output_type** \n └────**mean** \n └─────**value*"| __truncated__
       $ schemaPath  : chr [1:2] "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**" "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__
       $ keyword     : chr [1:2] "required" "type"
       $ message     : chr [1:2] "❌ must have required property 'target_metadata'" "❌ must be number,integer"
       $ schema      : chr [1:2] "task_ids, output_type, target_metadata" "number, integer"
       $ data        : chr [1:2] "" "0"

---

    Code
      str(tbl$`_data`)
    Output
      tibble [1 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**"
       $ schemaPath  : chr "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**"
       $ keyword     : chr "required"
       $ message     : chr "❌ must have required property 'target_metadata'"
       $ schema      : chr "task_ids, output_type, target_metadata"
       $ data        : chr ""

---

    Code
      str(tbl$`_data`)
    Output
      tibble [2 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr [1:2] "**rounds** \n └**1**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**"
       $ schemaPath  : chr [1:2] "properties \n └**rounds** \n └─items \n └──**required**" "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**"
       $ keyword     : chr [1:2] "required" "required"
       $ message     : chr [1:2] "❌ must have required property 'round_id_from_variable'" "❌ must have required property 'target_metadata'"
       $ schema      : chr [1:2] "round_id_from_variable, round_id, model_tasks, submissions_due" "task_ids, output_type, target_metadata"
       $ data        : chr [1:2] "" ""

---

    Code
      str(tbl$`_data`)
    Output
      tibble [2 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr [1:2] "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**"
       $ schemaPath  : chr [1:2] "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**" "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**"
       $ keyword     : chr [1:2] "required" "required"
       $ message     : chr [1:2] "❌ must have required property 'output_type'" "❌ must have required property 'target_metadata'"
       $ schema      : chr [1:2] "task_ids, output_type, target_metadata" "task_ids, output_type, target_metadata"
       $ data        : chr [1:2] "" ""

# Report handles additional property errors successfully

    Code
      str(tbl$`_data`)
    Output
      tibble [1 x 6] (S3: tbl_df/tbl/data.frame)
       $ instancePath: chr "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**output_type**"
       $ schemaPath  : chr "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__
       $ keyword     : chr "additionalProperties"
       $ message     : chr "❌ must NOT have additional properties"
       $ schema      : chr "FALSE"
       $ data        : chr ""

# Report works corectly on validate_hub_config output

    Code
      str(tbl$`_data`)
    Output
      tibble [5 x 7] (S3: tbl_df/tbl/data.frame)
       $ fileName    : chr [1:5] "tasks.json" "tasks.json" "tasks.json" "tasks.json" ...
       $ instancePath: chr [1:5] "**rounds** \n └**1** \n └─**model_tasks** \n └──**1**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**task_ids** \n └────**target** \n └─────**required**" "**rounds** \n └**1** \n └─**model_tasks** \n └──**1** \n └───**output_type** \n └────**mean** \n └─────**output_type_id**" "**rounds** \n └**1** \n └─**submissions_due**" ...
       $ schemaPath  : chr [1:5] "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────**required**" "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__ "properties \n └**rounds** \n └─items \n └──properties \n └───**model_tasks** \n └────items \n └─────properties "| __truncated__ "properties \n └**rounds** \n └─items \n └──properties \n └───**submissions_due** \n └────**oneOf**" ...
       $ keyword     : chr [1:5] "required" "type" "oneOf" "oneOf" ...
       $ message     : chr [1:5] "❌ must have required property 'target_metadata'" "❌ must be array,null" "❌ must match exactly one schema in oneOf" "❌ must match exactly one schema in oneOf" ...
       $ schema      : chr [1:5] "task_ids, output_type, target_metadata" "array, null" "**1** \n **required-description:** When mean is required, property set to single element 'NA' array \n **requir"| __truncated__ "**1** \n **relative_to-description:** Name of task id variable in relation to which submission start and end da"| __truncated__ ...
       $ data        : chr [1:5] "" "wk inc flu hosp" "required: NA, optional: NA" "start: -6, end: 1" ...

