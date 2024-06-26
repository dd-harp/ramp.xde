library(expm)
library(deSolve)
library(MASS)

numeric_tol <- 1e-5

test_that("forced emergence works with equilibrium", {
  nPatches <- 3
  nVectors <- 1
  nHabitats <- 4
  f <- rep(0.3, nPatches)
  q <- rep(0.9, nPatches)
  g <- rep(1/20, nPatches)
  sigma <- rep(1/10, nPatches)
  mu <- rep(0, nPatches)
  eip <- 11
  nu <- 1/2
  eggsPerBatch <- 30

  calN <- matrix(0, nPatches, nHabitats)
  calN[1,1] <- 1
  calN[2,2] <- 1
  calN[3,3] <- 1
  calN[3,4] <- 1

  calU <- matrix(0, nHabitats, nPatches)
  calU[1,1] <- 1
  calU[2,2] <- 1
  calU[3:4,3] <- 0.5

  calK <- matrix(0, nPatches, nPatches)
  calK[1, 2:3] <- c(0.2, 0.8)
  calK[2, c(1,3)] <- c(0.5, 0.5)
  calK[3, 1:2] <- c(0.7, 0.3)
  calK <- t(calK)

  Omega <- make_Omega_xde(g, sigma, mu, calK)
  OmegaEIP <- expm::expm(-Omega * eip)

  kappa <- c(0.1, 0.075, 0.025)
  Lambda <- c(5, 10, 8)

  # equilibrium solutions (forward)
  Omega_inv <- solve(Omega)
  OmegaEIP_inv <- expm::expm(Omega * eip)

  M_eq <- as.vector(Omega_inv %*% Lambda)
  P_eq <- as.vector(solve(diag(f, nPatches) + Omega) %*% diag(f, nPatches) %*% M_eq)
  Y_eq <- as.vector(solve(diag(f*q*kappa) + Omega) %*% diag(f*q*kappa) %*% M_eq)
  Z_eq <- as.vector(Omega_inv %*% OmegaEIP %*% diag(f*q*kappa) %*% (M_eq - Y_eq))

  # the "Lambda" for the dLdt model
  alpha <- as.vector(ginv(calN) %*% Lambda)

  params <- make_parameters_xde()
  params$nPatches = nPatches
  params$nHabitats = nHabitats
  params$nVectors = nVectors
  params$calU=list()
  class(params$calU) <- "static"
  params$calU[[1]] = calU
  params$calN = calN
  params$kappa[[1]] = kappa
  params$Lambda[[1]] = Lambda


  # ODE
  params = make_parameters_MYZ_RM(pars = params, g = g, sigma = sigma, mu=mu, calK = calK, eip = eip, f = f, q = q, nu = nu, eggsPerBatch = eggsPerBatch, solve_as = "ode")
  params = make_inits_MYZ_RM_ode(pars = params, M0 = rep(0, nPatches), P0 = rep(0, nPatches), Y0 = rep(0, nPatches), Z0 = rep(0, nPatches))
  params = make_parameters_L_trace(pars = params, Lambda = alpha)

  params = make_indices(params)

  y0 <- get_inits(params)


  out <- deSolve::ode(y = y0, times = c(0, 365), func = xDE_diffeqn_mosy, parms=params, method = 'lsoda')

  M_sim <- as.vector(out[2, params$ix$MYZ[[1]]$M_ix+1])
  P_sim <- as.vector(out[2, params$ix$MYZ[[1]]$P_ix+1])
  Y_sim <- as.vector(out[2, params$ix$MYZ[[1]]$Y_ix+1])
  Z_sim <- as.vector(out[2, params$ix$MYZ[[1]]$Z_ix+1])

  expect_equal(M_eq, M_sim, tolerance = numeric_tol)
  expect_equal(P_eq, P_sim, tolerance = numeric_tol)
  expect_equal(Y_eq, Y_sim, tolerance = numeric_tol)
  expect_equal(Z_eq, Z_sim, tolerance = numeric_tol)

})
