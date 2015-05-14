complete <- function(directory, id = 1:332) {
  #Results Variable Declaration
  df2 <- data.frame()
  
  #Loop for reading files
  for(i in seq_along(id)) {
    if(id[i] < 10) num <- paste("00", id[i], sep = "")
    else if(id[i] < 100) num <- paste("0", id[i], sep = "")
    else num <- id[i]
    df <- read.csv(file=paste(directory, "/", num, ".csv", sep = ""), header=T, sep=",")
    
    #Generate New Line in Data Frame
    y <- complete.cases(df)
    rowData <- c(i, length(y[y == TRUE]))
    df2 <- rbind(df2, rowData)
  }
  names(df2) <- c("id", "nobs")
  df2
}