# specialized methods for the human SIP model

#' @title Derivatives for human population
#' @description Implements [dXdt] for the SIP model.
#' @inheritParams dXdt
#' @return a [numeric] vector
#' @export
dXdt.SIP <- function(t, y, pars, i){

  foi <- pars$FoI[[i]]

  with(list_Xvars(y, pars, i),{
    Hpar <- pars$Hpar[[i]]
    with(pars$Xpar[[i]], {

      dS <- Births(t, H, Hpar) - foi*S -xi*S + r*I + eta*P + dHdt(t, S, Hpar)
      dI <- (1-rho)*foi*S - (r+xi)*I + dHdt(t, I, Hpar)
      dP <- rho*foi*S + xi*(S+I) - eta*P + dHdt(t, P, Hpar)

      return(c(dS, dI, dP))
    })
  })
}

#' @title Setup Xpar.SIP
#' @description Implements [make_Xpar] for the SIP model
#' @inheritParams make_Xpar
#' @return a [list] vector
#' @export
make_Xpar.SIP = function(Xname, pars, i, Xopts=list()){
  pars$Xpar[[i]] = create_Xpar_SIP(pars$nStrata[i], Xopts)
  return(pars)
}


#' @title Make parameters for SIP human model, with defaults
#' @param nStrata the number of population strata
#' @param Xopts a [list] that could overwrite defaults
#' @param b transmission probability (efficiency) from mosquito to human
#' @param c transmission probability (efficiency) from human to mosquito
#' @param r recovery rate
#' @param rho probability of successful treatment upon infection
#' @param eta prophylaxis waning rate
#' @param xi background treatment rate
#' @return a [list]
#' @export
create_Xpar_SIP = function(nStrata, Xopts=list(),
                             b=0.55, r=1/180, c=0.15,
                             rho=.1, eta=1/25, xi=1/365){
  with(Xopts,{
    Xpar = list()
    class(Xpar) <- c("SIP")

    Xpar$b = checkIt(b, nStrata)
    Xpar$c = checkIt(c, nStrata)
    Xpar$r = checkIt(r, nStrata)
    Xpar$rho = checkIt(rho, nStrata)
    Xpar$eta = checkIt(eta, nStrata)
    Xpar$xi = checkIt(xi, nStrata)

    return(Xpar)
  })}

#' @title Derivatives for human population
#' @description Implements [Update_Xt] for the SIP model.
#' @inheritParams Update_Xt
#' @return a [numeric] vector
#' @export
Update_Xt.SIP <- function(t, y, pars, i){

  attack <- pars$AR[[i]]

  with(list_Xvars(y, pars, i),{
    with(pars$Xpar[[i]], {

      St <- (1-attack)*(S+r*I) + eta*P - xi*S
      It <- (1-r)*I + attack*(1-rho)*(S+r*I) - xi*I
      Pt <- xi*(S+I) + attack*rho*(S+r*I) + (1-eta)*P

      St <- dHdt(t, St, pars$Hpar[[i]]) + Births(t, H, pars$Hpar[[i]])
      It <- dHdt(t, It, pars$Hpar[[i]])
      Pt <- dHdt(t, Pt, pars$Hpar[[i]])

      return(c(St, It, Pt))
    })
  })
}

#' @title Compute the steady states for the  dts SIP model as a function of the daily EIR
#' @description Compute the steady state of the  dts SIP model as a function of the daily eir.
#' @inheritParams dts_steady_state_X
#' @return the steady states as a named vector
#' @export
dts_steady_state_X.SIP = function(ar, H, Xpar){with(Xpar,{
  Iteq =(ar*H*eta*(1-rho))/((eta+xi)*(ar*(1-r)+(r+xi)+ar*(eta*(r-1)+r+xi)))
  Pteq = (H*(xi*(ar+r*(1-ar)+xi)+ar*(1+xi)*rho))/((eta+xi)*(ar*(1-r)+(r+xi)+ar*(eta*(r-1)+r+xi)))
  Steq = H-Iteq-Pteq
  return(c(S=Steq, I=Iteq,P =Pteq))
})}

#' @title Size of effective infectious human population
#' @description Implements [F_X] for the SIP model.
#' @inheritParams F_X
#' @return a [numeric] vector of length `nStrata`
#' @export
F_X.SIP <- function(y, pars, i) {
  I = y[pars$ix$X[[i]]$I_ix]
  X = with(pars$Xpar[[i]], c*I)
  return(X)
}

#' @title Size of effective infectious human population
#' @description Implements [F_X] for the SIP model.
#' @inheritParams F_X
#' @return a [numeric] vector of length `nStrata`
#' @export
F_H.SIP <- function(y, pars, i){
  with(list_Xvars(y, pars, i), return(H))
}


#' @title Infection blocking pre-erythrocytic immunity
#' @description Implements [F_b] for the SIP model.
#' @inheritParams F_b
#' @return a [numeric] vector of length `nStrata`
#' @export
F_b.SIP <- function(y, pars,i) {
  with(pars$Xpar[[i]], b)
}



#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$Xpar`
#' @inheritParams list_Xvars
#' @return a [list]
#' @export
list_Xvars.SIP <- function(y, pars, i) {
  with(pars$ix$X[[i]],{
    S = y[S_ix]
    I = y[I_ix]
    P = y[P_ix]
    H = S+I+P
    return(list(S=S,I=I,P=P,H=H))})
}


#' @title Compute the HTC for the SIP model
#' @description Implements [HTC] for the SIP model with demography.
#' @inheritParams HTC
#' @return a [numeric] vector
#' @export
HTC.SIP <- function(pars, i) {
  with(pars$Xpar[[i]],
       return((1-rho)*b/(r+xi)*xi/(eta+xi))
  )
}


#' @title Setup Xinits.SIP
#' @description Implements [make_Xinits] for the SIP model
#' @inheritParams make_Xinits
#' @return a [list] vector
#' @export
make_Xinits.SIP = function(pars, H, i, Xopts=list()){
  pars$Xinits[[i]] = create_Xinits_SIP(pars$nStrata[i], H, Xopts)
  return(pars)
}

#' @title Make initial values for the SIP human model, with defaults
#' @param nStrata the number of population strata
#' @param H the initial human population density
#' @param Xopts a [list] that could overwrite defaults
#' @param I the initial values of the parameter I
#' @param P the initial values of the parameter P
#' @return a [list]
#' @export
create_Xinits_SIP = function(nStrata, H, Xopts = list(),
                           I=1, P=0){with(Xopts,{
  S = checkIt(H-I-P, nStrata)
  I = checkIt(I, nStrata)
  P = checkIt(P, nStrata)
  return(list(S=S, I=I, P=P))
})}

#' @title Parse the output of deSolve and return variables for the SIP model
#' @description Implements [parse_outputs_X] for the SIP model
#' @inheritParams parse_outputs_X
#' @return none
#' @export
parse_outputs_X.SIP <- function(outputs, pars, i) {
  time = outputs[,1]
  with(pars$ix$X[[i]],{
    S = outputs[,S_ix+1]
    I = outputs[,I_ix+1]
    P = outputs[,P_ix+1]
    H = S+I+P
    return(list(time=time,S=S,I=I,P=P,H=H))
})}

#' @title Add indices for human population to parameter list
#' @description Implements [make_X_indices] for the SIP model.
#' @inheritParams make_X_indices
#' @return none
#' @importFrom utils tail
#' @export
make_X_indices.SIP <- function(pars, i) {with(pars,{

  S_ix <- seq(from = max_ix+1, length.out=nStrata[i])
  max_ix <- tail(S_ix, 1)

  I_ix <- seq(from = max_ix+1, length.out=nStrata[i])
  max_ix <- tail(I_ix, 1)

  P_ix <- seq(from = max_ix+1, length.out=nStrata[i])
  max_ix <- tail(P_ix, 1)

  pars$max_ix = max_ix
  pars$ix$X[[i]] = list(S_ix=S_ix, I_ix=I_ix, P_ix=P_ix)
  return(pars)
})}


#' @title Update inits for the SIP human model from a vector of states
#' @inheritParams update_Xinits
#' @return none
#' @export
update_Xinits.SIP <- function(pars, y0, i) {
  with(list_Xvars(y0, pars, i),{
  pars$Xinits[[i]] = create_Xinits_SIP(pars$nStrata[i], pars$H0, list(), I=I, P=P)
  return(pars)
})}


#' @title Return initial values as a vector
#' @description This method dispatches on the type of `pars$Xpar`.
#' @inheritParams get_Xinits
#' @return a named [vector]
#' @export
get_Xinits.SIP <- function(pars, i){
  pars$Xinits[[i]]
}


#' @title Compute the "true" prevalence of infection / parasite rate
#' @description Implements [F_pr] for the SIP model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr.SIP <- function(vars, Xpar) {
  pr = with(vars, I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by light microscopy
#' @description Implements [F_pr] for the SIP model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_lm.SIP <- function(vars, Xpar) {
  pr = with(vars, I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by RDT
#' @description Implements [F_pr] for the SIP model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_rdt.SIP <- function(vars, Xpar) {
  pr = with(vars, I/H)
  return(pr)
}

#' @title Compute the prevalence of infection by pcr
#' @description Implements [F_pr] for the SIP model.
#' @inheritParams F_pr
#' @return a [numeric] vector of length `nStrata`
#' @export
F_pr_by_pcr.SIP <- function(vars, Xpar) {
  pr = with(vars, I/H)
  return(pr)
}

#' Plot the density of infected individuals for the SIP model
#'
#' @inheritParams xds_plot_X
#' @export
xds_plot_X.SIP = function(pars, i=1, clrs=c("darkblue", "darkred", "darkgreen"), llty=1, stable=FALSE, add_axes=TRUE){
  vars=with(pars$outputs,if(stable==TRUE){stable_orbits}else{orbits})

  if(add_axes==TRUE)
    with(vars$XH[[i]],
         plot(time, 0*time, type = "n", ylim = c(0, max(H)),
              ylab = "# Infected", xlab = "Time"))

  add_lines_X_SIP(vars$XH[[i]], pars, clrs, llty)
}


#' Add lines for the density of infected individuals for the SIP model
#'
#' @param XH a list with the outputs of parse_outputs_X.SIP
#' @param pars a list that defines an `ramp.xde` model (*e.g.*,  generated by `xde_setup()`)
#' @param clrs a vector of colors
#' @param llty an integer (or integers) to set the `lty` for plotting
#'
#' @export
add_lines_X_SIP = function(XH, pars, clrs=c("darkblue", "darkred", "darkgreen"), llty=1){
  with(XH,{
    if(pars$nStrata[1] ==1) {
      lines(time, S, col=clrs[1], lty = llty[1])
      lines(time, I, col=clrs[2], lty = llty[1])
      lines(time, P, col=clrs[3], lty = llty[1])
    }
    if(pars$nStrata[1]>1){
      if (length(clrs)==1) clrs=matrix(clrs, 3, pars$nStrata[i])
      if (length(llty)==1) llty=rep(llty, pars$nStrata[i])
      for(i in 1:pars$nStrata[1]){
        lines(time, S[,i], col=clrs[1,i], lty = llty[i])
        lines(time, I[,i], col=clrs[2,i], lty = llty[i])
        lines(time, P[,i], col=clrs[3,i], lty = llty[i])
      }
    }
  })}

#' @title Compute the steady states for the SIP model as a function of the daily foi
#' @description Compute the steady state of the SIP model as a function of the daily eir.
#' @inheritParams xde_steady_state_X
#' @return the steady states as a named vector
#' @export
xde_steady_state_X.SIP = function(foi, H, Xpar){with(Xpar,{
  Ieq = (foi*H*eta*(1-rho))/((foi+r+xi)*(eta+xi) +foi*(r-eta)*rho)
  Peq  = (H*xi*(foi+r+xi) + (foi*H*r*rho))/((foi+r+xi)*(eta+xi) +foi*(r-eta)*rho)
  Seq = H -Ieq - Peq
  return(list(S=as.vector(Seq), I=as.vector(Ieq), P = as.vector(Peq)))
})}

