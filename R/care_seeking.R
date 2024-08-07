# Methods to set up variables describing exogenous forcing by care seeking

#' @title Set the values of exogenous variables describing care seeking
#' @description This method dispatches on the type of `pars$CARE_SEEKING`.
#' @param t current simulation time
#' @param y state variables
#' @param pars a [list]
#' @return [list]
#' @export
CareSeeking <- function(t, y, pars) {
  UseMethod("CareSeeking", pars$CARE_SEEKING)
}

#' @title Set the values of exogenous variables describing care seeking
#' @description Implements [CareSeeking] for the no_behavior model of care seeking (do nothing)
#' @inheritParams CareSeeking
#' @return [list]
#' @export
CareSeeking.no_behavior <- function(t, y, pars) {
  return(pars)
}

#' @title Make parameters for the no_behavior model for care seeking (do nothing)
#' @param pars a [list]
#' @return [list]
#' @export
setup_care_seeking_no_behavior <- function(pars) {
  CARE_SEEKING <- list()
  class(CARE_SEEKING) <- 'no_behavior'
  pars$CARE_SEEKING <- CARE_SEEKING
  return(pars)
}

