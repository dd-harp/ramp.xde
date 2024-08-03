% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/blood_feeding.R
\name{compute_B}
\alias{compute_B}
\title{Compute blood feeding availability of all vertebrate hosts}
\usage{
compute_B(W, visitors, other_blood)
}
\arguments{
\item{W}{availability of the parasite's / pathogen' local hosts}

\item{visitors}{availability of \emph{visitors,} or non-resident host populations}

\item{other_blood}{availability of other vertebrate hosts}
}
\value{
host availability, a \link{vector}
}
\description{
Computes availability all vertebrate hosts to blood feeding
mosquitoes
}
\details{
The availability of other vertebrate hosts is a sum of available local
hosts \eqn{W}, and visitors \eqn{W_\delta}, and other available vertebrate hosts, \eqn{O}.
Total availability is a simple sum: \deqn{B = W + W_\delta + O}
}
\references{
{This function implements equation 3
from \insertRef{WuSL2023SpatialDynamics}{ramp.xds} }
}