#' @title Solve a system of equations
#' @description This method dispatches on the type of `pars$dts`.
#' @param pars a [list] that defines a model
#' @param Tmax the last time point, run from 0...Tmax
#' @return a [list]
#' @export
dts_solve = function(pars, Tmax=365){
  UseMethod("dts_solve", pars)
}

#' @title Solve for the steady state or stable orbit of a system of equations
#' @description This method dispatches on the type of `pars$dts`.
#' @param pars a [list] that defines a model
#' @param Tburn the number of steps to burn
#' @param yr the number of time steps in a year
#' @return a [list]
#' @export
dts_stable_orbit = function(pars, Tburn=10, yr=365){
  yt = get_inits(pars)
  tt = seq(0, Tburn*yr, by=pars$Dday)
  for(t in tt){
    yt =  DTS_step(t, yt, pars)
  }
  orbit = yt
  tt = seq(0, yr, by=pars$Dday)
  for(t in tt[-1]){
    yt =  DTS_step(t, yt, pars)
    orbit = rbind(orbit, yt)
  }
  pars$outputs$stable_orbits <- orbit
  return(pars)
}

#' @title Solve for the steady state of a system of equations
#' @description This method dispatches on the type of `pars$dts`
#' @param pars a [list] that defines a model
#' @param Tx the number of steps to equilibrium
#' @return a [list]
#' @export
dts_steady = function(pars, Tx=1000){
  tt = seq(0, Tx, by=pars$Dday)
  yt = get_inits(pars)
  for(t in tt[-1]){
    yt =  DTS_step(t, yt, pars)
  }
  pars$outputs$steady = parse_outputs_vec(yt, pars)
  return(pars)
}

#' @title Solve a system of equations as an ode
#' @description Implements [dts_solve] for ordinary differential equations
#' @inheritParams dts_solve
#' @return a [list]
#' @export
dts_solve.dts = function(pars, Tmax=365){
  tt = seq(0, Tmax, by=pars$Dday)
  yt = get_inits(pars)
  dts_out = c(0, yt)
  for(t in tt[-1]){
    yt =  DTS_step(t, yt, pars)
    dts_out = rbind(dts_out, c(t,yt))
  }
  pars$outputs$orbits = parse_outputs(dts_out, pars)
  return(pars)
}

#' @title Solve a system of equations for aquatic dynamics, forced by egg deposition, using dts_diffeqn_aquatic
#' @description Implements [dts_solve] for aquatic dynaamic
#' @inheritParams dts_solve
#' @return a [list]
#' @export
dts_solve.aqua = function(pars, Tmax=365){
  tt = seq(0, Tmax, by=pars$Dday)
  yt = get_inits(pars)
  dts_out = c(0, yt)
  for(t in tt[-1]){
    yt = DTS_step_aquatic(t, yt, pars)
    dts_out = rbind(dts_out, c(t, yt))
  }
  pars$outputs$orbits = parse_outputs(dts_out, pars)
  return(pars)
}

#' @title Solve a system of equations for mosquito ecology using dts_diffeqn_mosy
#' @description Implements [dts_solve] for mosquito dynamics (no transmission)
#' @inheritParams dts_solve
#' @return a [list]
#' @export
dts_solve.mosy = function(pars, Tmax=365){
  tt = seq(0, Tmax, by=pars$Dday)
  yt = get_inits(pars)
  dts_out = c(0, yt)
  for(t in tt[-1]){
    yt =  DTS_step_mosy(t, yt, pars)
    dts_out = rbind(dts_out, c(t, yt))
  }
  pars$outputs$orbits = parse_outputs(dts_out, pars)
  return(pars)
}

#' @title Solve a system of equations with dts_diffeqn_human
#' @description Implements [dts_solve] for mosquito dynamics (no transmission)
#' @inheritParams dts_solve
#' @return a [list]
#' @export
dts_solve.human = function(pars, Tmax=365){
  tt = seq(0, Tmax, by=pars$Dday)
  yt = get_inits(pars)
  dts_out = c(0, yt)
  for(t in tt[-1]){
    yt =  DTS_step_human(t, yt, pars)
    dts_out = rbind(dts_out, c(t, yt))
  }
  pars$outputs$orbits = parse_outputs(dts_out, pars)
  return(pars)
}

#' @title Solve a system of equations with dts_diffeqn_cohort
#' @description Implements [dts_solve] for mosquito dynamics (no transmission)
#' @inheritParams dts_solve
#' @return a [list]
#' @export
dts_solve.cohort = function(pars, Tmax=365){
  tt = seq(0, Tmax, by=pars$Dday)
  yt = get_inits(pars)
  dts_out = c(0, yt)
  for(t in tt[-1]){
    yt =  DTS_step_cohort(t, yt, pars)
    dts_out = rbind(yt, c(t, yt))
  }
  pars$outputs$orbits = parse_outputs(dts_out, pars)
  return(pars)
}
