#' assume starting output type is sample, inputs have been validated
#' support one input output_type and one output output_type
#'
#' @param new_output_type vector of strings indicating the desired output_type after
#'   transformation; can be `"mean"`, `"median"`, `"quantile"`, `"cdf"`
#' @param new_output_type_id corresponding output_type_ids, list if multiple output_type ids
convert_output_type <- function(model_outputs, group_by_cols,
                                new_output_type, new_output_type_id,
                                n_samples = 1e4, ...){
    # for cdf and quantile functions, get samples
    starting_output_type = model_outputs$output_type %>% unique()
    starting_output_type_ids = model_outputs$output_type_id %>% unique()
    if(starting_output_type == "cdf"){
        # estimate from samples
        model_outputs <- get_samples_from_cdf(model_outputs, group_by_cols, n_samples)
    }
    else if(starting_output_type == "quantile"){
        # if median output desired, and Q50 provided return exact value
        if(new_output_type == "median" & 0.5 %in% starting_output_type_ids){
            model_outputs_transform <- model_outputs %>%
                dplyr::filter(output_type_id == 0.5) %>%
                dplyr::mutate(output_type = new_output_type,
                              output_type_id = new_output_type_id) %>%
                hubUtils::as_model_out_tbl()
            return(model_outputs_transform)
        }
        # otherwise, estimate from samples
        else{
            model_outputs <- get_samples_from_quantiles(model_outputs, group_by_cols, n_samples)
        }
    }
    # transform based on new_output_type
    grouped_model_outputs <- model_outputs %>%
        dplyr::group_by(model_id, dplyr::across(dplyr::all_of(group_by_cols)))
    model_outputs_transform <- convert_from_sample(
        grouped_model_outputs, new_output_type, new_output_type_id
    )
    return(model_outputs_transform)
}

get_samples_from_quantiles <- function(model_outputs, group_by_cols, n_samples, ...){
    set.seed(101)
    samples <- model_outputs %>%
        dplyr::group_by(model_id, dplyr::across(dplyr::all_of(group_by_cols))) %>%
        dplyr::summarize(
            value = distfromq::make_q_fn(
                ps = as.numeric(.data$output_type_id),
                qs = .data$value, ...
            )(runif(n_samples, 0, 1)),
            .groups = "drop"
        )


    return(samples)
}

get_samples_from_cdf <- function(model_outputs, group_by_cols, n_samples, ...){
    set.seed(101)
    samples <- model_outputs %>%
        dplyr::group_by(model_id, dplyr::across(dplyr::all_of(group_by_cols))) %>%
        dplyr::summarize(
            value = distfromq::make_q_fn(
                    ps = .data$value,
                    qs = as.numeric(.data$output_type_id), ...
                )(runif(n_samples, 0, 1)),
            .groups = "drop"
        )
    return(samples)
}

convert_from_sample <- function(grouped_model_outputs, new_output_type,
                                new_output_type_id){
    if(new_output_type == "mean"){
        model_outputs_transform <- grouped_model_outputs %>%
            dplyr::reframe(value = mean(value),
                             output_type_id = new_output_type_id)
    }
    else if(new_output_type == "median"){
        model_outputs_transform <- grouped_model_outputs %>%
            dplyr::reframe(value = median(value),
                             output_type_id = new_output_type_id)
    }
    else if(new_output_type == "quantile"){
        model_outputs_transform <- grouped_model_outputs %>%
            dplyr::reframe(value = quantile(value, as.numeric(new_output_type_id),
                                            names = FALSE),
                             output_type_id = new_output_type_id)
    }
    else if(new_output_type == "cdf"){
        model_outputs_transform <- grouped_model_outputs %>%
            dplyr::reframe(value = ecdf(value)(as.numeric(new_output_type_id)),
                             output_type_id = new_output_type_id)
    }
    # update output_type and output_type_id columns
    model_outputs_transform <- model_outputs_transform %>%
        dplyr::mutate(output_type = new_output_type) %>%
        hubUtils::as_model_out_tbl()
    return(model_outputs_transform)
}

