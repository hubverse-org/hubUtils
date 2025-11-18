# Example Hub model output data

A subset of model output data accessed using `hubData` from the simple
example hub contained in the `hubUtils` package. The subset consists of
`"quantile"` output type data for `"US"` location and the most recent
forecast date.

## Usage

``` r
hub_con_output
```

## Format

A `tbl` with 92 rows and 8 columns:

- `forecast_date`: Origin date of the forecast.

- `horizon`: Forecast horizon relative to the `forecast_date`.

- `target`: Target variable.

- `location`: Location of the forecast.

- `output_type`: Output type of forecast.

- `output_type_id`: Forecast output type level/identifier. In this case,
  quantile level.

- `value`: Forecast value.

- `model_id`: Model identifier.
