% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-Ztrace.R
\name{F_fqZ.Ztrace}
\alias{F_fqZ.Ztrace}
\title{Blood feeding rate of the infective mosquito population}
\usage{
\method{F_fqZ}{Ztrace}(t, y, pars, s)
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
Implements \link{F_fqZ} for the Ztrace model.
}
