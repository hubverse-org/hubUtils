# Get the output type ID values of each output type of a modeling task.
#
# Before schema v4.0.0, output type IDs are split into `required` and
# `optional`. From v4.0.0, all values sit in `required`, and the output type's
# `is_required` setting says whether they are required. With
# `required_vals_only = TRUE`, output types that are not required are left
# out, unless `force_output_types = TRUE`.
get_mt_output_type_ids <- function(
  output_types,
  config_tid,
  required_vals_only,
  force_output_types
) {
  if (required_vals_only && !force_output_types) {
    output_types <- output_types[
      purrr::map_lgl(output_types, \(x) is_required_output_type(x, config_tid))
    ]
  }
  purrr::map(
    output_types,
    \(output_type) {
      output_type_ids <- output_type[[config_tid]]
      only_required <- required_vals_only &&
        !force_output_types &&
        has_required_optional(output_type_ids)
      values <- if (only_required) {
        output_type_ids[["required"]]
      } else {
        c(output_type_ids[["required"]], output_type_ids[["optional"]])
      }
      # Output types such as `mean` and `sample` have no output type ID
      # values. Their only valid output type ID is `NA`.
      values %||% NA
    }
  )
}

# Whether an output type is required. Before schema v4.0.0, it is required if
# it has `required` output type IDs. From v4.0.0, `is_required` says so, set on
# the output type or, for `sample`, in `output_type_id_params`.
is_required_output_type <- function(output_type, config_tid) {
  output_type_ids <- output_type[[config_tid]]
  if (has_required_optional(output_type_ids)) {
    return(!is.null(output_type_ids[["required"]]))
  }
  isTRUE(output_type[["is_required"]]) ||
    isTRUE(output_type[["output_type_id_params"]][["is_required"]])
}

# Whether output type IDs are split into `required` and `optional`, as they are
# before schema v4.0.0.
has_required_optional <- function(output_type_ids) {
  setequal(names(output_type_ids), c("required", "optional"))
}
