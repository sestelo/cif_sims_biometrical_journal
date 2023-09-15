#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Experiment 1
# Author: Marta Sestelo
#------------------------------------------------------



library(clustcurv)
library(mstate)



# Incitial function for generating one sample data from experiment 1
#-------------------------------------------------------------------

gensurvtime <- function(n = 500, exp.par = 0.05, cens.dist = "uniform",
                        cens.par = 50, a = 0){

  event.times <- rexp(n, exp.par + a)
  pr <- exp.par/(exp.par + exp.par + a)
  f.cause <- rbinom(n, size = 1, prob = pr)
  f.cause <- ifelse(f.cause == 0, 2, 1)
  cens.times <- runif(n, 0, cens.par)
  obs.times <- pmin(event.times, cens.times)
  obs.cause <- c(event.times <= cens.times)*f.cause
  mdata <- data.frame(obs.times, obs.cause)
  return(mdata)
}






# Function for generating and testing 1 simulation run
#-----------------------------------------------------

sim_onerep <- function(n, nboot, K, a, kbin, algorithm, weights, cen) {

  data <- gensurvtime(n = n, a = a, cens.par = cen)
  names(data) <- c("time", "status")


  out <- survcifcurves(time = data$time, status = data$status, x = NULL,
                           kbin = kbin, nboot = nboot,
                           algorithm = algorithm, cluster = TRUE, ncores = ncores,
                           max_time = NULL,
                           weights = weights, kvector = K)


  pval <- out$table$pvalue
  return(pval)
}



# Function for running nrep simulation runs
#------------------------------------------

simulation <- function(nrep, n, nboot, K, a, kbin, algorithm, weights, cen) {
  pvalue <- NULL
  for (irep in 1:nrep) {
    set.seed(irep)
    print(c("irep", irep))
    print(c("a",a))
    print(c("n",n))
    #

    pvalue[irep] <- sim_onerep(n, nboot, K, a, kbin, algorithm, weights, cen)

    rechazo <- matrix(NA, nrow = 1, ncol = 5)
    rechazo[1, ] <- c(mean(pvalue < 0.01),
                      mean(pvalue < 0.05),
                      mean(pvalue < 0.1),
                      mean(pvalue < 0.15),
                      mean(pvalue < 0.2))
    print(rechazo)

  }
  return(c(n, a, cen, rechazo[1, ]))
}








# Input parameters 
#-----------------

args <- commandArgs(TRUE)
nvalues <- as.numeric(args[1])
cen <- as.numeric(args[2])
algorithm <- args[3]
ncores <- as.numeric(Sys.getenv("SLURM_NTASKS")) # for cesga




# local
#------------------------------------------
#nvalues <- 100
#cen <- 100
#algorithm <- "kmedians"
#ncores <- NULL # local
#nvalues <- c(100, 200, 500, 1000)
#cen <- c(130, 65) # porcentaje censura, 130 da lugar a censuras del 15%-10% (con aumento a)
# censura 65, da lugar a 30%-20% (con aumento a)
#-----------------------------------------------



nrep <- 1000
nboot <- 500
weights <- "KM"
K <- 1
kbin <- 50

#first <- Sys.time()
seed <- 30072016
set.seed(seed)

avalues <- c(0.0, 0.01, 0.02, 0.03)

out <- NULL
for (n in nvalues) {
  for (a in avalues) {
    aux <- simulation(nrep = nrep, n = n, nboot = nboot, K = K, a = a, kbin = kbin,
                   algorithm = algorithm, weights = weights, cen = cen)
    out <- rbind(out, aux)
    colnames(out) <- c("n", "a", "cen","1%", "5%","10%","15%","20%")
    rownames(out) <- NULL
    print(out)
    file <- paste0("res_cif_scenario1_",algorithm,"_cen",cen,"_n",n, ".Rda")
    save(list = c("out"), file = file)
  }
}

#runtime <- Sys.time() - first
#runtime
#save(list = c("out", "runtime"), file = file)









