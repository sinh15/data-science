## Question 1
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, "communities.csv")
x <- read.csv("communities.csv")

# acres on variable ACR -> [3] greater or equal 10
# sales of agriclture AGS -> [6] +10.000

y <- which(x$ACR == 3 & x$AGS == 6)
y

## Question 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, "teacher2.jpg")
img <- readJPEG("teacher.jpg", native = TRUE)
quantile(img, probs=c(0.3,0.8))


## Question 3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, "gdp.csv")
gdp <- read.csv("gdp.csv")

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, "educ.csv")
educ <- read.csv("educ.csv")

gdp2 <- gdp[5:194, ]
gdp2[, 1] <- factor(gdp2[, 1])
sum(!is.na(match(gdp2[, 1], educ[, 1])))

gdp2$newrank <- as.numeric(as.character(gdp2[, 2]))
gdp2 <- gdp2[order(-gdp2$newrank), ]


## Question 4
gdp3 <- merge(gdp2, educ, by.x="X", by.y="CountryCode")
x <- gdp3[gdp3[, 13] == "High income: nonOECD", ]
y <- gdp3[gdp3[, 13] == "High income: OECD", ]
mean(x$newrank)
mean(y$newrank)


## Question 5
### Exampel to cut it in the 4th tipical breaks
gdp3$groups1 = cut(gdp3$newrank, breaks=quantile(gdp3$newrank))
table(gdp3$groups1, gdp3[, 13])

### Proper 5 breaks
install.packages("Hmisc")
library(Hmisc)
gdp3$groups2 = cut2(gdp3$newrank, g=5)
table(gdp3$groups2, gdp3[, 13])
