#Load the image data into workspace

#Make sure the current work directory is the one with 
#To-be-processed images

require(EBImage)
setwd(here)

getinto("Denoiced Image")

filelist = list.files(pattern = "tif")
for(i in 1:length(filelist)){
  eval(parse(text = paste(
    "image_file_object_", i, " = readImage(filelist[", i, "])",
    sep = ""
    )))
}

for(i in 1:length(filelist)){
  eval(parse(text = paste(
    "image_data_matrix_", i, " = imageData(readImage(filelist[", i, "]))",
    sep = ""
  )))
}

for(i in 1:length(filelist)){
  eval(parse(text = paste(
    "image_data_frame_", i, " = imageData(readImage(filelist[", i, "]))",
    sep = ""
  )))
}
#At this step, the "iamge_data_frames" are actually matrices...


#For each image file, a data frame with information of
#every single pixel will be generated
for(i in 1:length(filelist)){
  cat(paste("Processing Image ", i, "\n", sep = ""))
  
  #Create temporary image data frame
  cat("Generating Temporary image data frame...\n")
  eval(parse(text = paste(
    "temp_image_data_frame = as.vector(image_data_frame_", i, ")",
    sep = ""
  )))
  
  #For each temporary data frame, make single image data variable
  cat("Making single image data variable...\n")
  for(j in 1:length(temp_image_data_frame)){
    eval(parse(text = paste(
      "single_image_data_variable_", j, " = temp_image_data_frame[",j ,"]",
      sep = ""
    )))
  }
  
  #Compile each single variable into the new image data frame
  cat("Compiling new data frame...\n")
  pat = "single_image_data_variable"
  eval(parse(text = paste(
    "image_data_frame_",i, " = data.frame(lapply(ls(pattern = pat), get))",
    sep = ""
  )))
  
  #Name the columns of the data frames
  delimit = "_"
  pixel = "pixel"
  eval(parse(text = paste(
    "colnames(image_data_frame_",
    i,
    ") = paste(pixel, as.character(1:length(image_data_matrix_",
    i,
    ")), sep = delimit)",
    sep = ""
  )))
  cat(paste("Finished Processing Image ", i, "\n", sep = ""))
}

rm(list = ls(pattern = "single_image_data_variable"))
print(ls(pattern = "image_file_object"))

#Return to the main manu
setwd(here())