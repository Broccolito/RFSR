# if(!file.exists("Imagefiles")){
#   dir.create("Imagefiles")
# }
# getinto("imagefiles")
# file.remove(list.files())
# getback()
# opendir("Imagefiles")
# getinto("Imagefiles")
# 
# if(length(list.files(pattern = "tif")) == 0){
#   stop("Please load the cell images into the folder...\n")
# }
# 
# setwd(here())