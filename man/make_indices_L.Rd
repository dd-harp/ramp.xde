% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-interface.R
\name{make_indices_L}
\alias{make_indices_L}
\title{Add indices for aquatic stage mosquitoes to parameter list}
\usage{
make_indices_L(pars, s)
}
\arguments{
\item{pars}{a \link{list}}

\item{s}{the species index}
}
\value{
none
}
\description{
This method dispatches on the type of \code{pars$Lpar}. Adds field \code{L_ix}
to parameter list.
}
