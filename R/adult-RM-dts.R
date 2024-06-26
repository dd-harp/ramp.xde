# specialized methods for the adult mosquito RM_dts model


#' @title Derivatives for adult mosquitoes
#' @description Implements [DT_MYZt] for the RM_dts model.
#' @inheritParams DT_MYZt
#' @return a [numeric] vector
#' @export
DT_MYZt.RM_dts <- function(t, y, pars, s) {
  Lambda = pars$Lambda[[s]]*pars$MYZday
  kappa = pars$kappa[[s]]


  with(list_MYZvars(y, pars, s),{
    with(pars$MYZpar[[s]],{

      eip_day_ix = (t %% max_eip) + 1
      eip_yday_ix = ((t-1) %% max_eip) + 1
      Gix = c(t-1:max_eip) %% max_eip + 1
      Gt <- G[Gix]

      Mt <- Lambda + Omega %*% M
      Pt <- f*(M-P) + Omega %*% P
      Ut <- Lambda + Omega %*% (exp(-f*q*kappa)*U)
      Yt <- Omega %*% (Y %*% diag(1-Gt))
      Zt <- Omega %*% (Y%*%Gt)  + (Omega %*% Z)

      Yt[,eip_yday_ix]  <- Yt[,eip_yday_ix] + Yt[,eip_day_ix]
      Yt[,eip_day_ix] <- Omega %*% ((1-exp(-f*q*kappa))*U)

      return(list(M=unname(Mt), P=unname(Pt), U=unname(Ut), Y=unname(as.vector(Yt)), Z=unname(Zt)))
    })
  })
}


#' @title Setup MYZpar for the RM_dts model
#' @description Implements [dts_setup_MYZpar] for the RM_dts model
#' @inheritParams dts_setup_MYZpar
#' @return a [list] vector
#' @export
dts_setup_MYZpar.RM_dts = function(MYZname, pars, s, EIPopts, MYZopts=list(), calK){
  pars$MYZpar[[s]] = dts_make_MYZpar_RM(pars$nPatches, pars$Dday, pars$MYZday, EIPopts, calK, MYZopts)
  return(pars)
}


#' @title Make parameters for RM_dts adult mosquito model
#' @param nPatches is the number of patches, an integer
#' @param Dday is the runtime step for the simulation
#' @param MYZday is the runtime time step for the MYZ model
#' @param EIPopts a string: the class name for the EIP model
#' @param calK a mosquito dispersal matrix of dimensions `nPatches` by `nPatches`
#' @param MYZopts a [list] of values that overwrites the defaults
#' @param g daily mosquito survival
#' @param sigma emigration rate
#' @param mu emigration loss
#' @param f feeding rate
#' @param q human blood fraction
#' @param nu oviposition rate, per mosquito
#' @param eggsPerBatch eggs laid per oviposition
#' @param r_mod a name to dispatch F_p
#' @param sigma_mod a name to dispatch F_sigma
#' @param mu_mod a name to dispatch F_sigma
#' @param f_mod a name to dispatch F_f
#' @param q_mod a name to dispatch F_q
#' @param nu_mod a name to dispatch F_nu
#' @return a [list]
#' @export
dts_make_MYZpar_RM = function(nPatches, Dday, MYZday, EIPopts, calK, MYZopts=list(),
                              g=1/12, sigma=1/8, mu=0,
                              f=0.3, q=0.95, nu=1,
                              eggsPerBatch=60,
                              r_mod = "static", sigma_mod = "static", mu_mod = "static",
                              f_mod = "static", q_mod = "static", nu_mod = "static"
){

  stopifnot(is.matrix(calK))
  stopifnot(dim(calK) == c(nPatches, nPatches))

  with(MYZopts,{
    MYZpar <- list()
    class(MYZpar) <- "RM_dts"

    MYZpar$nPatches <- nPatches
    if(nPatches == 1){
      sigma = 0
      calK = 1
    }

    MYZpar$p       <- exp(-checkIt(g, nPatches)*MYZday*Dday)
    MYZpar$sigma   <- 1-exp(-checkIt(sigma, nPatches)*MYZday*Dday)
    MYZpar$mu      <- 1-exp(-checkIt(mu, nPatches)*MYZday*Dday)
    MYZpar$f       <- checkIt(f, nPatches)*MYZday
    MYZpar$q       <- checkIt(q, nPatches)
    MYZpar$nu      <- 1-exp(-checkIt(nu, nPatches)*MYZday*Dday)
    MYZpar$eggsPerBatch <- eggsPerBatch

    # Store as baseline values
    MYZpar$p0      <- MYZpar$p
    MYZpar$sigma0  <- MYZpar$sigma
    MYZpar$mu0     <- MYZpar$mu
    MYZpar$f0      <- MYZpar$f
    MYZpar$q0      <- MYZpar$q
    MYZpar$nu0     <- MYZpar$nu

    MYZpar$p_par   <- list()
    class(MYZpar$p_par) <- "static"
    MYZpar$f_par   <- list()
    class(MYZpar$f_par) <- "static"
    MYZpar$q_par   <- list()
    class(MYZpar$q_par) <-  "static"
    MYZpar$sigma_par   <- list()
    class(MYZpar$sigma_par) <- "static"
    MYZpar$mu_par   <- list()
    class(MYZpar$mu_par) <- "static"
    MYZpar$nu_par   <- list()
    class(MYZpar$nu_par) <- "static"

    # The EIP model and the eip
    MYZpar <- setup_EIP(EIPopts, MYZpar)
    MYZpar <- EIP(0, MYZpar)

    MYZpar$calK <- calK

    Omega_par <- list()
    class(Omega_par) = "static"
    MYZpar$Omega_par <- Omega_par
    MYZpar$Omega <- with(MYZpar, make_Omega_dts(p, sigma, mu, calK))

    return(MYZpar)
})}


#' @title Reset bloodfeeding and mortality rates to baseline
#' @description Implements [MBionomics] for the RM_dts model
#' @inheritParams MBionomics
#' @return the model as a [list]
#' @export
MBionomics.RM_dts <- function(t, y, pars, s) {
  pars$MYZpar[[s]]       <- EIP(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$f     <- F_f(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$q     <- F_q(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$p     <- F_p(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$sigma <- F_sigma(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$nu    <- F_nu(t, pars$MYZpar[[s]])
  pars$MYZpar[[s]]$Omega <- make_Omega(t, pars, s)
  return(pars)
}

#' @title The net blood feeding rate of the infective mosquito population in a patch
#' @description Implements [F_fqZ] for the RM_dts model.
#' @inheritParams F_fqZ
#' @return a [numeric] vector of length `nPatches`
#' @export
F_fqZ.RM_dts <- function(t, y, pars, s) {
  with(pars$MYZpar[[s]], f*q)*y[pars$ix$MYZ[[s]]$Z_ix]
}

#' @title The net blood feeding rate of the infective mosquito population in a patch
#' @description Implements [F_fqM] for the RM_dts model.
#' @inheritParams F_fqM
#' @return a [numeric] vector of length `nPatches`
#' @export
F_fqM.RM_dts <- function(t, y, pars, s) {
  with(pars$MYZpar[[s]], f*q)*y[pars$ix$MYZ[[s]]$M_ix]
}

#' @title Number of eggs laid by adult mosquitoes
#' @description Implements [F_eggs] for the RM_dts model.
#' @inheritParams F_eggs
#' @return a [numeric] vector of length `nPatches`
#' @export
F_eggs.RM_dts <- function(t, y, pars, s) {
  M <- y[pars$ix$MYZ[[s]]$M_ix]
  with(pars$MYZpar[[s]],{
    return(M*nu*eggsPerBatch)
  })
}


#' @title Setup initial values for the RM_dts model
#' @description Implements [setup_MYZinits] for the RM_dts model
#' @inheritParams setup_MYZinits
#' @return a [list]
#' @export
setup_MYZinits.RM_dts = function(pars, s, MYZopts=list()){
  pars$MYZinits[[s]] = with(pars$MYZpar[[s]], make_MYZinits_RM_dts(nPatches, max_eip, MYZopts))
  return(pars)
}

#' @title Make inits for RM_dts adult mosquito model
#' @param nPatches the number of patches in the model
#' @param max_eip the maximum number of EIP cohorts, an [integer]
#' @param MYZopts a [list] of values that overwrites the defaults
#' @param M0 total mosquito density at each patch
#' @param P0 total parous mosquito density at each patch
#' @param U0 total uninfected mosquito density at each patch
#' @param Y0 infected mosquito density at each patch
#' @param Z0 infectious mosquito density at each patch
#' @return a [list]
#' @export
make_MYZinits_RM_dts = function(nPatches, max_eip, MYZopts = list(),
                                M0=5, P0=1, U0=0, Y0=1, Z0=1){
  with(MYZopts,{
    M = checkIt(M0, nPatches)
    P = checkIt(P0, nPatches)
    U = checkIt(U0, nPatches)
    Y = checkIt(Y0, nPatches*max_eip)
    Z = checkIt(Z0, nPatches)
    return(list(M=M, P=P, U=U, Y=Y, Z=Z))
  })
}


#' @title Add indices for adult mosquitoes to parameter list
#' @description Implements [make_indices_MYZ] for the RM_dts model.
#' @inheritParams make_indices_MYZ
#' @return a [list]
#' @importFrom utils tail
#' @export
make_indices_MYZ.RM_dts <- function(pars, s) {with(pars,{

  M_ix <- seq(from = max_ix+1, length.out=nPatches)
  max_ix <- tail(M_ix, 1)

  P_ix <- seq(from = max_ix+1, length.out=nPatches)
  max_ix <- tail(P_ix, 1)

  U_ix <- seq(from = max_ix+1, length.out=nPatches)
  max_ix <- tail(U_ix, 1)

  Y_ix <- seq(from = max_ix+1, length.out=nPatches*MYZpar[[s]]$max_eip)
  max_ix <- tail(Y_ix, 1)

  Z_ix <- seq(from = max_ix+1, length.out=nPatches)
  max_ix <- tail(Z_ix, 1)

  pars$max_ix = max_ix
  pars$ix$MYZ[[s]] = list(M_ix=M_ix, P_ix=P_ix, U_ix=U_ix, Y_ix=Y_ix, Z_ix=Z_ix)
  return(pars)
})}


#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$MYZpar[[s]]`
#' @inheritParams list_MYZvars
#' @return a [list]
#' @export
list_MYZvars.RM_dts <- function(y, pars, s){
  with(pars$ix$MYZ[[s]],
       return(list(
         M = y[M_ix],
         P = y[P_ix],
         U = y[U_ix],
         Y = matrix(y[Y_ix], pars$nPatches, pars$MYZpar[[s]]$max_eip),
         Z = y[Z_ix]
  )))
}

#' @title Return the variables as a list
#' @description This method dispatches on the type of `pars$MYZpar[[s]]`
#' @inheritParams put_MYZvars
#' @return a [list]
#' @export
put_MYZvars.RM_dts <- function(MYZvars, y, pars, s){
  with(pars$ix$MYZ[[s]],
    with(MYZvars,{
      y[M_ix] = M
      y[P_ix] = P
      y[U_ix] = U
      y[Y_ix] = Y
      y[Z_ix] = Z
      return(y)
  }))
}

#' @title Make parameters for RM_dts adult mosquito model
#' @param pars a [list]
#' @param EIPopts a string: the class name for the EIP model
#' @param p daily mosquito survival
#' @param sigma emigration rate
#' @param f feeding rate
#' @param q human blood fraction
#' @param nu oviposition rate, per mosquito
#' @param eggsPerBatch eggs laid per oviposition
#' @param eip maximum length for extrinsic incubation period
#' @param calK mosquito dispersal matrix of dimensions `nPatches` by `nPatches`
#' @return a [list]
#' @export
make_parameters_MYZ_RM_dts <- function(pars, EIPopts, p, sigma, f, q, nu, eggsPerBatch, eip, calK) {
  stopifnot(is.numeric(p), is.numeric(sigma), is.numeric(f),
            is.numeric(q), is.numeric(nu), is.numeric(eggsPerBatch))

  MYZpar <- list()
  class(MYZpar) <- "RM_dts"

  nPatches <- pars$nPatches
  MYZpar$nPatches <- nPatches
  if(nPatches == 1){
    sigma = 0
    calK = 1
  }

  MYZpar$p      <- checkIt(p, pars$nPatches)
  MYZpar$sigma  <- checkIt(sigma, pars$nPatches)
  MYZpar$f      <- checkIt(f, pars$nPatches)
  MYZpar$q      <- checkIt(q, pars$nPatches)
  MYZpar$nu     <- checkIt(nu, pars$nPatches)
  MYZpar$eggsPerBatch <- eggsPerBatch

  # Store as baseline values
  MYZpar$p0      <- MYZpar$p
  MYZpar$sigma0  <- MYZpar$sigma
  MYZpar$f0      <- MYZpar$f
  MYZpar$q0      <- MYZpar$q
  MYZpar$nu0     <- MYZpar$nu

  MYZpar$p_par   <- list()
  class(MYZpar$p_par) <- "static"
  MYZpar$f_par   <- list()
  class(MYZpar$f_par) <- "static"
  MYZpar$q_par   <- list()
  class(MYZpar$q_par) <- "static"
  MYZpar$sigma_par   <- list()
  class(MYZpar$sigma_par) <- "static"
  MYZpar$nu_par   <- list()
  class(MYZpar$nu_par) <- "static"

  MYZpar$nPatches <- pars$nPatches

  MYZpar$eip <- eip
  MYZpar <- setup_EIP(EIPopts, MYZpar)
  MYZparG <- EIP(0, MYZpar)

  MYZpar$calK <- calK
  Omega_par <- list()
  class(Omega_par) <- "static"
  MYZpar$Omega_par <- Omega_par
  MYZpar$Omega <- with(MYZpar, make_Omega_dts(p, sigma, mu, calK))

  pars$MYZpar = list()
  pars$MYZpar[[1]] = MYZpar

  return(pars)
}

#' @title Make inits for RM_dts adult mosquito model
#' @param pars a [list]
#' @param M0 total mosquito density at each patch
#' @param P0 total parous mosquito density at each patch
#' @param U0 total uninfected mosquito density at each patch
#' @param Y0 infected mosquito density at each patch
#' @param Z0 infectious mosquito density at each patch
#' @return a [list]
#' @export
make_inits_MYZ_RM_dts <- function(pars, M0, P0, U0, Y0, Z0) {
  pars$MYZinits = list()
  pars$MYZinits[[1]] = list(M=M0, P=P0, U=U0, Y=Y0, Z=Z0)
  return(pars)
}

#' @title Parse the output of deSolve and return variables for the RM_dts model
#' @description Implements [parse_outputs_MYZ] for the RM_dts model
#' @inheritParams parse_outputs_MYZ
#' @return a [list]
#' @export
parse_outputs_MYZ.RM_dts <- function(outputs, pars, s) {with(pars$ix$MYZ[[s]],{
  time = outputs[,1]
  M = outputs[,M_ix+1]
  P = outputs[,P_ix+1]
  U = outputs[,U_ix+1]
  Y = rowSums(outputs[,Y_ix+1])
  Z = outputs[,Z_ix+1]
  y = Y/M
  z = Z/M
  parous = P/M
  return(list(time=time, M=M, P=P, U=U, Y=Y, Z=Z, y=y, z=z, parous=parous))
})}

#' @title Return initial values as a vector
#' @description Implements [get_inits_MYZ] for the RM_dts model.
#' @inheritParams get_inits_MYZ
#' @return [numeric]
#' @export
get_inits_MYZ.RM_dts <- function(pars, s) {with(pars$MYZinits[[s]],{
  c(M, P, U, Y, Z)
})}

#' @title Make inits for RM_dts adult mosquito model
#' @inheritParams update_inits_MYZ
#' @return a [list]
#' @export
update_inits_MYZ.RM_dts <- function(pars, y0, s) {with(pars$ix$MYZ[[s]],{
  M = y0[M_ix]
  P = y0[P_ix]
  U = y0[U_ix]
  Y = y0[Y_ix]
  Z = y0[Z_ix]
  pars$MYZinits[[s]] = make_MYZinits_RM_dts(pars$nPatches, max_eip, list(), M0=M, P=P0, U=U0, Y0=Y, Z0=Z)
  return(pars)
})}



