library(expm)
library(MASS)
library(deSolve)

numeric_tol <- 1e-5

test_that("test equilibrium with RM adults (ODE), SIS_xde humans, trace", {

  # set number of patches and strata
  nPatches <- 2
  nStrata <- 2
  nHabitats <- 2

  # parameters
  b <- 0.55
  c <- 0.15
  r <- 1/200
  wf <- rep(1, nStrata)

  f <- rep(0.3, nPatches)
  q <- rep(0.9, nPatches)
  g <- rep(1/10, nPatches)
  sigma <- rep(1/100, nPatches)
  mu <- rep(0, nPatches)
  nu <- rep(1/2, nPatches)
  eggsPerBatch <- 30

  eip <- 11

  # mosquito movement calK
  calK <- matrix(0, nPatches, nPatches)
  calK[upper.tri(calK)] <- rexp(sum(1:(nPatches-1)))
  calK[lower.tri(calK)] <- rexp(sum(1:(nPatches-1)))
  calK <- calK/rowSums(calK)
  calK <- t(calK)

  # omega matrix
  Omega <- make_Omega_xde(g, sigma, mu, calK)
  Omega_inv <- solve(Omega)
  OmegaEIP <- expm::expm(-Omega * eip)
  OmegaEIP_inv <- expm::expm(Omega * eip)

  # human PfPR and H
  pfpr <- rep(0.3, times = nStrata)
  H <- rpois(n = nStrata, lambda = 1000)
  residence = 1:nStrata
  searchWtsH = rep(1, nStrata)
  I <- rbinom(n = nStrata, size = H, prob = pfpr)

  # TaR
  TaR <- matrix(rexp(n = nStrata*nPatches), nStrata, nPatches)
  TaR <- TaR/rowSums(TaR)
  TaR <- t(TaR)

  # derived EIR to sustain equilibrium pfpr
  EIR <- diag(1/b, nStrata, nStrata) %*% ((r*I) / (H - I))

  # ambient pop
  W <- TaR %*% H

  # biting distribution matrix
  beta <- diag(wf) %*% t(TaR) %*% diag(1/as.vector(W), nPatches , nPatches)

  # kappa
  kappa <- t(beta) %*% (I*c)

  # equilibrium solutions for adults
  Z <- diag(1/(f*q), nPatches, nPatches) %*% ginv(beta) %*% EIR
  MY <- diag(1/as.vector(f*q*kappa), nPatches, nPatches) %*% OmegaEIP_inv %*% Omega %*% Z
  Y <- Omega_inv %*% (diag(as.vector(f*q*kappa), nPatches, nPatches) %*% MY)
  M <- MY + Y
  P <- solve(diag(f, nPatches) + Omega) %*% diag(f, nPatches) %*% M
  Lambda <- Omega %*% M

  # equilibrium solutions for aquatic
  calN <- matrix(0, nPatches, nHabitats)
  diag(calN) <- 1

  calU <- matrix(0, nHabitats, nPatches)
  diag(calU) <- 1

  # parameters for exDE
  params <- make_parameters_xde()
  params$nStrata <- nStrata
  params$nPatches <- nPatches
  params$nHabitats <- nHabitats
  params$nVectors <- 1
  params$nHosts <- 1
  params$calU[[1]] = calU
  params$calN <- calN

  params = make_parameters_MYZ_RM(pars = params, g = g, sigma = sigma, mu=mu, calK = calK, eip = eip, f = f, q = q, nu = nu, eggsPerBatch = eggsPerBatch, solve_as="ode")
  params = make_inits_MYZ_RM_ode(pars = params, M0 = as.vector(M), P0 = as.vector(P), Y0 = as.vector(Y), Z0 = as.vector(Z))
  params = make_parameters_demography_null(pars = params, H=H)
  params = setup_BloodFeeding(params, 1, 1, residence=residence, searchWts=searchWtsH)
  params$BFpar$TaR[[1]][[1]]=TaR
  params = make_parameters_X_SIS(pars = params, b = b, c = c, r = r)
  params = make_inits_X_SIS(pars = params, H-I, I)
  params = make_parameters_L_trace(pars = params, Lambda = as.vector(Lambda))

  params = make_indices(params)


  # set initial conditions
  y0 <- get_inits(params)

  # run simulation
  out <- deSolve::ode(y = y0, times = c(0,50), func = xDE_diffeqn, parms = params, method = "lsoda")

  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$M_ix+1]), as.vector(M), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$P_ix+1]), as.vector(P), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$Y_ix+1]), as.vector(Y), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$Z_ix+1]), as.vector(Z), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$X[[1]]$I_ix+1]), as.vector(I), tolerance = numeric_tol)
})

test_that("test equilibrium with RM adults (DDE), SIS_xde humans, trace", {

  # set number of patches and strata
  nPatches <- 2
  nStrata <- 2
  nHabitats <- 2

  # parameters
  b <- 0.55
  c <- 0.15
  r <- 1/200
  wf <- rep(1, nStrata)

  f <- rep(0.3, nPatches)
  q <- rep(0.9, nPatches)
  g <- rep(1/10, nPatches)
  sigma <- rep(1/100, nPatches)
  mu <- rep(0, nPatches)
  nu <- rep(1/2, nPatches)
  eggsPerBatch <- 30

  eip <- 11

  # mosquito movement calK
  calK <- matrix(0, nPatches, nPatches)
  calK[upper.tri(calK)] <- rexp(sum(1:(nPatches-1)))
  calK[lower.tri(calK)] <- rexp(sum(1:(nPatches-1)))
  calK <- calK/rowSums(calK)
  calK <- t(calK)

  # omega matrix
  Omega <- make_Omega_xde(g, sigma, mu, calK)
  Omega_inv <- solve(Omega)
  OmegaEIP <- expm::expm(-Omega * eip)
  OmegaEIP_inv <- expm::expm(Omega * eip)

  # human PfPR and H
  pfpr <- rep(0.3, times = nStrata)
  H <- rpois(n = nStrata, lambda = 1000)
  residence = c(1,2)
  searchWtsH = c(1,1)
  I <- rbinom(n = nStrata, size = H, prob = pfpr)

  # TaR
  TaR <- matrix(rexp(n = nStrata*nPatches), nStrata, nPatches)
  TaR <- TaR/rowSums(TaR)
  TaR <- t(TaR)

  # derived EIR to sustain equilibrium pfpr
  EIR <- diag(1/b, nStrata, nStrata) %*% ((r*I) / (H - I))

  # ambient pop
  W <- TaR %*% H

  # biting distribution matrix
  beta <- diag(wf) %*% t(TaR) %*% diag(1/as.vector(W), nPatches , nPatches)

  # kappa
  kappa <- t(beta) %*% (I*c)

  # equilibrium solutions for adults
  Z <- diag(1/(f*q), nPatches, nPatches) %*% ginv(beta) %*% EIR
  MY <- diag(1/as.vector(f*q*kappa), nPatches, nPatches) %*% OmegaEIP_inv %*% Omega %*% Z
  Y <- Omega_inv %*% (diag(as.vector(f*q*kappa), nPatches, nPatches) %*% MY)
  M <- MY + Y
  P <- solve(diag(f, nPatches) + Omega) %*% diag(f, nPatches) %*% M
  Lambda <- Omega %*% M

  # equilibrium solutions for aquatic
  calN <- matrix(0, nPatches, nHabitats)
  diag(calN) <- 1

  calU <- matrix(0, nHabitats, nPatches)
  diag(calU) <- 1

  # parameters for exDE
  params <- make_parameters_xde()
  params$nStrata <- nStrata
  params$nPatches <- nPatches
  params$nHabitats <- nHabitats
  params$nVectors <- 1
  params$nHosts <- 1
  params$calU[[1]] = calU
  params$calN <- calN

  params = make_parameters_MYZ_RM(pars = params, g = g, sigma = sigma, mu=mu, calK = calK, eip = eip, f = f, q = q, nu = nu, eggsPerBatch = eggsPerBatch)
  params = make_inits_MYZ_RM_dde(pars = params, M0 = as.vector(M), P0 = as.vector(P), Y0 = as.vector(Y), Z0 = as.vector(Z), U0=OmegaEIP)
  params = make_parameters_demography_null(pars = params, H=H)
  params = setup_BloodFeeding(params, 1, 1, residence=residence, searchWts=searchWtsH)
  params$BFpar$TaR[[1]][[1]]=TaR
  params = make_parameters_X_SIS(pars = params, b = b, c = c, r = r)
  params = make_inits_X_SIS(pars = params, H-I, I)
  params = make_parameters_L_trace(pars = params, Lambda = as.vector(Lambda))

  params = make_indices(params)


  # set initial conditions
  y0 <- get_inits(params)

  # run simulation
  out <- deSolve::dede(y = y0, times = c(0,50), func = xDE_diffeqn, parms = params, method = "lsoda")

  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$M_ix+1]), as.vector(M), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$P_ix+1]), as.vector(P), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$Y_ix+1]), as.vector(Y), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$MYZ[[1]]$Z_ix+1]), as.vector(Z), tolerance = numeric_tol)
  expect_equal(as.vector(out[2, params$ix$X[[1]]$I_ix+1]), as.vector(I), tolerance = numeric_tol)
})
