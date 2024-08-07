% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exposure.R
\name{foi2eir}
\alias{foi2eir}
\title{Convert FoI to EIR}
\usage{
foi2eir(foi, b, pars)
}
\arguments{
\item{foi}{the daily FoI for each stratum}

\item{b}{the probability of infection, per bite}

\item{pars}{an \strong{\code{xds}} object}
}
\value{
the daily EIR as a \link{numeric} vector
}
\description{
This function computes the inverse of \link{F_foi}
under a model for environmentally heterogeneous exposure.
}
\seealso{
Cases: \link{foi2eir.pois} & \link{foi2eir.nb}
}
