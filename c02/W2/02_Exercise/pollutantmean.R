pollutantmean <- function(directory = "C:/Users/sporras/Documents/GitHub/data-science/c02/W2/02_Exercise/specdata/", pollutant, id = 1:332) {
  tMeans <- vector("numeric")
  df2 <- data.frame();
  for(i in seq_along(id)) {
    if(id[i] < 10) num <- paste("00", id[i], sep = "")
    else if(id[i] < 100) num <- paste("0", id[i], sep = "")
    else num <- id[i]
    df <- read.csv(file=paste(directory, num, ".csv", sep = ""), header=T, sep=",")
    df2 <- rbind(df2, df[!is.na(df$nitrate), ])
  }
  mean(df2$nitrate)
}