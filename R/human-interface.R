# generic methods for human component

#' @title Size of effective infectious human population
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param t current simulation time
#' @param y state vector
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector of length `nStrata`
#' @export
F_X <- function(t, y, pars, i) {
  UseMethod("F_X", pars$Xpar[[i]])
}

#' @title Size of human population denominators
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param t current simulation time
#' @param y state vector
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector of length `nStrata`
#' @export
F_H <- function(t, y, pars, i) {
  UseMethod("F_H", pars$Xpar[[i]])
}



#' @title Infection blocking pre-erythrocytic immunity
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param y state vector
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector of length `nStrata`
#' @export
F_b <- function(y, pars, i) {
  UseMethod("F_b", pars$Xpar[[i]])
}

#' @title Derivatives for human population
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param t current simulation time
#' @param y state vector
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector
#' @export
dXdt <- function(t, y, pars, i) {
  UseMethod("dXdt", pars$Xpar[[i]])
}

#' @title Update X states for a discrete time system
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param t current simulation time
#' @param y state vector
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector
#' @export
DT_Xt <- function(t, y, pars, i) {
  UseMethod("DT_Xt", pars$Xpar[[i]])
}


#' @title A function to set up Xpar
#' @description This method dispatches on `Xname`.
#' @param Xname a [character] string
#' @param pars a [list]
#' @param i the host species index
#' @param Xopts a [list]
#' @return a [list]
#' @export
xde_setup_Xpar = function(Xname, pars, i, Xopts=list()){
  class(Xname) <- Xname
  UseMethod("xde_setup_Xpar", Xname)
}

#' @title A function to set up Xpar
#' @description This method dispatches on `Xname`.
#' @param Xname a [character] string
#' @param pars a [list]
#' @param i the host species index
#' @param Xopts a [list]
#' @return a [list]
#' @export
dts_setup_Xpar = function(Xname, pars, i, Xopts=list()){
  class(Xname) <- Xname
  UseMethod("dts_setup_Xpar", Xname)
}

#' @title A function to set up Xpar
#' @description This method dispatches on `pars$Xpar[[i]]`.
#' @param pars a [list]
#' @param i the host species index
#' @param Xopts a [list]
#' @return a [list]
#' @export
setup_Xinits = function(pars, i, Xopts=list()){
  UseMethod("setup_Xinits", pars$Xpar[[i]])
}

#' @title Add indices for human population to parameter list
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param pars a [list]
#' @param i the host species index
#' @return a [list]
#' @export
make_indices_X <- function(pars, i) {
  UseMethod("make_indices_X", pars$Xpar[[i]])
}

#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$Xpar[[s]]`.
#' @param y the variables
#' @param pars a [list]
#' @param i the host species index
#' @return a [list]
#' @export
list_Xvars <- function(y, pars, i) {
  UseMethod("list_Xvars", pars$Xpar[[i]])
}

#' @title Put Xvars in place of the X variables in y
#' @description This method dispatches on the type of `pars$Xpar[[s]]`.
#' @param Xvars the X variables to insert into y
#' @param y the variables
#' @param pars a [list]
#' @param i the host species index
#' @return a [list]
#' @export
put_Xvars <- function(Xvars, y, pars, i) {
  UseMethod("put_Xvars", pars$Xpar[[i]])
}

#' @title Parse the output of deSolve and return the variables by name in a list
#' @description This method dispatches on the type of `pars$Xpar[[i]]`. Adds the variables
#' from the X model to a list and returns it
#' @param outputs a [matrix] of outputs from deSolve
#' @param pars a [list] that defines a model
#' @param i the host species index
#' @export
parse_outputs_X <- function(outputs, pars, i) {
  UseMethod("parse_outputs_X", pars$Xpar[[i]])
}

#' @title Return initial values as a vector
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param pars a [list]
#' @param i the host species index
#' @return none
#' @export
get_inits_X <- function(pars, i) {
  UseMethod("get_inits_X", pars$Xpar[[i]])
}

#' @title Set the initial values from a vector of states
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param pars a [list]
#' @param y0 a vector of initial values
#' @param i the host species index
#' @return none
#' @export
update_inits_X <- function(pars, y0, i) {
  UseMethod("update_inits_X", pars$Xpar[[i]])
}


#' @title Compute the "true" prevalence of infection / parasite rate
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param varslist a parsed list of outputs with variables attached by name
#' @param pars a list
#' @param i the host species index
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr <- function(varslist, pars, i) {
  UseMethod("F_pr", pars$Xpar[[i]])
}

#' @title Compute the prevalence of infection by light microscopy
#' @description This method dispatches on the type of `pars$Xpar[[i]]`
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_lm <- function(varslist, pars, i) {
  UseMethod("F_pr", pars$Xpar[[i]])
}

#' @title Compute the prevalence of infection by RDT
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_rdt <- function(varslist, pars, i) {
  UseMethod("F_pr", pars$Xpar[[i]])
}

#' @title Compute the prevalence of infection by PCR
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_pcr <- function(varslist, pars, i) {
  UseMethod("F_pr", pars$Xpar[[i]])
}


#' Basic plotting for epidemiological models
#'
#' @param pars a list that defines an `ramp.xde` model (*e.g.*,  generated by `xde_setup()`)
#' @param i the host species index
#' @param clrs a vector of colors
#' @param llty an integer (or integers) to set the `lty` for plotting
#' @param stable a logical: set to FALSE for `orbits` and TRUE for `stable_orbits`
#' @param add_axes a logical: plot axes only if TRUE
#'
#' @export
xds_plot_X = function(pars, i=1, clrs="black", llty=1, stable=FALSE, add_axes=TRUE){
  UseMethod("xds_plot_X", pars$Xpar[[i]])
}

#' @title Compute the human transmitting capacity
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param pars a [list]
#' @param i the host species index
#' @return none
#' @export
HTC <- function(pars, i) {
  UseMethod("get_inits_X", pars$Xpar[[i]])
}

#' @title Compute the steady states as a function of the daily EIR
#' @description This method dispatches on the type of `pars$Xpar[[i]]`.
#' @param eir the daily EIR
#' @param H host density
#' @param pars a list that defines an `ramp.xde` model (*e.g.*,  generated by `xde_setup()`)
#' @param i the host species index
#' @return none
#' @export
xde_steady_state_X = function(eir, H, pars, i){
  UseMethod("xde_steady_state_X", pars$Xpar[[i]])
}
