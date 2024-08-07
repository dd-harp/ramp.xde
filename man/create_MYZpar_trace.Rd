% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-trace.R
\name{create_MYZpar_trace}
\alias{create_MYZpar_trace}
\title{Make parameters for trace aquatic mosquito model}
\usage{
create_MYZpar_trace(nPatches, MYZopts, f = 1, q = 1, MYZm = 1, MYZf = NULL)
}
\arguments{
\item{nPatches}{an integer}

\item{MYZopts}{a \link{list} of values that overwrites the defaults}

\item{f}{the blood feeding rate}

\item{q}{the human fraction}

\item{MYZm}{a vector of mean mosquito densities}

\item{MYZf}{a \link{function} of the form MYZf(t, pars) that computes temporal fluctuations}
}
\value{
none
}
\description{
Make parameters for trace aquatic mosquito model
}
