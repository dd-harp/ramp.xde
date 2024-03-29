% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-basic.R
\name{make_Lpar_basic}
\alias{make_Lpar_basic}
\title{Make parameters for basic competition aquatic mosquito model}
\usage{
make_Lpar_basic(nHabitats, Lopts = list(), psi = 1/8, phi = 1/8, theta = 1/100)
}
\arguments{
\item{nHabitats}{the number of habitats in the model}

\item{Lopts}{a \link{list} that overwrites default values}

\item{psi}{maturation rates for each aquatic habitat}

\item{phi}{density-independent mortality rates for each aquatic habitat}

\item{theta}{density-dependent mortality terms for each aquatic habitat}
}
\value{
a \link{list} with Lpar added
}
\description{
Make parameters for basic competition aquatic mosquito model
}
