# target-data

This folder contains target data for the hub. There are three files:

- `flu-hospitalization-time-series.csv` has the data in a time series format, with three columns:

  - `location`: FIPS code identifying a location
  - `date`: the Saturday ending the week during which hospital admission were recorded, in format `yyyy-mm-dd`
  - `value`: the number of influenza hospital admissions in the specified `location` over the course of the week ending on the specified `date`.

  This data file is useful as a modeling input and for plots of the time series values.

- `wk-inc-flu-hosp-target-values.csv` records the observed values for the `"wk inc flu hosp"` target. This file has six columns:

  - `location`: FIPS code identifying a location
  - `reference_date`: the Saturday ending the week during which predictions were generated, in format `yyyy-mm-dd`
  - `horizon`: integer number of weeks offset between the `reference_date` and the target week of the forecast
  - `target_end_date`: the Saturday ending the target week of the forecast, in format `yyyy-mm-dd`. The `target_end_date` is equal to the `reference_date` plus the `horizon` times 7 days.
  - `target`: the target variable for the forecast. In this file, all values of the target are `"wk inc flu hosp"`.
  - `value`: the reported number of hospital admissions in the specified `location` during the week ending on the `target_end_date`.
  
  This data file is useful for evaluating forecasts of the `"wk inc flu hosp"` target.

- `wk-flu-hosp-rate-category-target-values.csv` records the observed values for the `"wk flu hosp rate category"` target. This file has seven columns:

  - `location`: FIPS code identifying a location
  - `reference_date`: the Saturday ending the week during which predictions were generated, in format `yyyy-mm-dd`
  - `horizon`: integer number of weeks offset between the `reference_date` and the target week of the forecast
  - `target_end_date`: the Saturday ending the target week of the forecast, in format `yyyy-mm-dd`. The `target_end_date` is equal to the `reference_date` plus the `horizon` times 7 days.
  - `target`: the target variable for the forecast. In this file, all values of the target are `"wk flu hosp rate category"`.
  - `output_type_id`: the name of the rate category that was observed.
  - `value`: all values are `1`.
  
  This data file is useful for evaluating forecasts of the `"wk flu hosp rate category"` target.  For forecasts of pmf targets, for brevity the target data file includes only rows for the observed level of the target in the `output_type_id` column, with a `1` recorded for the `value`. This implies that the `value` for all other `output_type_id`s is `0`.
