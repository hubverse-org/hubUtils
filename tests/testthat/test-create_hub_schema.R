test_that("create_hub_schema works correctly", {
     hub_path <- system.file("testhubs/simple", package = "hubUtils")
     config_tasks <- read_config(hub_path, "tasks")

     schema_csv <- create_hub_schema(config_tasks)
     expect_equal(
         schema_csv$ToString(),
         "origin_date: date32[day]\ntarget: string\nhorizon: int32\nlocation: string\nage_group: string\noutput_type: string\noutput_type_id: double\nvalue: int32\nmodel_id: string"
     )

     schema_csv <- create_hub_schema(config_tasks,
                                     output_type_id_datatype = "character")
     expect_equal(
         schema_csv$ToString(),
         "origin_date: date32[day]\ntarget: string\nhorizon: int32\nlocation: string\nage_group: string\noutput_type: string\noutput_type_id: string\nvalue: int32\nmodel_id: string"
     )
})
