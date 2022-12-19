# Config validated successfully

    Code
      validate_config(hub_path = system.file("testhubs/simple/", package = "hubUtils"),
      config = "tasks")
    Message <cliMessage>
      v Successfully validated config file '/Users/Anna/Documents/workflows/UMASS/hubUtils/inst/testhubs/simple/hub-config/tasks.json'
    Output
      [1] TRUE
      attr(,"config_path")
      /Users/Anna/Documents/workflows/UMASS/hubUtils/inst/testhubs/simple/hub-config/tasks.json
      attr(,"schema_version")
      [1] "v0.0.0.9"
      attr(,"schema_url")
      https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json

# Config errors detected successfully

    Code
      validate_config(config_path = config_path)
    Warning <rlang_warning>
      Schema errors detected in config file 'testdata/tasks-errors.json'
    Output
      [1] FALSE
      attr(,"errors")
                                                     instancePath
      1          /rounds/0/model_tasks/0/task_ids/target/required
      2 /rounds/0/model_tasks/0/output_type/mean/type_id/optional
      3 /rounds/0/model_tasks/0/output_type/mean/type_id/required
      4          /rounds/0/model_tasks/0/output_type/mean/type_id
      5                                 /rounds/0/submissions_due
      6                           /rounds/0/submissions_due/start
      7                             /rounds/0/submissions_due/end
      8                                 /rounds/0/submissions_due
                                                                                                                                               schemaPath
      1                             #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/target/properties/required/type
      2 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf/0/properties/optional/type
      3 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf/1/properties/required/type
      4                            #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf
      5                                                                             #/properties/rounds/items/properties/submissions_due/oneOf/0/required
      6                                                                #/properties/rounds/items/properties/submissions_due/oneOf/1/properties/start/type
      7                                                                  #/properties/rounds/items/properties/submissions_due/oneOf/1/properties/end/type
      8                                                                                        #/properties/rounds/items/properties/submissions_due/oneOf
         keyword params.type params.passingSchemas params.missingProperty
      1     type array, null                    NA                   <NA>
      2     type        null                    NA                   <NA>
      3     type        null                    NA                   <NA>
      4    oneOf        NULL                    NA                   <NA>
      5 required        NULL                    NA            relative_to
      6     type      string                    NA                   <NA>
      7     type      string                    NA                   <NA>
      8    oneOf        NULL                    NA                   <NA>
                                          message
      1                        must be array,null
      2                              must be null
      3                              must be null
      4    must match exactly one schema in oneOf
      5 must have required property 'relative_to'
      6                            must be string
      7                            must be string
      8    must match exactly one schema in oneOf
                                                                                                                                                                                                                                                                                                                                                           schema
      1                                                                                                                                                                                                                                                                                                                                               array, null
      2                                                                                                                                                                                                                                                                                                                                                      null
      3                                                                                                                                                                                                                                                                                                                                                      null
      4                                                                      When mean is required, property set to single element 'NA' array, When mean is optional, property set to null, array, null, NA, NA, 1, NA, When mean is required, property set to null, When mean is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
      5                                                                                                                                                                                                                                                                                                                                   relative_to, start, end
      6                                                                                                                                                                                                                                                                                                                                                    string
      7                                                                                                                                                                                                                                                                                                                                                    string
      8 Name of task id variable in relation to which submission start and end dates are calculated., NA, string, NA, Difference in days between start and origin date., Submission start date., integer, string, NA, date, Difference in days between end and origin date., Submission end date., integer, string, NA, date, relative_to, start, end, start, end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                parentSchema.description
      1                                                                                                                                                                                                                                                                                                                                         Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property.
      2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      When mean is required, property set to null
      3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      When mean is optional, property set to null
      4 type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null
      5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             <NA>
      6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Submission start date.
      7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Submission end date.
      8                                                                                                                                                                                                                                                                                                                                                                                                                                                 Object defining the dates by which model forecasts must be submitted to the hub.
        parentSchema.type parentSchema.type
      1       array, null            string
      2              null              <NA>
      3              null              <NA>
      4            object              <NA>
      5              NULL              <NA>
      6            string              <NA>
      7            string              <NA>
      8            object              <NA>
                                 parentSchema.examples
      1                                           NULL
      2                                           NULL
      3                                           NULL
      4                                         NA, NA
      5                                           NULL
      6                                           NULL
      7                                           NULL
      8 2022-06-07, -4, 2022-07-20, 2, NA, origin_date
                                                                                                                                                                                                                                                                                                                                               parentSchema.oneOf
      1                                                                                                                                                                                                                                                                                                                                                      NULL
      2                                                                                                                                                                                                                                                                                                                                                      NULL
      3                                                                                                                                                                                                                                                                                                                                                      NULL
      4                                                                      When mean is required, property set to single element 'NA' array, When mean is optional, property set to null, array, null, NA, NA, 1, NA, When mean is required, property set to null, When mean is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
      5                                                                                                                                                                                                                                                                                                                                                      NULL
      6                                                                                                                                                                                                                                                                                                                                                      NULL
      7                                                                                                                                                                                                                                                                                                                                                      NULL
      8 Name of task id variable in relation to which submission start and end dates are calculated., NA, string, NA, Difference in days between start and origin date., Submission start date., integer, string, NA, date, Difference in days between end and origin date., Submission end date., integer, string, NA, date, relative_to, start, end, start, end
          parentSchema.required
      1                    NULL
      2                    NULL
      3                    NULL
      4      required, optional
      5 relative_to, start, end
      6                    NULL
      7                    NULL
      8              start, end
                                                     parentSchema.properties.relative_to.description
      1                                                                                         <NA>
      2                                                                                         <NA>
      3                                                                                         <NA>
      4                                                                                         <NA>
      5 Name of task id variable in relation to which submission start and end dates are calculated.
      6                                                                                         <NA>
      7                                                                                         <NA>
      8                                                                                         <NA>
        parentSchema.properties.relative_to.type
      1                                     <NA>
      2                                     <NA>
      3                                     <NA>
      4                                     <NA>
      5                                   string
      6                                     <NA>
      7                                     <NA>
      8                                     <NA>
                parentSchema.properties.start.description
      1                                              <NA>
      2                                              <NA>
      3                                              <NA>
      4                                              <NA>
      5 Difference in days between start and origin date.
      6                                              <NA>
      7                                              <NA>
      8                                              <NA>
        parentSchema.properties.start.type
      1                               <NA>
      2                               <NA>
      3                               <NA>
      4                               <NA>
      5                            integer
      6                               <NA>
      7                               <NA>
      8                               <NA>
                parentSchema.properties.end.description
      1                                            <NA>
      2                                            <NA>
      3                                            <NA>
      4                                            <NA>
      5 Difference in days between end and origin date.
      6                                            <NA>
      7                                            <NA>
      8                                            <NA>
        parentSchema.properties.end.type parentSchema.format            data
      1                             <NA>                <NA> wk inc flu hosp
      2                             <NA>                <NA>              NA
      3                             <NA>                <NA>              NA
      4                             <NA>                <NA>          NA, NA
      5                          integer                <NA>           -6, 1
      6                             <NA>                date              -6
      7                             <NA>                date               1
      8                             <NA>                <NA>           -6, 1
                                                         dataPath
      1          /rounds/0/model_tasks/0/task_ids/target/required
      2 /rounds/0/model_tasks/0/output_type/mean/type_id/optional
      3 /rounds/0/model_tasks/0/output_type/mean/type_id/required
      4          /rounds/0/model_tasks/0/output_type/mean/type_id
      5                                 /rounds/0/submissions_due
      6                           /rounds/0/submissions_due/start
      7                             /rounds/0/submissions_due/end
      8                                 /rounds/0/submissions_due
      attr(,"config_path")
      [1] "testdata/tasks-errors.json"
      attr(,"schema_version")
      [1] "v0.0.0.9"
      attr(,"schema_url")
      https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json

---

    Code
      launch_pretty_errors_report(validate_config(config_path = config_path))
    Warning <rlang_warning>
      Schema errors detected in config file 'testdata/tasks-errors.json'
    Output
      <div id="ydgabwknrs" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
        <style>html {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
      }
      
      #ydgabwknrs .gt_table {
        display: table;
        border-collapse: collapse;
        margin-left: 2%;
        margin-right: 2%;
        color: #333333;
        font-size: 16px;
        font-weight: normal;
        font-style: normal;
        background-color: #FFFFFF;
        width: auto;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #A8A8A8;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #A8A8A8;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_heading {
        background-color: #F0F3F5;
        text-align: center;
        border-bottom-color: #FFFFFF;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_title {
        color: #333333;
        font-size: 125%;
        font-weight: initial;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 5px;
        border-bottom-color: #FFFFFF;
        border-bottom-width: 0;
      }
      
      #ydgabwknrs .gt_subtitle {
        color: #333333;
        font-size: 85%;
        font-weight: initial;
        padding-top: 0;
        padding-bottom: 6px;
        padding-left: 5px;
        padding-right: 5px;
        border-top-color: #FFFFFF;
        border-top-width: 0;
      }
      
      #ydgabwknrs .gt_bottom_border {
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_col_headings {
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_col_heading {
        color: #333333;
        background-color: #F0F3F5;
        font-size: 100%;
        font-weight: bold;
        text-transform: inherit;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: bottom;
        padding-top: 5px;
        padding-bottom: 6px;
        padding-left: 5px;
        padding-right: 5px;
        overflow-x: hidden;
      }
      
      #ydgabwknrs .gt_column_spanner_outer {
        color: #333333;
        background-color: #F0F3F5;
        font-size: 100%;
        font-weight: bold;
        text-transform: inherit;
        padding-top: 0;
        padding-bottom: 0;
        padding-left: 4px;
        padding-right: 4px;
      }
      
      #ydgabwknrs .gt_column_spanner_outer:first-child {
        padding-left: 0;
      }
      
      #ydgabwknrs .gt_column_spanner_outer:last-child {
        padding-right: 0;
      }
      
      #ydgabwknrs .gt_column_spanner {
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        vertical-align: bottom;
        padding-top: 5px;
        padding-bottom: 5px;
        overflow-x: hidden;
        display: inline-block;
        width: 100%;
      }
      
      #ydgabwknrs .gt_group_heading {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: middle;
      }
      
      #ydgabwknrs .gt_empty_group_heading {
        padding: 0.5px;
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        vertical-align: middle;
      }
      
      #ydgabwknrs .gt_from_md > :first-child {
        margin-top: 0;
      }
      
      #ydgabwknrs .gt_from_md > :last-child {
        margin-bottom: 0;
      }
      
      #ydgabwknrs .gt_row {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 5px;
        padding-right: 5px;
        margin: 10px;
        border-top-style: solid;
        border-top-width: 1px;
        border-top-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: middle;
        overflow-x: hidden;
      }
      
      #ydgabwknrs .gt_stub {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-right-style: solid;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #ydgabwknrs .gt_stub_row_group {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-right-style: solid;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        padding-left: 5px;
        padding-right: 5px;
        vertical-align: top;
      }
      
      #ydgabwknrs .gt_row_group_first td {
        border-top-width: 2px;
      }
      
      #ydgabwknrs .gt_summary_row {
        color: #333333;
        background-color: #FFFFFF;
        text-transform: inherit;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #ydgabwknrs .gt_first_summary_row {
        border-top-style: solid;
        border-top-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_first_summary_row.thick {
        border-top-width: 2px;
      }
      
      #ydgabwknrs .gt_last_summary_row {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_grand_summary_row {
        color: #333333;
        background-color: #FFFFFF;
        text-transform: inherit;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #ydgabwknrs .gt_first_grand_summary_row {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        border-top-style: double;
        border-top-width: 6px;
        border-top-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_striped {
        background-color: rgba(128, 128, 128, 0.05);
      }
      
      #ydgabwknrs .gt_table_body {
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_footnotes {
        color: #333333;
        background-color: #FFFFFF;
        border-bottom-style: none;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_footnote {
        margin: 0px;
        font-size: 90%;
        padding-left: 4px;
        padding-right: 4px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #ydgabwknrs .gt_sourcenotes {
        color: #333333;
        background-color: #FFFFFF;
        border-bottom-style: none;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
      }
      
      #ydgabwknrs .gt_sourcenote {
        font-size: 90%;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #ydgabwknrs .gt_left {
        text-align: left;
      }
      
      #ydgabwknrs .gt_center {
        text-align: center;
      }
      
      #ydgabwknrs .gt_right {
        text-align: right;
        font-variant-numeric: tabular-nums;
      }
      
      #ydgabwknrs .gt_font_normal {
        font-weight: normal;
      }
      
      #ydgabwknrs .gt_font_bold {
        font-weight: bold;
      }
      
      #ydgabwknrs .gt_font_italic {
        font-style: italic;
      }
      
      #ydgabwknrs .gt_super {
        font-size: 65%;
      }
      
      #ydgabwknrs .gt_footnote_marks {
        font-style: italic;
        font-weight: normal;
        font-size: 75%;
        vertical-align: 0.4em;
      }
      
      #ydgabwknrs .gt_asterisk {
        font-size: 100%;
        vertical-align: 0;
      }
      
      #ydgabwknrs .gt_indent_1 {
        text-indent: 5px;
      }
      
      #ydgabwknrs .gt_indent_2 {
        text-indent: 10px;
      }
      
      #ydgabwknrs .gt_indent_3 {
        text-indent: 15px;
      }
      
      #ydgabwknrs .gt_indent_4 {
        text-indent: 20px;
      }
      
      #ydgabwknrs .gt_indent_5 {
        text-indent: 25px;
      }
      </style>
        <table class="gt_table" style="table-layout: fixed;">
        <colgroup>
          <col/>
          <col/>
          <col/>
          <col style="width:16.6666666666667%;"/>
          <col style="width:25%;"/>
          <col style="width:16.6666666666667%;"/>
        </colgroup>
        <thead class="gt_header">
          <tr>
            <td colspan="6" class="gt_heading gt_title gt_font_normal" style><strong><code>hubUtils</code> config validation error report</strong></td>
          </tr>
          <tr>
            <td colspan="6" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Report for file <strong><code>testdata/tasks-errors.json</code></strong> using
      schema version <a href="https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json"><strong>v0.0.0.9</strong></a></td>
          </tr>
        </thead>
        <thead class="gt_col_headings">
          <tr>
            <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup">
              <span class="gt_column_spanner"><strong>Error location</strong></span>
            </th>
            <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup">
              <span class="gt_column_spanner"><strong>Schema details</strong></span>
            </th>
            <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="1" scope="col">
              <span class="gt_column_spanner"><strong>Config</strong></span>
            </th>
          </tr>
          <tr>
            <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">instancePath</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">schemaPath</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">keyword</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">message</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">schema</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">data</th>
          </tr>
        </thead>
        <tbody class="gt_table_body">
          <tr><td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p><strong>rounds</strong>
      └<strong>1</strong>
      └-<strong>model_tasks</strong>
      └--<strong>1</strong>
      └---<strong>task_ids</strong>
      └----<strong>target</strong>
      └-----<strong>required</strong></p>
      </div></td>
      <td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p>properties
      └<strong>rounds</strong>
      └-items
      └--properties
      └---<strong>model_tasks</strong>
      └----items
      └-----properties
      └------<strong>task_ids</strong>
      └-------properties
      └--------<strong>target</strong>
      └---------properties
      └----------<strong>required</strong>
      └-----------<strong>type</strong></p>
      </div></td>
      <td class="gt_row gt_center">type</td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">❌ must be array,null</td>
      <td class="gt_row gt_left" style="white-space: pre-wrap;"><div class='gt_from_md'><p>array, null</p>
      </div></td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">wk inc flu hosp</td></tr>
          <tr><td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p><strong>rounds</strong>
      └<strong>1</strong>
      └-<strong>model_tasks</strong>
      └--<strong>1</strong>
      └---<strong>output_type</strong>
      └----<strong>mean</strong>
      └-----<strong>type_id</strong></p>
      </div></td>
      <td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p>properties
      └<strong>rounds</strong>
      └-items
      └--properties
      └---<strong>model_tasks</strong>
      └----items
      └-----properties
      └------<strong>output_type</strong>
      └-------properties
      └--------<strong>mean</strong>
      └---------properties
      └----------<strong>type_id</strong>
      └-----------<strong>oneOf</strong></p>
      </div></td>
      <td class="gt_row gt_center">oneOf</td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">❌ must match exactly one schema in oneOf</td>
      <td class="gt_row gt_left" style="white-space: pre-wrap;"><div class='gt_from_md'><p><strong>1</strong>
      <strong>required-description:</strong> When mean is required, property set to single element 'NA' array
      <strong>required-type:</strong> array
      <strong>required-items-const:</strong>'NA'
      <strong>required-items-maxItems:</strong> 1
      <strong>optional-description:</strong> When mean is required, property set to null
      <strong>optional-type:</strong> null</p>
      <p><strong>2</strong>
      <strong>required-description:</strong> When mean is optional, property set to null
      <strong>required-type:</strong> null
      <strong>optional-description:</strong> When mean is optional, property set to single element 'NA' array
      <strong>optional-type:</strong> array
      <strong>optional-items-const:</strong>'NA'
      <strong>optional-items-maxItems:</strong> 1</p>
      </div></td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">required: NA, optional: NA</td></tr>
          <tr><td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p><strong>rounds</strong>
      └<strong>1</strong>
      └-<strong>submissions_due</strong></p>
      </div></td>
      <td class="gt_row gt_left" style="white-space: pre;"><div class='gt_from_md'><p>properties
      └<strong>rounds</strong>
      └-items
      └--properties
      └---<strong>submissions_due</strong>
      └----<strong>oneOf</strong></p>
      </div></td>
      <td class="gt_row gt_center">oneOf</td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">❌ must match exactly one schema in oneOf</td>
      <td class="gt_row gt_left" style="white-space: pre-wrap;"><div class='gt_from_md'><p><strong>1</strong>
      <strong>relative_to-description:</strong> Name of task id variable in relation to which submission start and end dates are calculated.
      <strong>relative_to-type:</strong> string
      <strong>start-description:</strong> Difference in days between start and origin date.
      <strong>start-type:</strong> integer
      <strong>start-format:</strong>'NA'
      <strong>end-description:</strong> Difference in days between end and origin date.
      <strong>end-type:</strong> integer
      <strong>end-format:</strong>'NA'
      <strong>required1:</strong> relative_to
      <strong>required2:</strong> start
      <strong>required3:</strong> end</p>
      <p><strong>2</strong>
      <strong>relative_to-description:</strong>'NA'
      <strong>relative_to-type:</strong>'NA'
      <strong>start-description:</strong> Submission start date.
      <strong>start-type:</strong> string
      <strong>start-format:</strong> date
      <strong>end-description:</strong> Submission end date.
      <strong>end-type:</strong> string
      <strong>end-format:</strong> date
      <strong>required1:</strong> start
      <strong>required2:</strong> end</p>
      </div></td>
      <td class="gt_row gt_center" style="background-color: #F9E3D6; font-weight: bold;">start: -6, end: 1</td></tr>
        </tbody>
        <tfoot class="gt_sourcenotes">
          <tr>
            <td class="gt_sourcenote" colspan="6">For more information, please consult the
      <a href="https://hubdocs.readthedocs.io/en/latest/"><strong><code>hubDocs</code> documentation</strong>.</a></td>
          </tr>
        </tfoot>
        
      </table>
      </div>

