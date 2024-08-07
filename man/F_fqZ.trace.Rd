% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-trace.R
\name{F_fqZ.trace}
\alias{F_fqZ.trace}
\title{Blood feeding rate of the infective mosquito population}
\usage{
\method{F_fqZ}{trace}(t, y, pars, s)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}

\item{s}{the species index}
}
\value{
a \link{numeric} vector of length \code{nHabitats}
}
\description{
Implements \link{F_fqZ} for the trace model.
}
