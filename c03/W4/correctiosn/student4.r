#Define used library
require("data.table")
require("dplyr")
library(data.table)
library(plyr)

#Read supporting metadata to variables 'featureNames' and 'activityLabels'
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Read training data to variables
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#Read test data to variables
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

#Do part 1 - Merge the training and the test sets to create one data set

#Combine results in training data set and test
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#Set the names for the columns from the metadata in featureNames
colnames(features) <- t(featureNames[2])

#Merge the data in 'features', 'activity' and 'subject' and the complete data is now stored in 'completeData'
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
#Create initial dataset
completeData <- cbind(features,activity,subject)

#Do part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

#Extract the column indices that have either mean or standard deviation (std) in them.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#Add activity and subject columns to the list and look at the dimension of 'completeData'
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
print( "The dimension of initial dataset" )
dim(completeData) 

#Create  new variable 'extractedData' with the selected columns in 'requiredColumns' and check the dimension of requiredColumns.
extractedData <- completeData[,requiredColumns]
print ( "The dimension of extracted dataset")
dim(extractedData)

#Do part 3 - Uses descriptive activity names to name the activities in the data set

#Change the type of 'activity' field in 'extractedData' from numeric to character. The activity names are taken from metadata activityLabels.
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
    extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

#We need to factor the activity variable, once the activity names are updated
extractedData$Activity <- as.factor(extractedData$Activity)

#Do part 4 - Appropriately labels the data set with descriptive variable names

#By examining extractedData, we can say that the acronyms should be replaced
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#Do part 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Firstly, set Subject as a factor variable
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#Create resultData as a data set with average for each activity and subject. Then, we order the enties in resultData 
#and write it into data file resultData.txt that contains the processed data.
resultData <- aggregate(. ~Subject + Activity, extractedData, mean)
resultData <- resultData[order(resultData$Subject,resultData$Activity),]
write.table(resultData, file = "resultData.txt", row.names = FALSE)