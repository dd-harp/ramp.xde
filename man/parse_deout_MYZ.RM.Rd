% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-RM.R
\name{parse_deout_MYZ.RM}
\alias{parse_deout_MYZ.RM}
\title{Parse the output of deSolve and return variables for the RM model}
\usage{
\method{parse_deout_MYZ}{RM}(deout, pars, s)
}
\arguments{
\item{deout}{a \link{matrix} of outputs from deSolve}

\item{pars}{a \link{list} that defines a model}

\item{s}{the species index}
}
\value{
a \link{list}
}
\description{
Implements \link{parse_deout_MYZ} for the RM model
}
