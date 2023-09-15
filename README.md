## R code for the manuscript "A method for determining groups in cumulative incidence curves in competing risk data" (Marta Sestelo, Luís Meira-Machado, Nora M. Villanueva  and Javier Roca-Pardiñas)

Code was written Marta Sestelo. In case of questions or comments please contact <sestelo@uvigo.es>


This GitHub repository contains all the routines required to reproduce the simulation, tables, figures and application to real data of the paper entitled “A method for determining groups in cumulative incidence curves in competing risk data”. The repository is structured in five folders: 01_code_sims, 02_outpus_sims, 03_tables, 04_figures and 05_app_data.

In order to run the cited routines, it is needed to install the clustcurv package from GitHub (CIF branch). At this moment, the package on CRAN does not contain this methodology. The code for installing the version from GitHub is:

```library(devtools)
install_github("noramvillanueva/clustcurv", ref = "CIF")```

It is important to mention that the code of de simulations (01_code_sims folder) is written to be run in a server using a job array file .sh. In our case, we use the Finisterrae III - https://www.cesga.es/en/infrastructures/computing/).

Note also that the .sh file of each experiment contains the code using the K-means algorithm. If you want to simulate and test with the K-medians algorithm you have to change this input parameter. 



Information about the R Session:

> sessionInfo()
R version 4.2.2 (2022-10-31)
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Ventura 13.5.2

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets 
[6] methods   base     

other attached packages:
[1] doRNG_1.8.2          rngtools_1.5.2      
[3] foreach_1.5.2        clustcurv_2.0.1.0001
[5] mstate_0.3.2         survival_3.4-0      

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.0   shinyjs_2.1.0      purrr_0.3.4       
 [4] splines_4.2.2      lattice_0.20-45    colorspace_2.1-0  
 [7] vctrs_0.6.0        generics_0.1.3     npregfast_1.5.2   
[10] mgcv_1.8-41        utf8_1.2.3         rlang_1.1.0       
[13] pillar_1.8.1       glue_1.6.2         withr_2.5.0       
[16] DBI_1.1.3          RColorBrewer_1.1-3 ggfortify_0.4.14  
[19] Gmedian_1.2.7      lifecycle_1.0.3    robustbase_0.95-0 
[22] stringr_1.4.0      munsell_0.5.0      gtable_0.3.1      
[25] codetools_0.2-18   labeling_0.4.2     doParallel_1.0.17 
[28] parallel_4.2.2     fansi_1.0.4        DEoptimR_1.0-11   
[31] Rcpp_1.0.10        scales_1.2.1       farver_2.1.1      
[34] RSpectra_0.16-1    gridExtra_2.3      ggplot2_3.4.1     
[37] digest_0.6.29      stringi_1.7.6      dplyr_1.1.0       
[40] grid_4.2.2         cli_3.6.0          tools_4.2.2       
[43] magrittr_2.0.3     tibble_3.2.0       wesanderson_0.3.6 
[46] tidyr_1.2.0        pkgconfig_2.0.3    Matrix_1.5-1      
[49] data.table_1.14.2  rstudioapi_0.14    iterators_1.0.14  
[52] R6_2.5.1           sfsmisc_1.1-13     nlme_3.1-160      
[55] compiler_4.2.2  
