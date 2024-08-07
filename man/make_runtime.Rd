% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runtime.R
\name{make_runtime}
\alias{make_runtime}
\title{Set up run-time time step support for \code{dts} models}
\usage{
make_runtime(pars, Xday, MYZday, Lday, Lname)
}
\arguments{
\item{pars}{an \code{xds} object}

\item{Xday}{is the run-time time step for X component (in days): integer or 1/integer}

\item{MYZday}{is the run-time time step for MYZ component (in days): integer or 1/integer}

\item{Lday}{is the run-time time step for L component (in days): integer or 1/integer}

\item{Lname}{is the S3 class of the L model}
}
\value{
the modified \code{xds} object
}
\description{
Set the time steps for various discrete time models
}
