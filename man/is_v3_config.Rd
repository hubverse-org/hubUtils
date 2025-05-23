% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/v3-schema-utils.R
\name{is_v3_config}
\alias{is_v3_config}
\title{Is config list representation using v3.0.0 schema?}
\usage{
is_v3_config(config)
}
\arguments{
\item{config}{List representation of the JSON config file.}
}
\value{
Logical, whether the config list representation is using v3.0.0 schema or greater.
}
\description{
Is config list representation using v3.0.0 schema?
}
\examples{
config <- read_config_file(
  system.file("config", "tasks.json", package = "hubUtils")
)
is_v3_config(config)
}
