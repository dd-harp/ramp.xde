% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-SIS.R
\name{get_Xinits.SIS}
\alias{get_Xinits.SIS}
\title{Return initial values as a vector}
\usage{
\method{get_Xinits}{SIS}(pars, i = 1)
}
\arguments{
\item{pars}{an \strong{\code{xds}} object}

\item{i}{the host species index}
}
\value{
a \link{list}
}
\description{
This method dispatches on the type of \code{pars$Xpar}
}
