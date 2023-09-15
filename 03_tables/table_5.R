#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Table 5
# Author: Marta Sestelo
#------------------------------------------------------

avalue <- 0

# kmeans results

load("./experiment_3/res_cif_scenario3_kmeans_cen40_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm <- out1[out1$a == avalue, c(1:3, 5,6)]

load("./experiment_3/res_cif_scenario3_kmeans_cen40_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_3/res_cif_scenario3_kmeans_cen40_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_3/res_cif_scenario3_kmeans_cen20_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue, c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_3/res_cif_scenario3_kmeans_cen20_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_3/res_cif_scenario3_kmeans_cen20_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)


# kmedians results

load("./experiment_3/res_cif_scenario3_kmedians_cen40_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm2 <- out1[out1$a == avalue, c(5,6)]

load("./experiment_3/res_cif_scenario3_kmedians_cen40_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_3/res_cif_scenario3_kmedians_cen40_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_3/res_cif_scenario3_kmedians_cen20_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_3/res_cif_scenario3_kmedians_cen20_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_3/res_cif_scenario3_kmedians_cen20_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

res <- cbind(cm, cm2)









