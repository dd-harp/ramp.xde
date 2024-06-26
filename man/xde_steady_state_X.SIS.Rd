% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-SIS.R
\name{xde_steady_state_X.SIS}
\alias{xde_steady_state_X.SIS}
\title{Compute the steady states for the SIS model as a function of the daily EIR}
\usage{
\method{xde_steady_state_X}{SIS}(eir, H, pars, i)
}
\arguments{
\item{eir}{the daily EIR}

\item{H}{the human population density}

\item{pars}{a list that defines an \code{ramp.xde} model (\emph{e.g.},  generated by \code{xde_setup()})}

\item{i}{the host species index}
}
\value{
the steady states as a named vector
}
\description{
Compute the steady state of the SIS model as a function of the daily eir.
}
