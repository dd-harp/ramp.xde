% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aquatic-basicL.R
\name{create_Lpar_basicL}
\alias{create_Lpar_basicL}
\title{Make parameters for basicL competition aquatic mosquito model}
\usage{
create_Lpar_basicL(
  nHabitats,
  Lopts = list(),
  psi = 1/8,
  phi = 1/8,
  theta = 1/100
)
}
\arguments{
\item{nHabitats}{the number of habitats in the model}

\item{Lopts}{a named \link{list}}

\item{psi}{maturation rates for each aquatic habitat}

\item{phi}{density-independent mortality rates for each aquatic habitat}

\item{theta}{density-dependent mortality terms for each aquatic habitat}
}
\value{
\strong{\code{Lpar}} an \strong{\code{xds}} \eqn{\cal L} object
}
\description{
Make parameters for basicL competition aquatic mosquito model
}
\seealso{
Related: \link{dLdt.basicL} & \link{Update_Lt.basicL}
}
