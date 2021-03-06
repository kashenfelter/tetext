% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/by2-helpers.R
\name{preprocess_xy_data}
\alias{preprocess_xy_data}
\title{Pre-process data in \code{wrapper_func()}}
\usage{
preprocess_xy_data(data = NULL, xy_info = NULL, col = NULL)
}
\arguments{
\item{data}{data.frame. Output from \code{create_xy_grid()}.}

\item{xy_info}{list. Output from \code{get_xy_info()}.}

\item{col}{character. Name of 'id' column in \code{data}.}
}
\value{
data.frame.
}
\description{
Pre-process \code{data} using \code{xy_info}.
}
\details{
To be used exclusively by \code{wrapper_func()}.
}
