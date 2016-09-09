## ===================================== ##
## CREATE PLOT NUMBER 3                  ##
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
png(file = "plot3.png", width = 480, height = 480)

## Creating Plot
plot(df2$dateTime, df2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df2$dateTime, df2$Sub_metering_2, type = "l", col = "red")
lines(df2$dateTime, df2$Sub_metering_3, type = "l", col = "blue")

## Add Legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2)

## Finish Plot
dev.off()