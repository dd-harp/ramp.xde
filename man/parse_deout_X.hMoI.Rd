% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-hMoI.R
\name{parse_deout_X.hMoI}
\alias{parse_deout_X.hMoI}
\title{Parse the output of deSolve and return variables for the hMoI model}
\usage{
\method{parse_deout_X}{hMoI}(deout, pars, i)
}
\arguments{
\item{deout}{a \link{matrix} of outputs from deSolve}

\item{pars}{a \link{list} that defines a model}

\item{i}{the host species index}
}
\value{
none
}
\description{
Implements \link{parse_deout_X} for the hMoI model
}
