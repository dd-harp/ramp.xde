% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dts_setup.R
\name{dts_setup_human}
\alias{dts_setup_human}
\title{Set up a model for dts_diffeqn_human}
\usage{
dts_setup_human(
  modelName = "unnamed",
  Xname = "SIS",
  Xday = 1,
  HPop = 1000,
  MYZopts = list(),
  Xopts = list(),
  BFopts = list(),
  residence = 1,
  searchB = 1,
  F_circadian = NULL,
  TimeSpent = "athome",
  TimeSpentOpts = list()
)
}
\arguments{
\item{modelName}{is a name for the model (arbitrary)}

\item{Xname}{is a character string defining a X model}

\item{Xday}{is an integer: positive > 1 for lumping; negative < -1 for splitting}

\item{HPop}{is the number of humans in each patch}

\item{MYZopts}{a list to configure the MYZ model}

\item{Xopts}{a list to configure the X model}

\item{BFopts}{a list to configure the blood feeding model}

\item{residence}{is a vector that describes the patch where each human stratum lives}

\item{searchB}{is a vector of search weights for blood feeding}

\item{F_circadian}{is a function describing mosquito daily activity}

\item{TimeSpent}{is either a TimeSpent matrix or a string to call a function that sets it up}

\item{TimeSpentOpts}{are the options to setup TimeSpent}
}
\value{
a \link{list}
}
\description{
Set up a model for dts_diffeqn_human
}
