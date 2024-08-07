% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-sei.R
\name{dMYZdt.sei}
\alias{dMYZdt.sei}
\title{Derivatives for a oviposition model for adult mosquito infection dynamics}
\usage{
\method{dMYZdt}{sei}(t, y, pars, s)
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
Implements \link{dMYZdt} for the sei ODE model.
}
