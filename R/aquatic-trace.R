# specialized methods for the aquatic mosquito trace model

#' @title Reset aquatic parameters to baseline
#' @description Implements [LBionomics] for the RM model
#' @inheritParams LBionomics
#' @return a named [list]
#' @export
LBionomics.trace <- function(t, y, pars, s) {
  return(pars)
}

#' @title Number of newly emerging adults from each larval habitat
#' @description Implements [F_alpha] for the trace (forced emergence) model.
#' @inheritParams F_alpha
#' @return a [numeric] vector of length `nHabitats`
#' @export
F_alpha.trace <- function(t, y, pars, s) {
  with(pars$Lpar[[s]], scale*Lt(t))
}

#' @title Derivatives for aquatic stage mosquitoes
#' @description Implements [dLdt] for the trace (forced emergence) model.
#' @inheritParams dLdt
#' @return an empty [list]
#' @export
dLdt.trace <- function(t, y, pars, s) {
  return(numeric(0))
}

#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$Lpar[[s]]`
#' @inheritParams list_Lvars
#' @return an empty [list]
#' @export
list_Lvars.trace <- function(y, pars, s){
  return(list())
}

#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$Lpar[[s]]`
#' @inheritParams put_Lvars
#' @return a [list]
#' @export
put_Lvars.trace <- function(Lvars, y, pars, s){
  return(y)
}

#' @title Derivatives for aquatic stage mosquitoes
#' @description Implements [DT_Lt] for the trace (forced emergence) model.
#' @inheritParams DT_Lt
#' @return a [numeric] vector
#' @export
DT_Lt.trace <- function(t, y, pars, s) {
  return(list())
}

#' @title xde_setup Lpar for the trace model
#' @description Implements [xde_setup_Lpar] for the trace model
#' @inheritParams xde_setup_Lpar
#' @return a [list] vector
#' @export
xde_setup_Lpar.trace = function(Lname, pars, s, Lopts=list()){
  pars$Lpar[[s]] = make_Lpar_trace(pars$nHabitats, Lopts)
  return(pars)
}

#' @title dts_setup Lpar for the trace model
#' @description Implements [dts_setup_Lpar] for the trace model
#' @inheritParams dts_setup_Lpar
#' @return a [list] vector
#' @export
dts_setup_Lpar.trace = function(Lname, pars, s, Lopts=list()){
  pars$Lpar[[s]] = make_Lpar_trace(pars$nHabitats, Lopts)
  return(pars)
}

#' @title Setup the trace model
#' @description Implements [setup_Linits] for the trace model
#' @inheritParams setup_Linits
#' @return a [list]
#' @export
setup_Linits.trace = function(pars, s, Lopts=list()){
  pars$Linits[[s]] = list()
  return(pars)
}

#' @title Make parameters for trace aquatic mosquito model
#' @param nHabitats the number of habitats in the model
#' @param Lopts a [list] that overwrites default values
#' @param Lambda vector of mean emergence rates from each aquatic habitat
#' @param Lt is a [function] of the form Lt(t,pars) that computes temporal fluctuations
#' @return none
#' @export
make_Lpar_trace = function(nHabitats, Lopts=list(), Lambda=1000, Lt = NULL){
  with(Lopts,{
    Lpar = list()
    class(Lpar) <- "trace"
    Lpar$scale = checkIt(Lambda, nHabitats)
    if(is.null(Lt)) Lt = function(t){1}
    Lpar$Lt = Lt
    return(Lpar)
})}

#' @title Add indices for aquatic stage mosquitoes to parameter list
#' @description Implements [make_indices_L] for trace (forced emergence) model.
#' @inheritParams make_indices_L
#' @return none
#' @export
make_indices_L.trace <- function(pars, s) {
  return(pars)
}


#' @title Update inits for the basic aquatic mosquito competition model
#' @inheritParams update_inits_L
#' @return none
#' @export
update_inits_L.trace<- function(pars, y0, s) {
  return(pars)
}

#' @title Make parameters for trace aquatic mosquito model
#' @param pars a [list]
#' @param Lambda vector of mean emergence rates from each aquatic habitat
#' @param Lt is a [function] of the form Lt(t,pars) that computes temporal fluctuations
#' @return none
#' @export
make_parameters_L_trace <- function(pars, Lambda, Lt=NULL) {
  stopifnot(is.numeric(Lambda))
  Lpar <- list()
  class(Lpar) <- 'trace'
  Lpar$scale = checkIt(Lambda, pars$nHabitats)
  if(is.null(Lt)) Lt = function(t){return(1)}
  Lpar$Lt = Lt
  pars$Lpar[[1]] <- Lpar
  return(pars)
}

#' @title Make parameters for trace aquatic mosquito model
#' @param pars a [list]
#' @param L0 is set to NULL for the trace model
#' @return none
#' @export
make_inits_L_trace<- function(pars, L0=NULL) {
  pars$Linits = numeric(0)
  return(pars)
}

#' @title Parse the variable names for the trace model
#' @description Implements [parse_outputs_L] for the trace model.
#' @inheritParams parse_outputs_L
#' @return [list]
#' @export
parse_outputs_L.trace <- function(outputs, pars, s) {
  return(NULL)
}

#' @title Return initial values as a vector
#' @description Implements [get_inits_L] for the GeRM model.
#' @inheritParams get_inits_L
#' @return none
#' @export
get_inits_L.trace <- function(pars, s){
  numeric(0)
}

