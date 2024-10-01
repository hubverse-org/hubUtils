#' Hubverse model output standard column names
#'
#' A named character string of standard column names used in hubverse model output data files.
#' The terms currently used for standard column names in the hubverse are English.
#' In future, however, this could be expanded to provide the basis for hub
#' terminology localisation.
"std_colnames"


#' Example Hub model output data
#'
#' A subset of model output data accessed using `hubData` from the simple example
#' hub contained in the `hubUtils` package. The subset consists of `"quantile"` output
#' type data for `"US"` location and the most recent forecast date.
#'
#' @format
#' A `tbl` with 92 rows and 8 columns:
#' - `forecast_date`: Origin date of the forecast.
#' - `horizon`: Forecast horizon relative to the `forecast_date`.
#' - `target`: Target variable.
#' - `location`: Location of the forecast.
#' - `output_type`: Output type of forecast.
#' - `output_type_id`: Forecast output type level/identifier. In this case,
#' quantile level.
#' - `value`: Forecast value.
#' - `model_id`: Model identifier.
"hub_con_output"
