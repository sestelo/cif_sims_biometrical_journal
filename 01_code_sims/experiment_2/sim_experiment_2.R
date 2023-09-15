#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Experiment 2
# Author: Marta Sestelo
#------------------------------------------------------


library(clustcurv)
library(mstate)




# Incitial function for generating one sample data from experiment 2
#-------------------------------------------------------------------

scenario2 <- function(a, n, cen){ 

  h1 <- function(t,a) 0.05*log(t+2)
  h2 <- function(t,a) 0.29/(t+2+a) 

  a01 <- function(t) {
    0.05 * log(t + 2)
  }

  a02 <- function(t,a) {
    0.29/(t + 2 + a)
  }

  cum.haz <- function(t, y, a=0) {
    0.29 * log(t + 2) +
      0.29 * log(t + 2 + a) +
      0.05*(t + 2)*log(t+2)-(t+2*log(2))*0.05 - y
  }

  create.times <- function(n, ch, sup.int = 200, a=0) {
    times <- numeric(n)
    i <- 1
    while (i <= n) {
      u <- runif(1)
      if (ch(0, -log(u), a) * ch(sup.int, -log(u), a) < 0) {
        times[i] <- uniroot(ch, c(0, sup.int), tol = 1e-04, y = -log(u))$root
        i <- i + 1
      } else {
        # cat("pos")
      }
    }
    return(times)
  }

  group.status <- function(ftime, n, a01, a02, a=0) {
    out <- rep(0,length(ftime))
    for(k in 1:length(ftime)){
      prob1 <- a01(ftime[k])/(a01(ftime[k]) + a02(ftime[k],0) + a02(ftime[k],a))
      prob2 <- a02(ftime[k],0)/(a01(ftime[k]) + a02(ftime[k],0) + a02(ftime[k],a))
      prob3 <- a02(ftime[k],a)/(a01(ftime[k]) + a02(ftime[k],0) + a02(ftime[k],a))
      out[k] <- sample.int(3,size=1,replace=TRUE, prob=c(prob1,prob2,prob3))
    }
    out
  }

  t <- create.times(n, cum.haz, a=a)
  group <- group.status(t, n, a01, a02, a=a)

  cens <- runif(length(t), min = 0, max = cen)  
  time <- pmin(t,cens)
  status <- 1*(time < cens)*group
  mydata <- data.frame(cbind(t,group, cens, time, status))
}





# Function for generating and testing 1 simulation run
#-----------------------------------------------------

sim_onerep <- function(n, nboot, K, a, kbin, algorithm, weights, cen) {

  data <- scenario2(a = a, n = n, cen = cen)

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


    pvalue[irep] <- sim_onerep(n, nboot, K, a, kbin, algorithm, weights, cen)

    #print(pvalue)
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
#nvalues <- 500
#cen <- 32
#algorithm <- "kmedians"
#ncores <- NULL # local
#nvalues <- c(100, 200, 500, 1000)
#cen <- c(16, 8) # porcentaje censura, 16 da lugar a censuras del 30%-40% (con aumento a)
# censura 8, da lugar a 15%-19% (con aumento a)
#-----------------------------------------------



nrep <- 1000
nboot <- 500
weights <- "KM"
K <- 2
kbin <- 50


first <- Sys.time()
seed <- 30072016
set.seed(seed)

avalues <- c(0, 1, 2, 3, 4)


out <- NULL
for (n in nvalues) {
  for (a in avalues) {
    aux <- simulation(nrep = nrep, n = n, nboot = nboot, K = K, a = a, kbin = kbin,
                   algorithm = algorithm, weights = weights, cen = cen)
    out <- rbind(out, aux)
    colnames(out) <- c("n", "a", "cen","1%", "5%","10%","15%","20%")
    rownames(out) <- NULL
    file <- paste0("res_cif_scenario2_",algorithm,"_cen",cen,"_n_",n, ".Rda")
    save(list = c("out"), file = file)
  }
}

runtime <- Sys.time() - first
runtime

save(list = c("out", "runtime"), file = file)









