% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-hMoI.R
\name{F_pr_by_pcr.hMoI}
\alias{F_pr_by_pcr.hMoI}
\title{Compute the prevalence of infection by PCR}
\usage{
\method{F_pr_by_pcr}{hMoI}(vars, Xpar)
}
\arguments{
\item{vars}{a list with the variables attached by name}

\item{Xpar}{a list defining a model for human}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
Implements \link{F_pr} for the hMoI model.
}
