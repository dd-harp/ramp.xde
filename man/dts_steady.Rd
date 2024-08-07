% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dts_solving.R
\name{dts_steady}
\alias{dts_steady}
\title{Solve for the steady state of a system of equations}
\usage{
dts_steady(pars, Tx = 1000)
}
\arguments{
\item{pars}{a \link{list} that defines a model}

\item{Tx}{the number of steps to equilibrium}
}
\value{
a \link{list}
}
\description{
This method dispatches on the type of \code{pars$dts}
}
