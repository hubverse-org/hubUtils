# Config errors detected successfully

    Code
      validate_config(config_path = config_path, pretty_errors = FALSE)
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

# Errors report launch successful

    Code
      tbl
    Output
      [1] "<table class=\"gt_table\" style=\"table-layout: fixed;\">\n  <colgroup>\n    <col/>\n    <col/>\n    <col/>\n    <col style=\"width:16.6666666666667%;\"/>\n    <col style=\"width:25%;\"/>\n    <col style=\"width:16.6666666666667%;\"/>\n  </colgroup>\n  <thead class=\"gt_header\">\n    <tr>\n      <td colspan=\"6\" class=\"gt_heading gt_title gt_font_normal\" style><strong><code>hubUtils</code> config validation error report</strong></td>\n    </tr>\n    <tr>\n      <td colspan=\"6\" class=\"gt_heading gt_subtitle gt_font_normal gt_bottom_border\" style>Report for file <strong><code>testdata/tasks-errors.json</code></strong> using\nschema version <a href=\"https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.0.9/tasks-schema.json\"><strong>v0.0.0.9</strong></a></td>\n    </tr>\n  </thead>\n  <thead class=\"gt_col_headings\">\n    <tr>\n      <th class=\"gt_center gt_columns_top_border gt_column_spanner_outer\" rowspan=\"1\" colspan=\"2\" scope=\"colgroup\">\n        <span class=\"gt_column_spanner\"><strong>Error location</strong></span>\n      </th>\n      <th class=\"gt_center gt_columns_top_border gt_column_spanner_outer\" rowspan=\"1\" colspan=\"3\" scope=\"colgroup\">\n        <span class=\"gt_column_spanner\"><strong>Schema details</strong></span>\n      </th>\n      <th class=\"gt_center gt_columns_top_border gt_column_spanner_outer\" rowspan=\"1\" colspan=\"1\" scope=\"col\">\n        <span class=\"gt_column_spanner\"><strong>Config</strong></span>\n      </th>\n    </tr>\n    <tr>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_left\" rowspan=\"1\" colspan=\"1\" scope=\"col\">instancePath</th>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_left\" rowspan=\"1\" colspan=\"1\" scope=\"col\">schemaPath</th>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_center\" rowspan=\"1\" colspan=\"1\" scope=\"col\">keyword</th>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_center\" rowspan=\"1\" colspan=\"1\" scope=\"col\">message</th>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_left\" rowspan=\"1\" colspan=\"1\" scope=\"col\">schema</th>\n      <th class=\"gt_col_heading gt_columns_bottom_border gt_center\" rowspan=\"1\" colspan=\"1\" scope=\"col\">data</th>\n    </tr>\n  </thead>\n  <tbody class=\"gt_table_body\">\n    <tr><td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p><strong>rounds</strong>\n└<strong>1</strong>\n└─<strong>model_tasks</strong>\n└──<strong>1</strong>\n└───<strong>task_ids</strong>\n└────<strong>target</strong>\n└─────<strong>required</strong></p>\n</div></td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p>properties\n└<strong>rounds</strong>\n└─items\n└──properties\n└───<strong>model_tasks</strong>\n└────items\n└─────properties\n└──────<strong>task_ids</strong>\n└───────properties\n└────────<strong>target</strong>\n└─────────properties\n└──────────<strong>required</strong>\n└───────────<strong>type</strong></p>\n</div></td>\n<td class=\"gt_row gt_center\">type</td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">❌ must be array,null</td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre-wrap;\"><div class='gt_from_md'><p>array, null</p>\n</div></td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">wk inc flu hosp</td></tr>\n    <tr><td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p><strong>rounds</strong>\n└<strong>1</strong>\n└─<strong>model_tasks</strong>\n└──<strong>1</strong>\n└───<strong>output_type</strong>\n└────<strong>mean</strong>\n└─────<strong>type_id</strong></p>\n</div></td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p>properties\n└<strong>rounds</strong>\n└─items\n└──properties\n└───<strong>model_tasks</strong>\n└────items\n└─────properties\n└──────<strong>output_type</strong>\n└───────properties\n└────────<strong>mean</strong>\n└─────────properties\n└──────────<strong>type_id</strong>\n└───────────<strong>oneOf</strong></p>\n</div></td>\n<td class=\"gt_row gt_center\">oneOf</td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">❌ must match exactly one schema in oneOf</td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre-wrap;\"><div class='gt_from_md'><p><strong>1</strong>\n<strong>required-description:</strong> When mean is required, property set to single element 'NA' array\n<strong>required-type:</strong> array\n<strong>required-items-const:</strong>'NA'\n<strong>required-items-maxItems:</strong> 1\n<strong>optional-description:</strong> When mean is required, property set to null\n<strong>optional-type:</strong> null</p>\n<p><strong>2</strong>\n<strong>required-description:</strong> When mean is optional, property set to null\n<strong>required-type:</strong> null\n<strong>optional-description:</strong> When mean is optional, property set to single element 'NA' array\n<strong>optional-type:</strong> array\n<strong>optional-items-const:</strong>'NA'\n<strong>optional-items-maxItems:</strong> 1</p>\n</div></td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">required: NA, optional: NA</td></tr>\n    <tr><td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p><strong>rounds</strong>\n└<strong>1</strong>\n└─<strong>submissions_due</strong></p>\n</div></td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre;\"><div class='gt_from_md'><p>properties\n└<strong>rounds</strong>\n└─items\n└──properties\n└───<strong>submissions_due</strong>\n└────<strong>oneOf</strong></p>\n</div></td>\n<td class=\"gt_row gt_center\">oneOf</td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">❌ must match exactly one schema in oneOf</td>\n<td class=\"gt_row gt_left\" style=\"white-space: pre-wrap;\"><div class='gt_from_md'><p><strong>1</strong>\n<strong>relative_to-description:</strong> Name of task id variable in relation to which submission start and end dates are calculated.\n<strong>relative_to-type:</strong> string\n<strong>start-description:</strong> Difference in days between start and origin date.\n<strong>start-type:</strong> integer\n<strong>start-format:</strong>'NA'\n<strong>end-description:</strong> Difference in days between end and origin date.\n<strong>end-type:</strong> integer\n<strong>end-format:</strong>'NA'\n<strong>required1:</strong> relative_to\n<strong>required2:</strong> start\n<strong>required3:</strong> end</p>\n<p><strong>2</strong>\n<strong>relative_to-description:</strong>'NA'\n<strong>relative_to-type:</strong>'NA'\n<strong>start-description:</strong> Submission start date.\n<strong>start-type:</strong> string\n<strong>start-format:</strong> date\n<strong>end-description:</strong> Submission end date.\n<strong>end-type:</strong> string\n<strong>end-format:</strong> date\n<strong>required1:</strong> start\n<strong>required2:</strong> end</p>\n</div></td>\n<td class=\"gt_row gt_center\" style=\"background-color: #F9E3D6; font-weight: bold;\">start: -6, end: 1</td></tr>\n  </tbody>\n  <tfoot class=\"gt_sourcenotes\">\n    <tr>\n      <td class=\"gt_sourcenote\" colspan=\"6\">For more information, please consult the\n<a href=\"https://hubdocs.readthedocs.io/en/latest/\"><strong><code>hubDocs</code> documentation</strong>.</a></td>\n    </tr>\n  </tfoot>\n  \n</table>"

