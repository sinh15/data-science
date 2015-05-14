corr <- function(directory, threshold = 0) {
  #Results Variable Declaration
  cVector <- vector("numeric", length = 0)
  cont <- 0

  #Loop for reading files
  for(i in 1:332) {
    if(i < 10) num <- paste("00", i, sep = "")
    else if(i < 100) num <- paste("0", i, sep = "")
    else num <- i
    df <- read.csv(file=paste(directory, "/", num, ".csv", sep = ""), header=T, sep=",")
    
    
    #Generate DF for threshold
    y <- complete.cases(df)
    if(length(y[y == TRUE]) >= threshold) {
      cont <- cont + 1
      cVector[cont] <- cor(df$sulfate, df$nitrate, use="pairwise.complete.obs")
    }
  }
  cVector
}