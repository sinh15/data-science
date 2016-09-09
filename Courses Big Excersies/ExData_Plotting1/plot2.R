## ===================================== ##
## CREATE PLOT NUMBER 2                  ##
## ===================================== ##

## download Data if required
if(!file.exists("DATA")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, "data.zip")
    unzip("data.zip", exdir = "DATA")
}

## Read data, modify it and subset it if it does not exist
library(dplyr)
Sys.setlocale(locale = "uK")

df <- read.table("DATA/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
df2 <- filter(df, Date == "1/2/2007" | Date == "2/2/2007") %>% 
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
    mutate(dateTime = as.POSIXct(paste(Date, Time)))

## Start Ploting System
png(file = "plot2.png", width = 480, height = 480)

## Creating Plot
plot(df2$dateTime, df2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Finish Plot
dev.off()
