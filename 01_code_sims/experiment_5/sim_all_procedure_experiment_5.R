#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Experiment 5
# Author: Marta Sestelo
#------------------------------------------------------


library(clustcurv)
library(mstate)



# Incitial function for generating one sample data from experiment 5
#-------------------------------------------------------------------
scenario5 <- function(a, n, cen = 20){ 

group.status <- function(n, a01, a02, a03, a04, a05, a06, a07) {
  out <- rep(0, n)
  for(k in 1:n){
    prob1 <- a01/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob2 <- a02/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob3 <- a03/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob4 <- a04/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob5 <- a05/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob6 <- a06/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    prob7 <- a07/(a01 + a02 + a03 + a04 + a05 + a06 + a07)
    out[k] <- sample.int(7, size = 1,
                         replace = TRUE,
                         prob =c(prob1, prob2, prob3, prob4, prob5, prob6, prob7))
  }
  out
}


gensurvtime2 <- function(n, exp.par, cens.dist = "uniform", cens.par = cen){
  event.times <- rexp(n, sum(exp.par))
  a01 <- exp.par[1];a02 <- exp.par[2];a03 <- exp.par[3]
  a04 <- exp.par[4];a05 <- exp.par[5];a06 <- exp.par[6]
  a07 <- exp.par[7]
  f.cause <- group.status(n, a01, a02, a03, a04, a05, a06, a07)
  cens.times <- runif(n, 0, cens.par)
  obs.times <- pmin(event.times, cens.times)
  obs.cause <- c(event.times <= cens.times)*f.cause
  mdata <- data.frame(obs.times, obs.cause)
  return(mdata)
}

exp.par <- c(0.01, 0.01, 0.01, 0.01, 0.04, 0.07, 0.1)


mydata <- gensurvtime2(n, exp.par = exp.par)
return(mydata)
}









# Function for generating and testing 1 simulation run
#-----------------------------------------------------

sim_onerep <- function(n, nboot, K, a, kbin, algorithm, weights, cen) {

  data <- scenario5(a = a, n = n, cen = cen)
  names(data) <- c("time", "status")


  out <- survcifcurves(time = data$time, status = data$status, x = NULL,
                       kbin = kbin, nboot = nboot,
                       algorithm = algorithm, cluster = TRUE, ncores = ncores,
                       max_time = NULL,
                       weights = weights, kvector = c(1:5))

  return(list(k = out$num_groups, levels = out$levels, newlevels = out$cluster))

}





# Function for running nrep simulation runs
#------------------------------------------

simulation <- function(nrep, n, nboot, K, a, kbin, algorithm, weights, cen) {
  rejects_num <- 0
  success_all <- 0
  success_num <- 0
  kselect <- NA
  for (irep in 1:nrep) {
    set.seed(irep)
    print(c("irep", irep))
    print(c("n",n))
    #

    res <- sim_onerep(n, nboot, K, a, kbin, algorithm, weights, cen)
    kselect[irep] <- res$k

    print(res$newlevels)
    if (res$k != 4){
      rejects_num <- rejects_num + 1
    }else{
      if(
        identical(sort(res$newlevels[-1]), sort(c(4, 4, 4, 3, 2, 5, 4))) == TRUE |
        identical(sort(res$newlevels[-1]), sort(c(2, 2, 2, 3, 4, 5, 2))) == TRUE |
        identical(sort(res$newlevels[-1]), sort(c(3, 3, 3, 4, 2, 5, 3))) == TRUE |
        identical(sort(res$newlevels[-1]), sort(c(5, 5, 5, 3, 2, 4, 5))) == TRUE

         ){
        success_all <- success_all + 1
      }else{
        success_num <- success_num + 1
      }
    }

    print(paste("irep=",irep,"   n=",n, "   dgen=", cen,
                "  rejects_num=",round((rejects_num/irep) * 100, 2), "  success_all=",round((success_all/irep) * 100, 2),
                "  success_num=",round((success_num/irep) * 100, 2)))
  }

  file <- paste0("res_allH0_scenario5_kselect",algorithm,"_cen",cen,"n_", n,".Rda")
  tt <- table(kselect)
  save(list = c("tt"), file = file)


  return(c(n, cen, (rejects_num/nrep) * 100, (success_all/nrep) * 100,
           (success_num/nrep) * 100))

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
#nvalues <- 1000
#cen <- 30
#algorithm <- "kmedians"
#ncores <- NULL # local
#nvalues <- c(100, 200, 500, 1000)
#cen <- c(20, 10) # porcentaje censura, 40 da lugar a censuras del 15%
# censura 20, da lugar a 30%
#-----------------------------------------------
n <- nvalues
a <- 0
nrep <- 1000
nboot <- 500
weights <- "KM"
kbin <- 50


first <- Sys.time()
seed <- 30072016
set.seed(seed)


out <- NULL
aux <- simulation(nrep = nrep, n = n, nboot = nboot, K = K, a = a, kbin = kbin,
                  algorithm = algorithm, weights = weights, cen = cen)

out <- rbind(out, aux)
colnames(out) <- c("n", "dgcen", "fails_number", "success_all", "success_number")
rownames(out) <- NULL
file <- paste0("res_allH0_scenario5_",algorithm,"_cen",cen,"n_", n,".Rda")
save(list = c("out"), file = file)



runtime <- Sys.time() - first
runtime

save(list = c("out", "runtime"), file = file)









