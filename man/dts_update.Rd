% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dts_equations.R
\name{dts_update}
\alias{dts_update}
\title{Update States for Discrete-Time Systems}
\usage{
dts_update(t, y, pars)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}
}
\value{
a \link{list} containing the vector of all state derivatives
}
\description{
Updates the state variables
}