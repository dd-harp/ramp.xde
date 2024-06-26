% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-basicL-xde.R
\name{LBionomics.basicL}
\alias{LBionomics.basicL}
\title{Reset aquatic parameters to baseline}
\usage{
\method{LBionomics}{basicL}(t, y, pars, s)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}

\item{s}{the species index}
}
\value{
a named \link{list}
}
\description{
Implements \link{LBionomics} for the RM model
}
