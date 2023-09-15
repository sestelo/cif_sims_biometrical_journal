#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Table 1
# Author: Marta Sestelo
#------------------------------------------------------



# kmeans results

load("./experiment_1/res_cif_scenario1_kmeans_cen100_n500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm <- out1[out1$a == 0, c(1:3, 5,6)]

load("./experiment_1/res_cif_scenario1_kmeans_cen100_n1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_1/res_cif_scenario1_kmeans_cen100_n1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_1/res_cif_scenario1_kmeans_cen50_n500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0, c(1:3, 5,6)]
cm <-rbind(cm, out1)

load("./experiment_1/res_cif_scenario1_kmeans_cen50_n1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c(1:3, 5,6)]
cm <-rbind(cm, out1)


load("./experiment_1/res_cif_scenario1_kmeans_cen50_n1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c(1:3, 5,6)]
cm <-rbind(cm, out1)


# kmedians results

load("./experiment_1/res_cif_scenario1_kmedians_cen100_n500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
cm2 <- out1[out1$a == 0, c(5,6)]

load("./experiment_1/res_cif_scenario1_kmedians_cen100_n1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_1/res_cif_scenario1_kmedians_cen100_n1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_1/res_cif_scenario1_kmedians_cen50_n500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_1/res_cif_scenario1_kmedians_cen50_n1000.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c( 5,6)]
cm2 <-rbind(cm2, out1)

load("./experiment_1/res_cif_scenario1_kmedians_cen50_n1500.Rda")
out1 <- data.frame(out)
names(out1) <- colnames(out)
out1 <- out1[out1$a == 0,c( 5,6)]
cm2 <-rbind(cm2, out1)

res <- cbind(cm, cm2)





