% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/control.R
\name{Control.static}
\alias{Control.static}
\title{Modify parameters due to exogenous forcing by all kinds of control}
\usage{
\method{Control}{static}(t, y, pars)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state variables}

\item{pars}{a \link{list}}
}
\value{
\link{list}
}
\description{
Implements \link{Control} for the static model; after setting up, do nothing
}
