# target-data

This folder contains target data for the hub. There are two files:

- `time-series.csv` has the data in a time series format, with four columns:

  - `target_end_date`: the Saturday ending the week during which hospital admission were recorded, in format `yyyy-mm-dd`
  - `target`: the target variable for the forecast. In this file, all values of the target are either `"wk inc flu hosp"` or `"wk flu hosp rate"`
  - `location`: FIPS code identifying a US location
  - `observation`: the observed (reported) values for the specified `target` and `location` over the course of the week ending on the specified `target_and_date`. For `"wk inc flu hosp"`, this is the number of weekly influenza hospital admissions. For `"wk flu hosp rate"`, this is the rate of weekly influenza hospital admissions per 100,000 population of the particular `location`.

  This data file is useful as a modeling input and for plots of the time series values.

- `oracle-output.csv` records the observed values for the `"wk inc flu hosp"` target. This file has six columns:

  - `location`: FIPS code identifying a US location
  - `target_end_date`: the Saturday ending the target week of the forecast, in format `yyyy-mm-dd`.
  - `target`: the target variable for the forecast. In this file, values of the target are one of `"wk inc flu hosp"`, `"wk flu hosp rate"`, `"wk for your hosp great category"`
  - `output_type`: the type of forecast for the specified `target`. The output type defines the format of the `output_type_id` and `oracle_value` column values
  - `output_type_id`: depends based on the particular `target` and `output_type`
    - For `"wk inc flu hosp"`, all values are NA
    - For `"wk flu hosp rate category"`, the CDF values of interest for the weekly influenza hospital admission rate per 100,000 population
    - For `"wk flu hosp rate category"`, the names of the possible rate categories
  - `oracle_value`: depends based on the particular `target` and `output_type`
    - For `"wk inc flu hosp"`, the reported number of influenza hospital admissions in the specified location during the week ending on the `target_end_date`
    - For `"wk flu hosp rate"`, 1 when the specified `output_type_id` is greater than or equal to the reported value for the rate of weekly influenza hospital admissions per 100,000 population of the particular `location`; 0 otherwise
    - For `"wk flu hosp rate category"`, 1 when the specified `output_type_id` is the observed weekly rate category for the particular `location`; 0 otherwise
  
  This data file is useful for evaluating forecasts.
  