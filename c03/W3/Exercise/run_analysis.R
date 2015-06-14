# ------------------------------------------------------------------------------------------ #
# LOADS: Required Libraries
# ------------------------------------------------------------------------------------------ #
library(plyr)
library(dplyr)

# ------------------------------------------------------------------------------------------ #
# STEP 0: Download & Extract the data
# ------------------------------------------------------------------------------------------ #
if(!file.exists("UCI HAR Dataset")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "harus.zip")
    unzip("harus.zip")
}


# ------------------------------------------------------------------------------------------ #
# STEP 1: Merge the trainingn and the test to create one data set
# ------------------------------------------------------------------------------------------ #

# Read Train Files
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
trainS <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read Test Files
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
testS <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Fusion the columns for Train & Test coming from diffrent files
# X Files: Variables measuerd
# Y Files: Activity measured
# S Files: Subject measured
trainData <- cbind(trainX, trainY, trainS)
testData <- cbind(testX, testY, testS)

# Fusion the train data set and the test data set. Create just one list of entries.
# harus (stands for): Human Activity Recognition Using Smartphones
harus <- rbind(trainData, testData)


# ------------------------------------------------------------------------------------------ #
# STEP 2: Extracts only the measurements on the mean and std. deviation for each measurement #
# ------------------------------------------------------------------------------------------ #

# The table features contains:
# features[, 1] -> Variable ID (from 1 to 561)
# features[, 2] -> human readable name for the variable
features <- read.table("UCI HAR Dataset/features.txt")

# Activity & Subject at the end in this order because is how we rbind'ed them.
# Coerce to vector required to get rid of Data Frame Format (Factor)
newColNames <- c(as.vector(features[, 2]), "activity", "subject")

# Assign names to harus & extract measurements that contain: mean(), std(), activity, subject
names(harus) <- newColNames
harus <- harus[, grepl(("mean\\(\\)|std\\(\\)|subject|activity"), names(harus))]


# ------------------------------------------------------------------------------------------ #
# STEP 3: Uses descriptive activity names to name the activities in the data set             #
# ------------------------------------------------------------------------------------------ #

# We read the activity names from the file and change them
actNames <- read.table("UCI HAR Dataset/activity_labels.txt")
for(i in 1:nrow(actNames)) harus$activity[harus$activity == i] <- as.character(actNames[i, 2])


# ------------------------------------------------------------------------------------------ #
# STEP 4: Appropriately labels the data set with descriptive variable names                  #
# ------------------------------------------------------------------------------------------ #

# The current data set already has quite human readable names. (ones from features.txt)
# we're just gonna apply minor changes.
cVarNames <- names(harus)

# get rid of "(" and ")" on mean() and std() metrics
cVarNames <- gsub("\\(\\)", "", cVarNames)

# Create spaces between concepts in variable names
# not really necessary but nice to have
cVarNames <- gsub("^t", "time-", cVarNames)
cVarNames <- gsub("^f", "freq-", cVarNames)
cVarNames <- gsub("Acc", "-Accelerometer", cVarNames)
cVarNames <- gsub("Jerk", "-Jerk", cVarNames)
cVarNames <- gsub("Gyro", "-Gyroscope", cVarNames)
cVarNames <- gsub("Mag", "-Mag", cVarNames)

# Removal of BodyBody concepts repeated
cVarNames <- gsub("BodyBody", "Body", cVarNames)

# Assign new names to harus
names(harus) <- cVarNames


# ------------------------------------------------------------------------------------------ #
# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the  #
#         average of each variable for each activity and each subject                        #
# ------------------------------------------------------------------------------------------ #

# New Data Set tidyHarus
tidyHarus <- group_by(harus, activity, subject) %>% summarise_each(funs(mean))

# Print data int oa file
write.table(tidyHarus, file="tidy_harus.txt", row.name=FALSE)
View(tidyHarus)
