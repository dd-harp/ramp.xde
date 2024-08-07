% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dts_equations.R
\name{dts_update_MYZt}
\alias{dts_update_MYZt}
\title{Difference equations isolating the humans, forced with Ztrace}
\usage{
dts_update_MYZt(t, y, pars, s)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}

\item{s}{the vector species index}
}
\value{
a \link{vector} containing the vector of all state derivatives
}
\description{
Compute and update the state variables for
a model with only humans
}
