% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exposure-pois.R
\name{ar2eir.pois}
\alias{ar2eir.pois}
\title{Convert AR to EIR under a Poisson model for Exposure}
\usage{
\method{ar2eir}{pois}(ar, b, pars)
}
\arguments{
\item{ar}{the attack rate}

\item{b}{the probability of infection, per bite}

\item{pars}{an \code{xds} object}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
The inverse of \link{F_ar.pois}
is \deqn{E = -\frac{\log(1-ar)}{b}}
}
\seealso{
Also, see \link{F_ar.pois}
}
