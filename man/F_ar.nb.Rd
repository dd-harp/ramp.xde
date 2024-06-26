% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exposure-nb.R
\name{F_ar.nb}
\alias{F_ar.nb}
\title{The daily FoI as a function of the daily EIR under a negative binomial model of exposure.}
\usage{
\method{F_ar}{nb}(eir, b, pars)
}
\arguments{
\item{eir}{the daily eir for each stratum}

\item{b}{the probability of infection, per bite}

\item{pars}{the model object as a \link{list}}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
Implements \link{F_ar} for a negative binomial model
}
