## ===================================== ##
## CREATE PLOT NUMBER 4                  ##
## ===================================== ##

## Donwload Data
downloadData()

## Read data, modify it and subset it if it does not exist
library(dplyr)
Sys.setlocale(locale = "uK")

df <- read.table("DATA/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
df2 <- filter(df, Date == "1/2/2007" | Date == "2/2/2007") %>% 
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
    mutate(dateTime = as.POSIXct(paste(Date, Time)))

## Start Ploting System
png(file = "plot4.png", width = 480, height = 480)

## Create Structure for plot
par(mfrow = c(2, 2),mar=c(4,4,2,1))

## Create first plot
plot(df2$dateTime, df2$Global_active_power, type = "l", xlab = "", ylab = "Global ACtive Power (kilowatts)")

## Create second plot
plot(df2$dateTime, df2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Create third plot
plot(df2$dateTime, df2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df2$dateTime, df2$Sub_metering_2, type = "l", col = "red")
lines(df2$dateTime, df2$Sub_metering_3, type = "l", col = "blue")

## Create forth plot
plot(df2$dateTime, df2$Global_reactive_power, type = "l", xlab = "datetame", ylab = "Global_reactive_power")

## Finish Plot
dev.off()
