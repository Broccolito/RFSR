rm(list = ls())

#Set the working directory
here = "C:/Users/lenovo/Desktop/RFSR"
setwd(here)

#Run basic setup of the program
source("Setup.R")

#Define file_operatiion functions
source("File_operation.R")
#Working Directory: Main

#Load raw image
if(!file.exists("Imagefiles")){
  dir.create("Imagefiles")
}
getinto("imagefiles")
#file.remove(list.files())
setwd(here)
opendir("Imagefiles")
getinto("Imagefiles")

if(length(list.files(pattern = "tif")) == 0){
  stop("Please load the cell images into the folder...\n")
}else{
  setwd(here)
}

#Run statistical noice cancellation on the images
source("Noice_cancellation.R")
opendir("Denoiced Image")
  
#Load images into workspace
source("Load_image.R")
#After this script, the working directory is the main directory




