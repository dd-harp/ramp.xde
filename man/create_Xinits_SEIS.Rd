% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-SEIS.R
\name{create_Xinits_SEIS}
\alias{create_Xinits_SEIS}
\title{Make initial values for the SEIS xde human model, with defaults}
\usage{
create_Xinits_SEIS(nStrata, H0, Xopts = list(), E = 0, I = 1)
}
\arguments{
\item{nStrata}{the number of strata in the model}

\item{H0}{the initial human population density}

\item{Xopts}{a \link{list} to overwrite defaults}

\item{E}{the initial values of the parameter E}

\item{I}{the initial values of the parameter I}
}
\value{
a \link{list}
}
\description{
Make initial values for the SEIS xde human model, with defaults
}
