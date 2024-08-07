% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bionomics.R
\name{MBionomics.static}
\alias{MBionomics.static}
\title{Set mosquito bionomics to baseline}
\usage{
\method{MBionomics}{static}(t, y, pars, s)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{an \code{xds} object}

\item{s}{the species index}
}
\value{
an \code{xds} object
}
\description{
Implements \link{MBionomics} for models with no forcing
}
