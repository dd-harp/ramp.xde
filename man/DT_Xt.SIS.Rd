% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-SIS.R
\name{DT_Xt.SIS}
\alias{DT_Xt.SIS}
\title{DTS updating for the SIS model for human / vertebrate host infections}
\usage{
\method{DT_Xt}{SIS}(t, y, pars, i)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a list}

\item{i}{the host species index}
}
\value{
a \link{numeric} vector
}
\description{
Implements \link{DT_Xt} for the SIS model
}
