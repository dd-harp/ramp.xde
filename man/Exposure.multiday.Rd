% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exposure-multiday.R
\name{Exposure.multiday}
\alias{Exposure.multiday}
\title{Exposure and Infection}
\usage{
\method{Exposure}{multiday}(t, y, pars)
}
\arguments{
\item{t}{the time}

\item{y}{the state variables}

\item{pars}{an \strong{\code{xds}} object}
}
\value{
the function modifies \strong{pars} and returns it: the computed FoI are stored as \code{pars$FoI}
}
\description{
This function translates seven days of daily entomological
inoculation rate (dEIR) into a multiday attack rate. The daily FoI
is the sum of two terms: 1) a function \link{F_foi} computes the local dFoI;
2) a function \link{travel_malaria} that computes the FoI resulting from
exposure while traveling.
}
