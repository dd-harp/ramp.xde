% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_variables.R
\name{compute_vars_cohort}
\alias{compute_vars_cohort}
\title{Differential equation models for human cohorts}
\usage{
compute_vars_cohort(a, y, pars, F_eir)
}
\arguments{
\item{a}{age of a cohort}

\item{y}{state vector}

\item{pars}{a \link{list}}

\item{F_eir}{a trace function that returns the eir}
}
\value{
\strong{pars} a \link{list}
}
\description{
Compute everything but the derivatives for a human cohort
differential equation model
}
