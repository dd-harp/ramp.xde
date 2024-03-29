% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/egg_laying.R
\name{setup_EGGpar_static}
\alias{setup_EGGpar_static}
\title{Setup the structures required for egg laying}
\usage{
setup_EGGpar_static(pars)
}
\arguments{
\item{pars}{the model object}
}
\value{
a \link{list} vector
}
\description{
This sets up the object EGGpar, which holds information
about the egg laying model. Several terms are expected to differ by
vector species, including the search weights (searchWts), the fraction
of eggs laid in habitat that is sometimes suitable (Qfrac), the
egg deposition matrix (calU), and the habitat egg laying rate (eggs_laid).
This function sets up lists.
}
