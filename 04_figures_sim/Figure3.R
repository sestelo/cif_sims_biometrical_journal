#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for Figure 3
# Author: Marta Sestelo
#------------------------------------------------------


library(ggplot2)
library(patchwork)


# Loading data
#-----------------

algo <- "kmeans"
censuras <- c(33, 16)
ns <- c(500, 1000, 1500)
aux <- c()
for(cen in censuras){
  for(n in ns){
    file <- paste0("./experiment_2/res_cif_scenario2_", algo,"_cen",cen,"_n_",n,".Rda" )
    load(file)
    aux <- rbind(aux, out)
  }
}
aux1 <- aux[, c(1:3, 5)]


algo <- "kmedians"
aux <- c()
for(cen in censuras){
  for(n in ns){
    file <- paste0("./experiment_2/res_cif_scenario2_", algo,"_cen",cen,"_n_",n,".Rda" )
    load(file)
    aux <- rbind(aux, out)
  }
}
aux2 <- aux[, 5]
aux <- cbind(aux1, aux2)
data <- as.data.frame(aux)
names(data) <- c("n", "a", "cen", "kmeans", "kmedians")



# Plotting
#----------------------
p <- list()
i <- 0
for (cenval in c(33, 16)){
  data2 <- data[data$cen == cenval, ]
  for (nval in c(500, 1000, 1500)){
    i <- i + 1
    datan <- data2[data2$n == nval, ]
    
    plot_data <- reshape2::melt(datan, id.var = c("n", "a", "cen"))
    p[[i]] <- ggplot2::ggplot(plot_data, aes(x = a, y = value, group = variable, shape = variable, colour = variable, lty = variable)) +
      geom_line() +
      geom_point() +
      scale_colour_discrete(name  ="",
                            breaks=c("kmeans", "kmedians"),
                            labels=c(expression('D'[CM]), expression('D'[KS]))) +
      scale_shape_discrete(name  ="",
                           breaks=c("kmeans", "kmedians"),
                           labels=c(expression('D'[CM]), expression('D'[KS]))) +
      scale_linetype_discrete(name  ="",
                              breaks=c("kmeans", "kmedians"),
                              labels=c(expression('D'[CM]), expression('D'[KS]))) +
      scale_colour_manual(name = "",
                          values= c('black', 'darkgrey'),
                          breaks=c("kmeans", "kmedians"),
                          labels=c(expression('D'[CM]), expression('D'[KS]))) +
      geom_hline(yintercept = 0.05, col = "red") +
      ylab("Power") +
      xlab("a")
    
  }
}




pdf("fig3.pdf", 7, 8)
p[[1]] + p[[2]] + p[[3]] + p[[4]] + p[[5]] + p[[6]] +
  plot_layout(ncol = 2, byrow = FALSE)
dev.off()




