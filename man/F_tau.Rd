% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-interface.R
\name{F_tau}
\alias{F_tau}
\title{Time spent host seeking/feeding and resting/ovipositing}
\usage{
F_tau(t, pars)
}
\arguments{
\item{t}{current simulation time}

\item{pars}{a \link{list}}
}
\value{
either a \link{numeric} vector if the model supports this feature, or \link{NULL}
}
\description{
This method dispatches on the type of \code{pars$MYZpar}.
}
