% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xds-object.R, R/xds-template.R
\name{make_xds_template}
\alias{make_xds_template}
\title{Make an \strong{\code{xds}} template}
\usage{
make_xds_template(
  xds = "xde",
  frame = "full",
  dlay = "ode",
  nPatches = 1,
  membership = 1,
  residence = 1
)

make_xds_template(
  xds = "xde",
  frame = "full",
  dlay = "ode",
  nPatches = 1,
  membership = 1,
  residence = 1
)
}
\arguments{
\item{xds}{is used to dispatch various functions to set up and solve systems of differential equations. "xde" for ordinary or delay differential equations; "dts" for "discrete time systems"}

\item{frame}{model component subset}

\item{dlay}{is "ode"/"dde" for ordinary/delay differential equations}

\item{nPatches}{is the number of patches}

\item{membership}{is the habitat membership vector}

\item{residence}{is the strata residence vector}
}
\value{
an \code{xds} object

an \code{xds} object
}
\description{
Creates and returns structured template for an \strong{\code{xds}} object: all
the elements of an \strong{\code{xds}} object are configured with generic features and default
values.

Creates and returns structured template, called an
\strong{\code{xds}} object, with generic features and options that can be configured
to set up and solve systems of differential equations using \strong{\code{ramp.xds}}
}
\details{
This function sets up the basic structures required
to configure and run a basic model. The returned object is a list
with various required elements attached and configured, but without
specifying the dynamical components or any advanced features.

First, the function sets up some short text strings (assigned to the same \code{S3} class)
to dispatch various \strong{cases} of of various \code{S3} functions:
\itemize{
\item \strong{\code{xds}} is either "xde" for differential equations or "dts" for difference equations;
\item \strong{\code{frame}} is one of several cases:
\itemize{
\item "full" includes all three dynamical components: a human/host dynamical component, \eqn{\cal XH}; and adult mosquito dynamical component, \eqn{\cal MYZ}; and an aquatic mosquito dynamical component, \eqn{\cal L}.
in some form (possible the trace case) (see \code{\link[=xds_setup]{xds_setup()}})
\item "mozy" is for mosquito ecology models (see \code{\link[=xds_setup_mosy]{xds_setup_mosy()}}), including models without pathogen infection dynamics in mosquitoes
\item "aquatic" is for aquatic mosquito ecology models (see \code{\link[=xds_setup_mosy]{xds_setup_mosy()}}), forced by a function describing egg laying
\item "human" is for human/host infection dynamics(see \code{\link[=xds_setup_human]{xds_setup_human()}}), forced by the infective density of adult mosquitoes, \eqn{fqZ}
\item "cohort" is for human/host cohort infection dynamics (see \code{\link[=xds_setup_cohort]{xds_setup_cohort()}}), forced by a function \code{F_eir}
}
\item \strong{\code{dlay}} is either "ode" or "dde" and it only affects dispatching for differential equations
\item \strong{\code{forcing}} is set to "static"
\item \strong{\code{compute}} dispatches various cases of \code{\link[=compute_terms]{compute_terms()}} linked to \code{frame}
}

Second, the function sets the values of the \strong{structural parameters}:
\itemize{
\item \strong{\code{nVectors}} or \eqn{n_s}, the number of vector species is set to 1;
\item \strong{\code{nHosts}} or \eqn{n_i}, the number of host species is set to 1;
\item \strong{\code{nPatches}} or \eqn{n_p} is the number of patches
\item \strong{\code{nHabitats}} or \eqn{n_q}, the number of aquatic habitats, is set to \code{length(membership)}
\item \strong{\code{nStrata}} or \eqn{n_h}, the number of human/ host population strata, is set to \code{length(HPop)}
}

Next, the function sets up egg laying, blood feeding, and transmission:
\itemize{
\item \strong{Egg Laying} calls \code{\link[=create_habitat_matrix]{create_habitat_matrix()}}, then \code{\link[=setup_EGG_LAYING]{setup_EGG_LAYING()}}
\item \strong{Blood Feeding} calls \code{\link[=create_residence_matrix]{create_residence_matrix()}}, then \code{\link[=setup_BLOOD_FEEDING]{setup_BLOOD_FEEDING()}}
\item \strong{Transmission}  calls \code{\link[=setup_TRANSMISSION]{setup_TRANSMISSION()}} and \code{\link[=setup_visitors_static]{setup_visitors_static()}} sets up a static
model for the availability of visitors; by default, there are no visitors
}

Finally, the function sets up a few other miscellaneous options:
\itemize{
\item \link{Exposure} is called \emph{after} \link{Transmission} to compute environmentally heterogeneous exposure
and malaria importation through travel:
\itemize{
\item \code{\link[=setup_exposure_pois]{setup_exposure_pois()}} sets up a Poisson model for environmental heterogeneity
\item \code{\link[=setup_travel_static]{setup_travel_static()}} sets up a model with no exposure through travel
}
}

This function sets up the basic structures required
to configure and run a basic model. The returned object is a list
with various required elements attached and configured, but without
specifying the dynamical components or any advanced features.

First, the function sets up some short text strings (assigned to the same \code{S3} class)
to dispatch various \strong{cases} of of various \code{S3} functions:
\itemize{
\item \strong{\code{xds}} is either "xde" for differential equations or "dts" for difference equations;
\item \strong{\code{frame}} is one of several cases:
\itemize{
\item "full" includes all three dynamical components: a human/host dynamical component, \eqn{\cal XH}; and adult mosquito dynamical component, \eqn{\cal MYZ}; and an aquatic mosquito dynamical component, \eqn{\cal L}.
in some form (possible the trace case) (see \code{\link[=xds_setup]{xds_setup()}})
\item "mozy" is for mosquito ecology models (see \code{\link[=xds_setup_mosy]{xds_setup_mosy()}}), including models without pathogen infection dynamics in mosquitoes
\item "aquatic" is for aquatic mosquito ecology models (see \code{\link[=xds_setup_mosy]{xds_setup_mosy()}}), forced by a function describing egg laying
\item "human" is for human/host infection dynamics(see \code{\link[=xds_setup_human]{xds_setup_human()}}), forced by the infective density of adult mosquitoes, \eqn{fqZ}
\item "cohort" is for human/host cohort infection dynamics (see \code{\link[=xds_setup_cohort]{xds_setup_cohort()}}), forced by a function \code{F_eir}
}
\item \strong{\code{dlay}} is either "ode" or "dde" and it only affects dispatching for differential equations
\item \strong{\code{forcing}} is set to "static"
\item \strong{\code{compute}} dispatches various cases of \code{\link[=compute_terms]{compute_terms()}} linked to \code{frame}
}

Second, the function sets the values of the \strong{structural parameters}:
\itemize{
\item \strong{\code{nVectors}} or \eqn{n_s}, the number of vector species is set to 1;
\item \strong{\code{nHosts}} or \eqn{n_i}, the number of host species is set to 1;
\item \strong{\code{nPatches}} or \eqn{n_p} is the number of patches
\item \strong{\code{nHabitats}} or \eqn{n_q}, the number of aquatic habitats, is set to \code{length(membership)}
\item \strong{\code{nStrata}} or \eqn{n_h}, the number of human/ host population strata, is set to \code{length(HPop)}
}

Next, the function sets up egg laying, blood feeding, and transmission:
\itemize{
\item \strong{Egg Laying} calls \code{\link[=create_habitat_matrix]{create_habitat_matrix()}}, then \code{\link[=setup_EGG_LAYING]{setup_EGG_LAYING()}}
\item \strong{Blood Feeding} calls \code{\link[=create_residence_matrix]{create_residence_matrix()}}, then \code{\link[=setup_BLOOD_FEEDING]{setup_BLOOD_FEEDING()}}
\item \strong{Transmission}  calls \code{\link[=setup_TRANSMISSION]{setup_TRANSMISSION()}} and \code{\link[=setup_visitors_static]{setup_visitors_static()}} sets up a static
model for the availability of visitors; by default, there are no visitors
}

Finally, the function sets up a few other miscellaneous options:
\itemize{
\item \link{Exposure} is called \emph{after} \link{Transmission} to compute environmentally heterogeneous exposure
and malaria importation through travel:
\itemize{
\item \code{\link[=setup_exposure_pois]{setup_exposure_pois()}} sets up a Poisson model for environmental heterogeneity
\item \code{\link[=setup_travel_static]{setup_travel_static()}} sets up a model with no exposure through travel
}
}
}
\seealso{
Related: \code{\link[=xds_setup]{xds_setup()}}. Demonstrated in the vignette: \href{https://dd-harp.github.io/ramp.xds/articles/ex_534.html}{5-3-4 Example}

Related: \code{\link[=xds_setup]{xds_setup()}}. Illustrated in a vignette: \href{https://dd-harp.github.io/ramp.xds/articles/ex_534.html}{5-3-4 Example}
}
