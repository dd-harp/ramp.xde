% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xds_setup.R
\name{xds_setup_aquatic}
\alias{xds_setup_aquatic}
\title{Set up an \strong{\code{xds}} object to model aquatic mosquito ecology}
\usage{
xds_setup_aquatic(
  xds = "xde",
  dlay = "ode",
  nHabitats = 1,
  Lname = "basicL",
  Lday = 1,
  Lopts = list(),
  MYZopts = list(),
  model_name = "unnamed"
)
}
\arguments{
\item{xds}{is \code{xde}/\code{dts} for differential / difference equations}

\item{dlay}{is either "ode" or "dde"}

\item{nHabitats}{is the number of habitats}

\item{Lname}{is a character string defining a L model}

\item{Lday}{is the run-time time step for L component (in days): integer or 1/integer}

\item{Lopts}{a list to configure the L model}

\item{MYZopts}{a list to configure F_eggs from the trace model}

\item{model_name}{is a name for the model (arbitrary)}
}
\value{
a \link{list}
}
\description{
Set up an \strong{\code{xds}} object to model aquatic mosquito ecology
}
