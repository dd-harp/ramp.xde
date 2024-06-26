library(MASS)
library(expm)
library(deSolve)

numeric_tol <- 1e-5

test_that("Le Menach VC model with 0 coverage stays roughly at equilibrium", {
  pars <- make_parameters_xde()
  pars$nPatches <- 3
  pars$nStrata <- 3
  pars$nHabitats <- 3
  pars$nVectors <- 1
  pars$nHosts <- 1

  # parameters
  b <- 0.55
  c <- 0.15
  r <- 1/200
  wf <- rep(1, pars$nStrata)

  f <- rep(0.3, pars$nPatches)
  q <- rep(0.9, pars$nPatches)
  g <- rep(1/10, pars$nPatches)
  sigma <- rep(1/100, pars$nPatches)
  mu <- rep(0, pars$nPatches)
  nu <- rep(1/2, pars$nPatches)
  eggsPerBatch <- 30

  eip <- 11

  # mosquito movement calK
  calK <- matrix(0, pars$nPatches, pars$nPatches)
  calK[upper.tri(calK)] <- 1/(pars$nPatches-1)
  calK[lower.tri(calK)] <- 1/(pars$nPatches-1)
  calK <- calK/rowSums(calK)
  calK <- t(calK)

  Omega <- make_Omega_xde(g, sigma, mu, calK)
  Omega_inv <- solve(Omega)
  Upsilon <- expm::expm(-Omega * eip)
  Upsilon_inv <- expm::expm(Omega * eip)

  # human PfPR and H
  pfpr <- runif(n = pars$nStrata, min = 0.25, max = 0.35)
  H <- rpois(n = pars$nStrata, lambda = 1000)
  I <- rbinom(n = pars$nStrata, size = H, prob = pfpr)
  residence = 1:pars$nStrata
  searchWtsH = rep(1, pars$nStrata)

  TaR <- matrix(
    data = c(
      0.9, 0.05, 0.05,
      0.05, 0.9, 0.05,
      0.05, 0.05, 0.9
    ), nrow = pars$nStrata, ncol = pars$nPatches, byrow = T
  )
  TaR <- t(TaR)

  # derived EIR to sustain equilibrium pfpr
  EIR <- diag(1/b, pars$nStrata) %*% ((r*I) / (H - I))

  # ambient pop
  W <- TaR %*% H

  # biting distribution matrix
  beta <- diag(wf) %*% t(TaR) %*% diag(1/as.vector(W), pars$nPatches)

  # kappa
  kappa <- t(beta) %*% (I*c)

  # equilibrium solutions
  Z <- diag(1/(f*q), pars$nPatches) %*% ginv(beta) %*% EIR
  MY <- diag(1/as.vector(f*q*kappa), pars$nPatches) %*% Upsilon_inv %*% Omega %*% Z
  Y <- Omega_inv %*% (diag(as.vector(f*q*kappa), pars$nPatches) %*% MY)
  M <- MY + Y
  P <- solve(diag(f, pars$nPatches) + Omega) %*% diag(f, pars$nPatches) %*% M
  Lambda <- Omega %*% M

  # set parameters
  pars = make_parameters_demography_null(pars = pars, H=H)
  pars = setup_BloodFeeding(pars, 1, 1, residence=residence, searchWts=searchWtsH)
  pars$BFpar$TaR[[1]][[1]]=TaR
  pars = make_parameters_MYZ_RM(pars = pars, g = g, sigma = sigma, mu=mu, calK = calK, eip = eip, f = f, q = q, nu = nu, eggsPerBatch = eggsPerBatch, solve_as="ode")
  pars = make_inits_MYZ_RM_dde(pars = pars, M0 = as.vector(M), P0 = as.vector(P), Y0 = as.vector(Y), Z0 = as.vector(Z), U0=Upsilon)
  pars = make_parameters_L_trace(pars = pars,  Lambda = as.vector(Lambda))
  pars = make_inits_L_trace(pars = pars)
  pars = make_parameters_X_SIS(pars = pars, b = b, c = c, r = r)
  pars = make_inits_X_SIS(pars = pars, H-I, I)
  pars = setup_control_forced(pars)
  pars = setup_vc_control(pars)
  pars = setup_itn_lemenach(pars = pars, F_phi=function(t, pars){0})

  pars$calU[[1]] <- diag(pars$nPatches)
  pars$calN <- diag(pars$nHabitats)

  pars= make_indices(pars)

  # ICs
  y0 <- get_inits(pars)

  # solve the model
  out = ode(y = y0, times = c(0, 365), func = xDE_diffeqn, parms = pars)

  # check it stays at equilibrium with phi = 0 for all time
  expect_equal(out[1, -1], out[2, -1], tolerance = numeric_tol)
})
