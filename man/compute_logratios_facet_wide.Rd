% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logratio-by2.R
\name{compute_logratios_facet_wide_at}
\alias{compute_logratios_facet_wide_at}
\alias{compute_logratios_facet_wide}
\title{Compute log ratios}
\usage{
compute_logratios_facet_wide_at(data = NULL, token = NULL, facet = NULL,
  cnt_min = 10)

compute_logratios_facet_wide(data = NULL, token = NULL, facet = NULL,
  cnt_min = 10)
}
\arguments{
\item{data}{data.frame.}

\item{token}{bare for NSE; character for SE. Name of column in \code{data} to use for count.}

\item{facet}{character. Name of column in \code{data} to use for facetting.
It is set to NULL by default in the non-\code{facet} function even though it is not necessary.
If specified with the non-\code{facet} version of the function,
then the function acts just like the \code{_facet} version.}

\item{cnt_min}{numeric. If not null, serves as a filter for which to compute log ratios.}
}
\value{
data.frame.
}
\description{
Compute log ratios for usage of tokens between two entities.
}
\details{
Note that an attempt was made to make this function flexible enough,
to consider a \code{num_top} or \code{top_pct} parameter that might be used if
\code{cnt_min = NULL}, but this can be troublesome because \code{do.call()}
does not seem to handle \code{NULL} in \code{...}.
}
\seealso{
\url{https://www.tidytextmining.com/twitter.html#comparing-token-usage}.
\url{http://varianceexplained.org/r/trump-tweets/}.
}
