% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vector_control-interface.R
\name{VectorControlEffectSizes}
\alias{VectorControlEffectSizes}
\title{Vector control effect sizes}
\usage{
VectorControlEffectSizes(t, y, pars)
}
\arguments{
\item{t}{current simulation time}

\item{y}{state vector}

\item{pars}{a \link{list}}
}
\value{
a \link{list}
}
\description{
This method dispatches on the type of \code{pars$VECTOR_CONTROL}.
}
