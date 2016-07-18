/usr/bin/R CMD BATCH document.R
#/usr/bin/R CMD build ../../ --no-build-vignettes
/usr/bin/R CMD build ../../ 
/usr/bin/R CMD check --as-cran rwfs_0.1.14.tar.gz
/usr/bin/R CMD INSTALL rwfs_0.1.14.tar.gz
#/usr/bin/R CMD BATCH document.R

