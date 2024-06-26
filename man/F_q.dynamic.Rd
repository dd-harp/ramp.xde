% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adult-bionomics-resources.R
\name{F_q.dynamic}
\alias{F_q.dynamic}
\title{Static model for human blood fraction}
\usage{
\method{F_q}{dynamic}(t, MYZpar)
}
\arguments{
\item{t}{current simulation time}

\item{MYZpar}{a \link{list}}
}
\value{
a \link{numeric} vector of length \code{nPatches}
}
\description{
Implements \link{F_q} for a static model
}
