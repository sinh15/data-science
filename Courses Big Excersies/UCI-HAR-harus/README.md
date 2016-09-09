README
======

# HARUS Introduction

The main point of this document is to dsecribe how the `run_analysis.R` script that can be found on this respository works.

The goal of the script was to transform the RAW data coming from the [UCI HAR Datastet](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a TINY dataset that contains for each pair of: `acitity` and `subject`: the mean of all the observations for some variables (the ones that registered the mean() and std() of the whole dataset).


# run_analysis.R

This scripts works as a single piece of code that transforms the raw data of the `UCI HAR Dataset` into the above described dataset and stores it in a .txt file called `tidy_harus.txt`.

HARUS Stands for: Human Activity Recognition Using Smartphones

The script is divided in 6 parts:

- **Loads:** Loads the required libraries to run the script. If you don`t have some of them installed, plese do it with the following commands:

```R
install.packages("plyr")
install.packages("dplyr")
```

- **Step 0:** This step checks if a folder exists on your Working Directory with the name `UCI HAR Dataset`. If it does not exist it downloads the data and extracts it in your current working directory.

- **Step 1:** Reads all the train & test data and combines it in a single dataframe. We called it `harus`.

- **Step 2:** We wanted to manipualte only the mean() and std() parameters of each variable. This part removes a lot of variables (columns) from the `harus` dataset leaving it with only 66 paremetrs, an Activity and a Subject. Making up for the total columns number of 68.

- **Step 3:** Swap the current activity names, described as an integer, for the proper activity name stored in the `activity_labels.txt` file.

- **Step 4:** At the moment the dataset was using as variables names the ones stored on the `features.txt` file. In this step we modify them a little bit to be more human readable. Basically, we separate each concept on the name.

- **Step 5:** Transforms the dataframe to have `the mean of each variable (column)` per each `activity and subject`. This step simplifies the dataframe decreasing its number of rows from 10.299 to 180 (6 activities * 30 participants). Finally it stores the table into a file called: `tidy_harus.txt`.


# How to Run the Script

Asuming that your working directory is the same as the script is located on, you can easily run the script with the command:

```R
source("run_analysis.R")
```

If not, you can select all the code on the file and click the run button. 
NOTE: The data will be downloaded on your working directory, not the directory where the file is located.


# Code Book

You can find a better description of the output dataset and its variables on the `CodeBook.md` file.

