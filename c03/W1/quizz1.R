## Instructions for question 1
## read.csv automatically sets header=T sep=,
data <- read.csv(file="getdata-data-ss06hid.csv", header=T, sep=",")
data2 <- data[!is.na(data$VAL), ]
nrow(data2[data2$VAL == 24, ])


## Instructions for question 3
fileName = "getdata-data-DATA.gov_NGAP.xlsx"
rowindex = 18:23
colindex = 7:15
data3 <- read.xlsx(fileName, 1, rowIndex=rowindex, colIndex=colindex, header=TRUE)
sum(data3$Zip*data3$Ext,na.rm=T) ## 36534720


## Instructions for question 4
install.packages("XML")
library(XML)
?xmlTreeParse
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# we could use htmlTreeParse if it was html and useInternal = TRUE
data4 <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
    ## start browsing data
    rootNode <- xmlRoot(data4)
    names(rootNode)
    ##we go one level more deep
    rootNode <- rootNode[[1]]
    names(rootNode)
    ## similar to lapply / sapply but for xml
    zipCodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
    table(zipCodes) ## and search for it
    sum(zipCodes == 21231) ## 127


## Instructions for question 5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, "housingIdaho.csv")
data5 <- fread("housingIdaho.csv")