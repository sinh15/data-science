## ===================================== ##
## CREATE PLOT NUMBER 1                  ##
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
png(file = "plot1.png", width = 480, height = 480)

## Creating Plot
hist(df2$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Finish Plot
dev.off()