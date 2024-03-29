% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-interface.R
\name{parse_deout_L}
\alias{parse_deout_L}
\title{Parse the output of deSolve and return the variables by name in a list}
\usage{
parse_deout_L(deout, pars, s)
}
\arguments{
\item{deout}{a \link{matrix} of outputs from deSolve}

\item{pars}{a \link{list} that defines the model}

\item{s}{the species index}
}
\description{
This method dispatches on the type of \code{pars$Lpar}. Attaches the
state variables for the aquatic ecology model to a list and returns it
}
