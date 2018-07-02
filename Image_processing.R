#In order to get the picture with 1/(2^n) the pixel count,
#Input times as 2
#Default Value: Times = 2
shrink_pic = function(picture, times = 2){
  imageData(picture) = imageData(picture)[
    -seq(1,dim(imageData(picture))[1], times),
    -seq(1,dim(imageData(picture))[2], times)]
  return(picture)
}

#This function can double the length of the 
#Dimensions of the picture
enlarge_pic = function(picture){
  dimension = dim(imageData(picture))
  tempmat = matrix(-1, nrow = dimension[1] * 2,
                   ncol = dimension[2] * 2)
  for(i in 1:dimension[1]){
    for(j in 1:dimension[2]){
      tempmat[(2*i-1):(2*i), (2*j-1):(2*j)] = imageData(picture)[i,j]
    }
  }
  imageData(picture) = tempmat
  display(picture)
  return(picture)
}

