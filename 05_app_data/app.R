#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Code for the Application to real data section
# Author: Marta Sestelo
#------------------------------------------------------



library(mstate) # data from this package
library(clustcurv)

data("ebmt2") # loading data
table(ebmt2$cod) # causes of death


# Estimating the CIFs
out <- kcifcurves(time = ebmt2$time, status = ebmt2$status, x = NULL,
                  k = 1, kbin = 50, algorithm = "kmeans")

# Plotting the CIFs without grouping (Figure 5)
autoplot(out, groups_by_colour = FALSE) + 
  ggplot2::theme(legend.position="none")



# Testing the number of groups (Figure 6)
outtest <- survcifcurves(time = ebmt2$time, status = ebmt2$status, x = NULL,
                         kvector = NULL,  kbin = 50, nboot = 200,
                         algorithm = "kmeans", cluster = TRUE)

summary(outtest)
# Plotting the grouped CIFs 
autoplot(outtest) + 
  ggplot2::theme(legend.position="none")



