% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-bionomics.R
\name{F_g}
\alias{F_g}
\title{Compute mosguito survival}
\usage{
F_g(t, MYZpar)
}
\arguments{
\item{t}{current simulation time}

\item{MYZpar}{a \link{list}}
}
\value{
a \link{numeric} vector of length \code{nPatches}
}
\description{
This method dispatches on the type of \code{MYZpar$g_par}. It should
set the values of g to (possibly changing) baseline values.
}
