#Gathering packages in need
if(!require(here)){
  install.packages("here")
}
require(here)

if(!require(EBImage)){
  source("http://bioconductor.org/biocLite.R")
  biocLite("EBImage")
  #Maybe it is not in the CRAN packages anymore
  #install.packages("EBImage")
}
require(EBImage)
if(!require(randomForest)){
  install.packages("randomForest")
}
require(randomForest)

