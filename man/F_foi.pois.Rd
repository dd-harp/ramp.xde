% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exposure-pois.R
\name{F_foi.pois}
\alias{F_foi.pois}
\title{Poisson Force of Infection}
\usage{
\method{F_foi}{pois}(eir, b, pars)
}
\arguments{
\item{eir}{the daily eir for each stratum}

\item{b}{the probability of infection, per bite}

\item{pars}{an \strong{\code{xds}} object}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
A Poisson model for the force of infection as a function of the daily EIR.
}
\details{
This function computes the daily FoI (\eqn{h})
as function of the local daily EIR (\eqn{E})
under a Poisson model for the distribution
of bites per person, and the probability of
infection per infective bite (\eqn{b}):
\deqn{h = b E}
}
\seealso{
Related: \link{F_foi} & \link{F_ar.pois} & \link{foi2eir.pois}. Called from \link{Exposure.xde}
}
