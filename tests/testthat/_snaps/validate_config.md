# Config errors detected successfully

    Code
      out
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

# Dynamic config errors detected successfully by custom R validation

    Code
      out
    Output
      [1] FALSE
      attr(,"config_path")
      [1] "testdata/tasks-errors-rval.json"
      attr(,"schema_version")
      [1] "v0.0.1"
      attr(,"schema_url")
      https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v0.0.1/tasks-schema.json
      attr(,"errors")
                                                                instancePath
      1 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_measure
      2 /rounds/0/model_tasks/1/target_metadata/1/target_keys/target_measure
      3 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_outcome
      4                      /rounds/0/model_tasks/1/task_ids/target_outcome
                                                                                                            schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      2 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      3 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      4                                     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
                   keyword
      1  target_keys names
      2  target_keys names
      3 target_keys values
      4     task_id values
                                                                                                              message
      1                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      2                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      3 target_key value 'flu hospitalisation' does not match any values in corresponding modeling task group task_id
      4                     task_id value(s) 'flu hosp, wk inc flu hosp' not defined in any corresponding target_key.
        schema
      1       
      2       
      3       
      4       
                                                                                                                                                data
      1             task_id names: origin_date, target_outcome, target_mesures, horizon, location;\ntarget_key names: target_measure, target_outcome
      2             task_id names: origin_date, target_outcome, target_mesures, horizon, location;\ntarget_key names: target_measure, target_outcome
      3                    task_id.target_outcome values: flu hosp, wk inc flu hosp, flu case;\ntarget_key.target_outcome value: flu hospitalisation
      4 task_id.target_outcome unique values: flu hospitalisation, flu case;\ntarget_key.target_outcome unique values: flu hospitalisation, flu case

