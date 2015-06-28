cleanup <- function() {
    
    # check if the UCI data exists. if not create a directory and downloaded
    # the file. unzip file into directory. 
    if(!file.exists("./UCIdata")) {
        dir.create("./UCIdata")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./UCIdata/dataset.zip")
        unzip ("./UCIdata/dataset.zip", exdir = "./UCIdata")
    }
    
    # read files test, train and features data into tables
    
    features <- read.table("./UCIdata/UCI HAR Dataset/features.txt")
    
    test_results <- read.table("./UCIdata/UCI HAR Dataset/test/X_test.txt")
    test_activities <- read.table("./UCIdata/UCI HAR Dataset/test/y_test.txt")
    test_subjects <- read.table("./UCIdata/UCI HAR Dataset/test/subject_test.txt")
    
    train_results <- read.table("./UCIdata/UCI HAR Dataset/train/X_train.txt")
    train_activities <- read.table("./UCIdata/UCI HAR Dataset/train/y_train.txt")
    train_subjects <- read.table("./UCIdata/UCI HAR Dataset/train/subject_train.txt")
    
    # combine the dataframes into one dataframe with column names from features.txt
    # merge in participant and activity data as additional columns
    
    # test data: 2947 observations
    test_results <- cbind(test_results, test_activities)
    test_results <- cbind(test_results, test_subjects)
    colnames(test_data) <- features[,2]
    colnames(test_data)[562:563] <- c('activity', 'subject')
    
    # train data: 7352 observations
    train_data <- cbind(train_results, train_activities)
    train_data <- cbind(train_data, train_subjects)
    colnames(train_data) <- features[,2]
    colnames(train_data)[562:563] <- c('activity', 'subject')
    
    # final full dataframe
    all_data <- rbind(test_data, train_data)
    
    # transform all column names to lower text for easier grep expressions
    colnames(all_data) <- tolower(colnames(all_data))
    
    # create index of column names that contains the words mean, 
    # std, subject or activity
    # then subset the data based on this index
    index <- grep("mean|std|subject|activity", 
                  colnames(all_data), value = FALSE)
    data_subset <- all_data[,index]
    
    # replace activity numbers with labels 
    labels <- read.table("./UCIdata/UCI HAR Dataset/activity_labels.txt")
    colnames(labels) <- c("activity", "activity_name")
    data_subset$activity = labels[match(data_subset$activity, labels$activity), "activity_name"]
    
    # count columns and take 2 off for activity and subject columns
    # this is for aggregating all data by the average for each subject per activity
    # need to remove activity and subject columns from this aggregate
    column_count <- ncol(data_subset)-2
    
    # aggregate the data by average per activty and subject
    agg_data <- aggregate(data_subset[,1:column_count], by=list(data_subset$activity, data_subset$subject),  FUN=mean)
    
    # write a table of the tidied dataset
    write.table(agg_data, file = "./UCIdata/tidydata.txt", row.names = FALSE)
    
    # return the aggregated data only
    return (agg_data)
}
