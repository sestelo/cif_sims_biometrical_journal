#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Table 8
# Author: Marta Sestelo
#------------------------------------------------------


# kmeans results

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen30n_1000.Rda")
out <- c(0,0, data.frame(tt)[, 2], 0)

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen30n_2500.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen30n_5000.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen15n_1000.Rda")
out <- rbind(out, c(rep(0, 2), data.frame(tt)[2:4, 2],data.frame(tt)[1, 2]))

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen15n_2500.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))

load("./experiment_5/res_allH0_scenario5_kselect_kmeans_cen15n_5000.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))


res <- out
colnames(res) <- c("1","2","3","4", "5", ">5" )






# kmedians results


load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen30n_1000.Rda")
out <- c(rep(0, 2), data.frame(tt)[2:4, 2],data.frame(tt)[1, 2])

load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen30n_2500.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))

load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen30n_5000.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))

load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen15n_1000.Rda")
out <- rbind(out, c(rep(0, 2), data.frame(tt)[2:4, 2],data.frame(tt)[1, 2]))

load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen15n_2500.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[2:3, 2],data.frame(tt)[1, 2]))

load("./experiment_5/res_allH0_scenario5_kselect_kmedians_cen15n_5000.Rda")
out <- rbind(out, c(rep(0, 3), data.frame(tt)[, 2], 0))


res2 <- out
colnames(res2) <- c("1","2","3","4", "5", ">5" )


output <- cbind(c = c(rep(30, 3), rep(15, 3)), 
                n = rep(c(1000, 2500, 5000), 2), res, res2)
rownames(output) <- c(1:6)
output









