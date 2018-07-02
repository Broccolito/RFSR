#Working Directory must be the one with original picture files

#The script is dependent on Fileoperation script

#Define P_value
# pvalue = readline("Please Input the p_value for Noice Cancellation: ")
# if(length(pvalue) == 0){
#   rm(pvalue)
# }else{
#   if(is.na(as.numeric(pvalue))){
#     rm(pvalue)
#   }else{
#     pvalue = as.numeric(pvalue)
#     if(all(pvalue<1, pvalue>0)){
#       p_value = pvalue
#       rm(pvalue)
#     }
#   }
# }

require(EBImage)
setwd(here)

getinto("Imagefiles")
filelist = list.files(pattern = "tif")

#Read the Images
pics = readImage(files = filelist)

#Get data from the Image
imageData = function(image){
  if(class(image) != "Image"){
    return("The input is not a EBImage object")
  }else{
    return(image@.Data)
  }
}

#Statistical Noice Cancellation of the images

#If the p_value is not pre_difined, the program
#shall use the default p_value 0.2
if(length(ls(pattern = "p_value")) == 0){
  p_value = 1
}
p_value = 0.5

imageData(pics[1:dim(pics)[1],1:dim(pics)[2],])[
  imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]) <= 
    quantile(imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]), p_value)] = 0

#Statistical Intensity Enhancement

scale = (1/max(imageData(pics)))

imageData(pics[1:dim(pics)[1],1:dim(pics)[2],])[
  imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]) >= 
    quantile(imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]), 1-p_value)] =
  (1/max(imageData(pics))) * (
    imageData(pics[1:dim(pics)[1],1:dim(pics)[2],])[
      imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]) >= 
        quantile(imageData(pics[1:dim(pics)[1],1:dim(pics)[2],]), 1-p_value)]
    )

cat(paste("The scale of the image set is: ", scale, "\n", sep = ""))

#Return to the Main directory
setwd(here)

if(!file.exists("Denoiced Image")){
  dir.create(path = "Denoiced Image")
}

getinto("Denoiced Image")

#Creates new images that has undergone noice cancellation and/or
#Intensity enhancement
filenames = paste(as.character(seq(1,dim(pics)[3],1)), ".tif", sep = "")
writeImage(x = pics, files = filenames)

setwd(here)