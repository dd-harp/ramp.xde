% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xde_diffeqn.R
\name{xDE_diffeqn_human}
\alias{xDE_diffeqn_human}
\title{Differential equations isolating the humans, forced with Ztrace}
\usage{
xDE_diffeqn_human(t, y, pars)
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
Compute derivatives for \link[deSolve:ode]{deSolve::ode} or \link[deSolve:dede]{deSolve::dede} using
generic methods for each model component.
}
