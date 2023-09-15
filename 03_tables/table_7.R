#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Table 7
# Author: Marta Sestelo
#------------------------------------------------------


# kmeans results

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen40n_500.Rda")
out <- data.frame(tt)[, 2]

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen40n_1000.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen40n_1500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen20n_500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen20n_1000.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmeans_cen20n_1500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

res <- cbind(rep(0,6), data.frame(out))
colnames(res) <- c("1","3","2")
res <- res[, c("1","2", "3")]





# kmedians results

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen40n_500.Rda")
out <- data.frame(tt)[, 2]

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen40n_1000.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen40n_1500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen20n_500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen20n_1000.Rda")
out <- rbind(out, data.frame(tt)[, 2])

load("./experiment_4/res_allH0_scenario4_kselect_kmedians_cen20n_1500.Rda")
out <- rbind(out, data.frame(tt)[, 2])

res2 <- cbind(rep(0,6), data.frame(out))

colnames(res2) <- c("1","3","2")
res2 <- res2[, c("1","2", "3")]

output <- cbind(c = c(rep(40, 3), rep(20, 3)), 
      n = rep(c(500, 1000, 1500), 2), res, res2)
rownames(output) <- c(1:6)
output









