# The SIS

#' @title Derivatives for the SIS model for human / vertebrate host infections
#' @description Implements [dXdt] for the SIS model
#' @inheritParams dXdt
#' @return a [numeric] vector
#' @export
dXdt.SIS <- function(t, y, pars, i) {

  foi <- pars$FoI[[i]]
  Hpar <- pars$Hpar[[i]]
  with(list_Xvars(y, pars, i),{
    H <- F_H(t, y, pars, i)
    with(pars$Xpar[[i]], {
      dS <- Births(t, H, Hpar) - foi*S + r*I + dHdt(t, S, Hpar)
      dI <- foi*S - r*I + dHdt(t, I, Hpar)
      return(c(dS, dI))
    })
  })
}

#' @title DTS updating for the SIS model for human / vertebrate host infections
#' @description Implements [DT_Xt] for the SIS model
#' @inheritParams DT_Xt
#' @return a [numeric] vector
#' @export
DT_Xt.SIS <- function(t, y, pars, i) {

  ar <- pars$AR[[i]]
  Hpar <- pars$Hpar[[i]]
  with(list_Xvars(y, pars, i),{
    H <- F_H(t, y, pars, i)
    with(pars$Xpar[[i]], {

      St <- (1-ar)*S + (1-nr)*(1-ar)*I + dHdt(t, S, Hpar) + Births(t, H, Hpar)
      It <- nr*I + (1-nr)*ar*I + ar*S + dHdt(t, I, Hpar)

      return(c(S=unname(St), I=unname(It)))
    })
  })
}

#' @title Setup Xpar.SIS
#' @description Implements [xde_setup_Xpar] for the SIS model
#' @inheritParams xde_setup_Xpar
#' @return a [list] vector
#' @export
xde_setup_Xpar.SIS = function(Xname, pars, i, Xopts=list()){
  pars$Xpar[[i]] = xde_make_Xpar_SIS(pars$Hpar[[i]]$nStrata, Xopts)
  return(pars)
}

#' @title Make parameters for SIS xde human model, with defaults
#' @param nStrata is the number of population strata
#' @param Xopts a [list] that could overwrite defaults
#' @param b transmission probability (efficiency) from mosquito to human
#' @param c transmission probability (efficiency) from human to mosquito
#' @param r recovery rate
#' @return a [list]
#' @export
xde_make_Xpar_SIS = function(nStrata, Xopts=list(),
                             b=0.55, r=1/180, c=0.15){
  with(Xopts,{
    Xpar = list()
    class(Xpar) <- "SIS"

    Xpar$b = checkIt(b, nStrata)
    Xpar$c = checkIt(c, nStrata)
    Xpar$r = checkIt(r, nStrata)

    return(Xpar)
  })}



#' @title Setup Xpar for the discrete time SIS model
#' @description Implements [dts_setup_Xpar] for the SIS model
#' @inheritParams dts_setup_Xpar
#' @return a [list] vector
#' @export
dts_setup_Xpar.SIS = function(Xname, pars, i, Xopts=list()){
  pars$Xpar[[i]] = dts_make_Xpar_SIS(pars$Hpar[[i]]$nStrata, pars$Xday, Xopts)
  return(pars)
}

#' @title Make parameters for SIS human model, with defaults
#' @param nStrata is the number of population strata
#' @param Xday the X component runtime time step
#' @param Xopts a [list] that could overwrite defaults
#' @param b transmission probability (efficiency) from mosquito to human
#' @param c transmission probability (efficiency) from human to mosquito
#' @param r recovery rate
#' @return a [list]
#' @export
dts_make_Xpar_SIS = function(nStrata, Xday, Xopts=list(),
                             b=0.55, r=1/180, c=0.15){
  with(Xopts,{
    Xpar = list()
    class(Xpar) <- "SIS"
    Xpar$b = checkIt(b, nStrata)
    Xpar$c = checkIt(c, nStrata)
    Xpar$nr = exp(-checkIt(r, nStrata)*Xday)

    return(Xpar)
  })}




# specialized methods for the human SIS model

#' @title Size of effective infectious human population
#' @description Implements [F_X] for the SIS model.
#' @inheritParams F_X
#' @return a [numeric] vector of length `nStrata`
#' @export
F_X.SIS <- function(t, y, pars, i) {
  I = y[pars$ix$X[[i]]$I_ix]
  X = with(pars$Xpar[[i]], c*I)
  return(X)
}

#' @title Size of effective infectious human population
#' @description Implements [F_H] for the SIS model.
#' @inheritParams F_H
#' @return a [numeric] vector of length `nStrata`
#' @export
F_H.SIS <- function(t, y, pars, i){
  with(list_Xvars(y, pars, i), return(S+I))
}


#' @title Infection blocking pre-erythrocytic immunity
#' @description Implements [F_b] for the SIS model.
#' @inheritParams F_b
#' @return a [numeric] vector of length `nStrata`
#' @export
F_b.SIS <- function(y, pars, i) {
  with(pars$Xpar[[i]], b)
}

#' @title Make initial values for the SIS xde human model, with defaults
#' @param nStrata the number of strata in the model
#' @param Xopts a [list] to overwrite defaults
#' @param H0 the initial human population density
#' @param S0 the initial values of the parameter S
#' @param I0 the initial values of the parameter I
#' @return a [list]
#' @export
make_Xinits_SIS = function(nStrata, Xopts = list(), H0=NULL, S0=NULL, I0=1){with(Xopts,{
  if(is.null(S0)) S0 = H0 - I0
  stopifnot(is.numeric(S0))
  S = checkIt(S0, nStrata)
  I = checkIt(I0, nStrata)
  return(list(S=S, I=I))
})}




#' @title Return the SIS model variables as a list, returned from DT_Xt.SIS
#' @description This method dispatches on the type of `pars$Xpar`
#' @inheritParams put_Xvars
#' @return a [list]
#' @export
put_Xvars.SIS <- function(Xvars, y, pars, i) {
  with(pars$ix$X[[i]],
       with(as.list(Xvars),{
         y[S_ix] = S
         y[I_ix] = I
         return(y)
       }))}

#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$Xpar`
#' @inheritParams list_Xvars
#' @return a [list]
#' @export
list_Xvars.SIS <- function(y, pars, i) {
  with(pars$ix$X[[i]],
       return(list(
         S = y[S_ix],
         I = y[I_ix]
       )
       ))
}

#' @title Setup Xinits.SIS
#' @description Implements [setup_Xinits] for the SIS model
#' @inheritParams setup_Xinits
#' @return a [list] vector
#' @export
setup_Xinits.SIS = function(pars, i, Xopts=list()){
  pars$Xinits[[i]] = with(pars,make_Xinits_SIS(pars$Hpar[[i]]$nStrata, Xopts, H0=Hpar[[i]]$H))
  return(pars)
}

#' @title Add indices for human population to parameter list
#' @description Implements [make_indices_X] for the SIS model.
#' @inheritParams make_indices_X
#' @return none
#' @importFrom utils tail
#' @export
make_indices_X.SIS <- function(pars, i) {with(pars,{

  S_ix <- seq(from = max_ix+1, length.out=Hpar[[i]]$nStrata)
  max_ix <- tail(S_ix, 1)

  I_ix <- seq(from = max_ix+1, length.out=Hpar[[i]]$nStrata)
  max_ix <- tail(I_ix, 1)

  pars$max_ix = max_ix
  pars$ix$X[[i]] = list(S_ix=S_ix, I_ix=I_ix)
  return(pars)
})}

#' @title Return initial values as a vector
#' @description This method dispatches on the type of `pars$Xpar`.
#' @inheritParams get_inits_X
#' @return a [numeric] vector
#' @export
get_inits_X.SIS <- function(pars, i){
  with(pars$Xinits[[i]], return(c(S,I)))
}

#' @title Update inits for the SIS xde human model from a vector of states
#' @inheritParams update_inits_X
#' @return none
#' @export
update_inits_X.SIS <- function(pars, y0, i) {
  with(list_Xvars(y0, pars, i),{
    pars$Xinits[[i]] = make_Xinits_SIS(pars, list(), S0=S, I0=I)
    return(pars)
  })}


#' @title Parse the output of deSolve and return variables for the SIS model
#' @description Implements [parse_outputs_X] for the SIS model
#' @inheritParams parse_outputs_X
#' @return none
#' @export
parse_outputs_X.SIS <- function(outputs, pars, i) {
  time = outputs[,1]
  with(pars$ix$X[[i]],{
    S = outputs[,S_ix+1]
    I = outputs[,I_ix+1]
    H = S+I
    return(list(time=time, S=S, I=I, H=H))
  })}


#' @title Compute the "true" prevalence of infection / parasite rate
#' @description Implements [F_pr] for the SIS model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr.SIS <- function(varslist, pars, i) {
  pr = with(varslist$XH[[i]], I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by light microscopy
#' @description Implements [F_pr] for the SIS model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_lm.SIS <- function(varslist, pars, i) {
  pr = with(varslist$XH[[i]], I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by RDT
#' @description Implements [F_pr] for the SIS model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_rdt.SIS <- function(varslist, pars, i) {
  pr = with(varslist$XH[[i]], I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by PCR
#' @description Implements [F_pr] for the SIS model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_pcr.SIS <- function(varslist, pars, i) {
  pr = with(varslist$XH[[i]], I/H)
  return(pr)
}

#' Plot the density of infected individuals for the SIS model
#'
#' @inheritParams xds_plot_X
#' @export
xds_plot_X.SIS = function(pars, i=1, clrs=c("darkblue","darkred"), llty=1, stable=FALSE, add_axes=TRUE){
  vars=with(pars$outputs,if(stable==TRUE){stable_orbits}else{orbits})

  if(add_axes==TRUE)
    with(vars$XH[[i]],
         plot(time, 0*time, type = "n", ylim = c(0, max(H)),
              ylab = "# Infected", xlab = "Time"))


  add_lines_X_SIS(vars$XH[[i]], pars$Hpar[[i]]$nStrata, clrs, llty)
}

#' Add lines for the density of infected individuals for the SIS model
#'
#' @param XH a list with the outputs of parse_outputs_X_SIS
#' @param nStrata the number of population strata
#' @param clrs a vector of colors
#' @param llty an integer (or integers) to set the `lty` for plotting
#'
#' @export
add_lines_X_SIS = function(XH, nStrata, clrs=c("darkblue","darkred"), llty=1){
  with(XH,{
    if(nStrata==1) {
      lines(time, S, col=clrs[1], lty = llty[1])
      lines(time, I, col=clrs[2], lty = llty[1])
    }
    if(nStrata>1){
      if (length(clrs)==2) clrs=matrix(clrs, 2, nStrata)
      if (length(llty)==1) llty=rep(llty, nStrata)

      for(i in 1:nStrata){
        lines(time, S[,i], col=clrs[1,i], lty = llty[i])
        lines(time, I[,i], col=clrs[2,i], lty = llty[i])
      }
    }
  })}

#' @title Compute the HTC for the SIS model
#' @description Implements [HTC] for the SIS model with demography.
#' @inheritParams HTC
#' @return a [numeric] vector
#' @export
HTC.SIS <- function(pars, i) {
  with(pars$Xpar[[i]],
       return(c/r)
  )
}
#' @title Make parameters for SIS xde human model
#' @param pars a [list]
#' @param b transmission probability (efficiency) from mosquito to human
#' @param c transmission probability (efficiency) from human to mosquito
#' @param r recovery rate
#' @return a [list]
#' @export
make_parameters_X_SIS <- function(pars, b, c, r) {
  stopifnot(is.numeric(b), is.numeric(c), is.numeric(r))
  Xpar <- list()
  class(Xpar) <- c('SIS', 'SISdX')
  Xpar$b <- b
  Xpar$c <- c
  Xpar$r <- r
  pars$Xpar[[1]] <- Xpar
  return(pars)
}


#' @title Make inits for SIS xde human model
#' @param pars a [list]
#' @param S0 size of infected population in each strata
#' @param I0 size of infected population in each strata
#' @return none
#' @export
make_inits_X_SIS <- function(pars, S0, I0) {
  stopifnot(is.numeric(S0))
  stopifnot(is.numeric(I0))
  pars$Xinits[[1]] <- list(S=S0, I=I0)
  return(pars)
}

#' @title Compute the steady states for the SIS model as a function of the daily EIR
#' @description Compute the steady state of the SIS model as a function of the daily eir.
#' @param eir the daily EIR
#' @param H the human population density
#' @param pars a list that defines an `ramp.xde` model (*e.g.*,  generated by `xde_setup()`)
#' @param i the host species index
#' @return the steady states as a named vector
#' @export
xde_steady_state_X.SIS = function(eir, H, pars, i){
  b = pars$Xpar[[i]]$b
  r = pars$Xpar[[i]]$r
  foi = F_foi(eir, b, pars)
  H = pars$Hpar[[i]]$H
  Ieq = foi/(foi+r)*H
  Seq = r/(foi+r)*H
  return(c(S=Seq, I=Ieq))
}

