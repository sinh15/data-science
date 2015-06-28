##Set path to dataset folder
## Loading required library
library(plyr)
library(data.table)

## 1) Merges the training and the test sets to create one data set
activityLab <- read.table("activity_labels.txt", header= FALSE)
featureLab <- read.table("Features.txt")

## Reading Training datasets 

subjectTrain <- read.table("train/subject_train.txt", header= FALSE)
featureTrain <- read.table("train/X_train.txt", header= FALSE)
activityTrain <- read.table("train/Y_train.txt", header= FALSE)

### Reading Testing dataset


subjectTest <- read.table("test/subject_test.txt", header= FALSE)
featureTest <- read.table("test/X_test.txt", header= FALSE)
activityTest <- read.table("test/Y_test.txt", header= FALSE)

## combining the Training and testing data
subject <- rbind(subjectTrain,subjectTest)
feature <- rbind (featureTrain,featureTest)
activity <- rbind(activityTrain,activityTest)

colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
colnames(feature) <- t(featureLab[2])

alldata <- cbind(feature,activity,subject)

### 2). Extracts only the measurements on the mean and standard deviation for each measurement. 

MSColumns <- grep(".*Mean.*|.*Std.*", names(alldata), ignore.case=TRUE)
columnsRequire <- c(MSColumns,562,563)

filterData <- alldata[ ,columnsRequire]

#### 3).Uses descriptive activity names to name the activities in the data set

filterData$Activity <- as.character(filterData$Activity)

for ( i in 1:6) {
    filterData$Activity [filterData$Activity == i] <- as.character(activityLab[i,2])
}

filterData$Activity <- as.factor(filterData$Activity)

## 4). Appropriately labels the data set with descriptive variable names.

names(filterData) <- gsub("^t", "Time" ,names(filterData))
names(filterData) <- gsub("Gyro", "Gyroscope" ,names(filterData))
names(filterData) <- gsub("^f", "Frequency" ,names(filterData))
names(filterData) <- gsub("Acc", "Accelerometer" ,names(filterData))
names(filterData) <- gsub("BodyBody", "Body" ,names(filterData))
names(filterData) <- gsub("Mag", "Magnitude" ,names(filterData))
names(filterData) <- gsub("angle", "Angle", names(filterData))

filterData$Subject <- as.factor(filterData$Subject) 
filterData <- data.table(filterData)

## 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata <- aggregate(. ~Subject + Activity, filterData, mean)
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file= "Tidy.txt",row.names = FALSE)