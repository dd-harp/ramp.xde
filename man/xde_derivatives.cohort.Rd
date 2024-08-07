% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xde_equations.R
\name{xde_derivatives.cohort}
\alias{xde_derivatives.cohort}
\title{Differential equation models for human cohorts}
\usage{
\method{xde_derivatives}{cohort}(t, y, pars)
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
