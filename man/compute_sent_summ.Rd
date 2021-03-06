% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sents.R
\name{compute_sent_summ_facet_at}
\alias{compute_sent_summ_facet_at}
\alias{compute_sent_summ_facet}
\alias{compute_sent_summ_at}
\alias{compute_sent_summ}
\title{Compute sentiment scores.}
\usage{
compute_sent_summ_facet_at(data = NULL, token = NULL, feature = NULL,
  facet = NULL, lexicon = "bing", ...)

compute_sent_summ_facet(..., token, feature, facet)

compute_sent_summ_at(data = NULL, facet = NULL, ...)

compute_sent_summ(..., token, feature, facet)
}
\arguments{
\item{data}{data.frame. Must already be in 'tidy' format.}

\item{token}{bare for NSE; character for SE. Name of column in \code{data} whose values are scored.}

\item{feature}{bare for NSE; character for SE. Name of column in \code{data} whose values serve as
entity across which 'token' values are scored. Probably something like 'sentence',
or, in the case of Twitter data, 'status_id'.}

\item{facet}{bare for NSE; character for SE. Name of column in \code{data} used for grouping in the case
that there are more than one entitiy.}

\item{lexicon}{character. Specifies lexicon to use. Must be a lexicon available in the \code{tidytext::package}.}

\item{...}{dots. Parameters to pass to \code{get_sents()} internally.}
}
\value{
data.frame.
}
\description{
Compute sentiment scores given tokens.
}
\details{
Heavily influenced by \href{https://www.tidytextmining.com/}{\emph{Text Mining with R}}.
Creates output columns 'sentiment' and 'score'.
}
\seealso{
Don't have an explicit url.
}
