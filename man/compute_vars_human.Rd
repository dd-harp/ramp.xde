% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_variables.R
\name{compute_vars_human}
\alias{compute_vars_human}
\title{Compute other variables at time t}
\usage{
compute_vars_human(t, y, pars)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}
}
\value{
\strong{pars} a \link{list}
}
\description{
Compute everything but the derivatives for a human-only
differential equation model
}
