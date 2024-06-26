% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human-interface.R
\name{F_pr}
\alias{F_pr}
\title{Compute the "true" prevalence of infection / parasite rate}
\usage{
F_pr(varslist, pars, i)
}
\arguments{
\item{varslist}{a parsed list of outputs with variables attached by name}

\item{pars}{a list}

\item{i}{the host species index}
}
\value{
a \link{numeric} vector of length \code{nStrata}
}
\description{
This method dispatches on the type of \code{pars$Xpar[[i]]}.
}
