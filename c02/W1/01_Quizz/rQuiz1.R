#read Data Frame
hw1 <- read.csv(file="C:/Users/sporras/Downloads/hw1_data.csv", header=T, sep=",")

#print first two rows
head(hw1, n=2)

#number of rows
nrow(hw1)

#last two rows of data frame
tail(hw1, n=2)

#Ozone value for 47th row
hw1[47, "Ozone"]

#NA values on Ozone column
nrow(hw1[is.na(hw1$Ozone), ])

#Mean Ozone
summary(hw1)
mean(hw1[!is.na(hw1$Ozone), "Ozone"])

#Mean Solar.R with ozone > 31 and Temp > 90
summary(hw1[hw1$Ozone > 31 & hw1$Temp > 90, ])
mean(hw1[!is.na(hw1$Solar.R) & !is.na(hw1$Ozone) & !is.na(hw1$Temp) & hw1$Ozone > 31 & hw1$Temp > 90, "Solar.R"])

#Mean of Temp when Month == 6
summary(hw1[hw1$Month == 6, ])
mean(hw1[!is.na(hw1$Month) & hw1$Month == 6, "Temp"])

#Maximum ozone value in month of May
summary(hw1[hw1$Month == 5, ])
max(hw1[!is.na(hw1$Ozone) & hw1$Month == 5, "Ozone"])