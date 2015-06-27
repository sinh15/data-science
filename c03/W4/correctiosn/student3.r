# Coursera - Getting and Cleaning Data
## Course Project
library(plyr)

unzip("UCI HAR Dataset.zip", overwrite=TRUE)

setwd("./UCI HAR Dataset") # set working directory
#read dataset
activities <- read.table("activity_labels.txt", header=FALSE)
features <- read.table("features.txt", header=FALSE)
subject_test <- read.table("test/subject_test.txt", header=FALSE)
x_test <- read.table("test/X_test.txt", header=FALSE)
y_test <- read.table("test/y_test.txt", header=FALSE)
subject_train <- read.table("train/subject_train.txt", header=FALSE)
x_train <- read.table("train/X_train.txt", header=FALSE)
y_train <- read.table("train/y_train.txt", header=FALSE)

names(activities) <- c("activity_id", "Activity")
names(features) <- c("features_id", "features")
names(x_test) <- features$features
names(y_test) <- "activity_id"
names(subject_test) <- "Subject"
names(x_train) <- features$features
names(y_train) <- "activity_id"
names(subject_train) <- "Subject"


### 1. Merge the training and the test sets to create one data set.

test_data <- cbind(subject_test, y_test, x_test)
train_data <- cbind(subject_train, y_train, x_train)
har_data <- rbind(train_data, test_data)
#clean memory
rm(x_test, y_test, subject_test, test_data, x_train, y_train, subject_train, train_data)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_features_names_lst <- features$features[grep("mean\\(\\)|std\\(\\)", features$features)]
names_lst <- c("Subject", "activity_id", as.character(mean_std_features_names_lst))
mean_har_data <- har_data[, names_lst]


### 3. Uses descriptive activity names to name the activities in the data set

acti_mean_har_data <- merge(mean_har_data, activities, by="activity_id", all.x=TRUE)
acti_mean_har_data <- acti_mean_har_data[,-c(1)] # delete activity_id


### 4. Appropriately labels the data set with descriptive variable names. 

names(acti_mean_har_data) <- gsub("^f", "Frequency", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("^t", "Time", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("Acc", "Accelerometer", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("([Bb]ody[Bb]ody | [Bb]ody)", "Body", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("([Gg]ravity)", "Gravity", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("[Gg]yro", "Gyroscope", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("Mag", "Magnitude", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("-mean", "Mean", names(acti_mean_har_data))
names(acti_mean_har_data) <- gsub("-std", "StdDev", names(acti_mean_har_data))


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data <- aggregate(. ~Subject + Activity, acti_mean_har_data, mean)
tidy_data <- tidy_data[order(tidy_data$Subject, tidy_data$Activity),]
setwd("../")
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE, sep=",")