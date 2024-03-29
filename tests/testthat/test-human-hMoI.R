library(deSolve)

numeric_tol <- 1e-5

test_that("human hybrid MoI model remains at equilibrium", {
  nStrata <- 3
  H <- c(100, 500, 250)
  residence = 1:nStrata
  searchWtsH = rep(1, nStrata)
  b <- 0.55
  c1 <- 0.05
  c2 <- 0.25
  r1 <- 1/250
  r2 <- 1/50
  TaR <- matrix(data = 1,nrow = 1, ncol = nStrata)

  m20 <- 1.5
  foi <- r2*m20
  m10 <- foi/r1

  params <- make_parameters_xde()
  params$nStrata = nStrata
  params$nHosts <- 1
  params$nPatches = 1
  params = make_parameters_demography_null(pars = params, H=H)
  params = setup_BloodFeeding(params, 1, 1, residence=residence, searchWts=searchWtsH)
  params$BFpar$TaR[[1]][[1]]=TaR
  params = make_parameters_X_hMoI(pars = params, b = b, c1 = c1, c2 = c2, r1 = r1, r2 = r2)
  params = make_inits_X_hMoI(pars = params, m10 = rep(m10,nStrata), m20 = rep(m20,nStrata))

  params = make_indices(params)

  # set initial conditions
  y0 <- get_inits(params)
  params$FoI[[1]] <- foi
  out <- deSolve::ode(y = y0, times = c(0, 365), func = function(t, y, pars, s) {
    list(dXdt(t, y, pars, s))
  }, parms = params, method = 'lsoda', s=1)

  expect_equal(as.vector(out[2L, params$ix$X[[1]]$m1_ix+1]), rep(m10, nStrata), tolerance = numeric_tol)
  expect_equal(as.vector(out[2L, params$ix$X[[1]]$m2_ix+1]), rep(m20, nStrata), tolerance = numeric_tol)

})
