% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-GeRM.R
\name{make_MYZpar_GeRM}
\alias{make_MYZpar_GeRM}
\title{Make parameters for GeRM ODE adult mosquito model}
\usage{
make_MYZpar_GeRM(
  nPatches,
  MYZopts = list(),
  EIPopts,
  calK,
  g = 1/12,
  g_par = list(),
  sigma = 1/8,
  sigma_par = list(),
  mu = 0,
  mu_par = list(),
  f = 0.3,
  f_par = list(),
  q = 0.95,
  q_par = list(),
  nu = 1,
  nu_par = list(),
  eggsPerBatch = 60
)
}
\arguments{
\item{nPatches}{is the number of patches, an integer}

\item{MYZopts}{a \link{list} of values that overwrites the defaults}

\item{EIPopts}{a \link{list} that defines the EIP model}

\item{calK}{a mosquito dispersal matrix of dimensions \code{nPatches} by \code{nPatches}}

\item{g}{mosquito mortality rate}

\item{g_par}{parameters to configure F_g}

\item{sigma}{emigration rate}

\item{sigma_par}{parameters to configure F_sigma}

\item{mu}{emigration loss}

\item{mu_par}{parameters to configure F_mu}

\item{f}{feeding rate}

\item{f_par}{parameters to configure F_f}

\item{q}{human blood fraction}

\item{q_par}{parameters to configure F_q}

\item{nu}{oviposition rate, per mosquito}

\item{nu_par}{parameters to configure F_nu}

\item{eggsPerBatch}{eggs laid per oviposition}
}
\value{
a \link{list}
}
\description{
Make parameters for GeRM ODE adult mosquito model
}
