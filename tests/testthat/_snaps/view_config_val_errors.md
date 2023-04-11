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
      tbl$`_data`
    Output
      # A tibble: 3 x 6
        instancePath                              schem~1 keyword message schema data 
        <chr>                                     <chr>   <chr>   <chr>   <chr>  <chr>
      1 "**rounds** \n └**1** \n └─**model_tasks~ "prope~ type    ❌ mus~ "arra~ wk i~
      2 "**rounds** \n └**1** \n └─**model_tasks~ "prope~ oneOf   ❌ mus~ "**1*~ requ~
      3 "**rounds** \n └**1** \n └─**submissions~ "prope~ oneOf   ❌ mus~ "**1*~ star~
      # ... with abbreviated variable name 1: schemaPath

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
       $ instancePath: chr [1:2] "**file_format**" "**timezone**"
       $ schemaPath  : chr [1:2] "properties \n └**file_format** \n └─**enum**" "properties \n └**timezone** \n └─**type**"
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
       $ message     : chr [1:2] "❌ must have required property 'target_metadata'" "❌ must be integer"
       $ schema      : chr [1:2] "task_ids, output_type, target_metadata" "integer"
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

