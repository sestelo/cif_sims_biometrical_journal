#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Table 4
# Author: Marta Sestelo
#------------------------------------------------------

avalue <- 2

# kmeans results

load("./experiment_2/res_cif_scenario2_kmeans_cen33_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm <- out1[out1$a == avalue, c(1:3, 5,6)]

load("./experiment_2/res_cif_scenario2_kmeans_cen33_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_2/res_cif_scenario2_kmeans_cen33_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_2/res_cif_scenario2_kmeans_cen16_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue, c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_2/res_cif_scenario2_kmeans_cen16_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_2/res_cif_scenario2_kmeans_cen16_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c(1:3, 5,6)]
cm <-rbind(cm, out1)


# kmedians results

load("./experiment_2/res_cif_scenario2_kmedians_cen33_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm2 <- out1[out1$a == avalue, c(5,6)]

load("./experiment_2/res_cif_scenario2_kmedians_cen33_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_2/res_cif_scenario2_kmedians_cen33_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_2/res_cif_scenario2_kmedians_cen16_n_500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_2/res_cif_scenario2_kmedians_cen16_n_1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_2/res_cif_scenario2_kmedians_cen16_n_1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == avalue,c( 5,6)]
cm2 <-rbind(cm2, out1)

res <- cbind(cm, cm2)










