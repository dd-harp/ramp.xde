% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-RM-xde.R
\name{make_parameters_MYZ_RM}
\alias{make_parameters_MYZ_RM}
\title{Make parameters for RM ODE adult mosquito model}
\usage{
make_parameters_MYZ_RM(
  pars,
  g,
  sigma,
  mu,
  f,
  q,
  nu,
  eggsPerBatch,
  eip,
  calK,
  solve_as = "dde"
)
}
\arguments{
\item{pars}{a \link{list}}

\item{g}{mosquito mortality rate}

\item{sigma}{emigration rate}

\item{mu}{emigration loss}

\item{f}{feeding rate}

\item{q}{human blood fraction}

\item{nu}{oviposition rate, per mosquito}

\item{eggsPerBatch}{eggs laid per oviposition}

\item{eip}{length of extrinsic incubation period}

\item{calK}{mosquito dispersal matrix of dimensions \code{nPatches} by \code{nPatches}}

\item{solve_as}{is either \code{ode} to solve as an ode or \code{dde} to solve as a dde}
}
\value{
a \link{list}
}
\description{
Make parameters for RM ODE adult mosquito model
}
