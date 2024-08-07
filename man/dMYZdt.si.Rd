% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-si.R
\name{dMYZdt.si}
\alias{dMYZdt.si}
\title{Derivatives for a simple model for adult mosquito infection dynamics}
\usage{
\method{dMYZdt}{si}(t, y, pars, s)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{an \code{xds} object}

\item{s}{the species index}
}
\value{
a \link{numeric} vector
}
\description{
Implements \link{dMYZdt} for the si ODE model.
}
