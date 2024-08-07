% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-interface.R
\name{F_b}
\alias{F_b}
\title{Infection blocking pre-erythrocytic immunity}
\usage{
F_b(y, pars, i)
}
\arguments{
\item{y}{state vector}

\item{pars}{an \strong{\code{xds}} object}

\item{i}{the host species index}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
This method dispatches on the type of \code{pars$Xpar[[i]]}.
}
