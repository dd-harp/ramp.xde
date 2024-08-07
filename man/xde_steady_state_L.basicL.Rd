% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-basicL.R
\name{xde_steady_state_L.basicL}
\alias{xde_steady_state_L.basicL}
\title{Compute the steady state as a function of the egg deposition rate eta}
\usage{
\method{xde_steady_state_L}{basicL}(eta, Lpar)
}
\arguments{
\item{eta}{the egg-laying rate}

\item{Lpar}{a list that defines an xde model}
}
\value{
a named \link{list}
}
\description{
This method dispatches on the type of \code{Lpar}.
}
