## QUESTION 1
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, "acs.csv")
data <- read.csv("acs.csv")
names(data)

x <- strsplit(names(data), "wgtp")
x[[123]]


## QUESTION 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, "gdp.csv")
data <- read.csv("gdp.csv")
data <- data[5:194, ]
View(data)

# remove from variable X.3 the commas and compute mean
mean(as.numeric(gsub(",", "", data[, "X.3"])))


## QUESTION 3
table(grepl("^United", data[, "X.2"]))


## QUESTION 4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, "gdp2.csv")
data <- read.csv("gdp2.csv")
data <- data[5:194, ]

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, "educ.csv")
data2 <- read.csv("educ.csv")

merged <- merge(data, data2, by.x="X", by.y="CountryCode")

# to find the column that contains the fuckin' month
apply(merged, 2, function(x) sum((grepl("June", x))))

# compute ends of fiscal year in june
table(grepl("Fiscal year end: June", merged[, "Special.Notes"]))


## QUESTION 5
# quantum data
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

df <- data.frame("dates" = sampleTimes, "years" = format(sampleTimes, "%Y"), "weekday" = weekdays(sampleTimes))
nrow(df[df$years == "2012", ])
nrow(df[df$years == "2012" & df$weekday == "lunes", ])

