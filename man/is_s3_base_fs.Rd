% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-url.R
\name{is_s3_base_fs}
\alias{is_s3_base_fs}
\title{Detect whether An object of class \verb{<SubTreeFileSystem>} represents the base
path of an S3 file system (i.e. the root of a cloud hub)}
\usage{
is_s3_base_fs(s3_fs)
}
\arguments{
\item{s3_fs}{An object of class \verb{<SubTreeFileSystem>}.}
}
\value{
Logical. \code{TRUE} if the object represents the base path of an S3 file,
\code{FALSE} otherwise.
}
\description{
Detect whether An object of class \verb{<SubTreeFileSystem>} represents the base
path of an S3 file system (i.e. the root of a cloud hub)
}
\examples{
\dontshow{if (asNamespace("hubUtils")$not_rcmd_check() && requireNamespace("arrow", quietly = TRUE)) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
hub_path <- arrow::s3_bucket("hubverse/hubutils/testhubs/simple/")
config_path <- hub_path$path("hub-config/admin.json")
is_s3_base_fs(hub_path)
is_s3_base_fs(config_path)
\dontshow{\}) # examplesIf}
}
