CodeBook for the UCI HAR Tidy Dataset
=====================================

# Quick introduction to the dataset

This CodeBook describes the variables created by the `run_analysis.R` script.

This tidy Dataset is formed 68 columns and 180 rows. Each column represents a different measure and each row a different observation.

The output dataset has the mean average value for each measure grouped by `activity` and `subject`.

The 180 rows are formed by the following conditions:

- 6 Different Activities
- 30 Different Subjects

Multiplying these two values we get the total number of observations, 180 (6*30).

The 68 columns are formed by:

- Activity Column
- Subject Column
- 66 Different measures


# Variables Explanation

activity    [1]
- CHARACTER: Activity Name
- Values: 'LAYING', 'SITTING', 'STANDING', 'WALKING', 'WALKING_DOWNSTAIRS', 'WALKING_UPSTAIRS'
        
subject     [2]
- INTEGER: Subject
- Values: 01..30 .Numeric identifier of the subject
        
Variables   [3..68]
- NUMERIC: Mean of each different measurement.
- Column Names: time-Body-Accelerometer-mean-X, time-Body-Accelerometer-mean-Y, time-Body-Accelerometer-mean-Z, time-Body-Accelerometer-std-X, time-Body-Accelerometer-std-Y, time-Body-Accelerometer-std-Z, time-Gravity-Accelerometer-mean-X, time-Gravity-Accelerometer-mean-Y, time-Gravity-Accelerometer-mean-Z, time-Gravity-Accelerometer-std-X, time-Gravity-Accelerometer-std-Y, time-Gravity-Accelerometer-std-Z, time-Body-Accelerometer-Jerk-mean-X, time-Body-Accelerometer-Jerk-mean-Y, time-Body-Accelerometer-Jerk-mean-Z, time-Body-Accelerometer-Jerk-std-X, time-Body-Accelerometer-Jerk-std-Y, time-Body-Accelerometer-Jerk-std-Z, time-Body-Gyroscope-mean-X, time-Body-Gyroscope-mean-Y, time-Body-Gyroscope-mean-Z, time-Body-Gyroscope-std-X, time-Body-Gyroscope-std-Y, time-Body-Gyroscope-std-Z, time-Body-Gyroscope-Jerk-mean-X, time-Body-Gyroscope-Jerk-mean-Y, time-Body-Gyroscope-Jerk-mean-Z, time-Body-Gyroscope-Jerk-std-X, time-Body-Gyroscope-Jerk-std-Y, time-Body-Gyroscope-Jerk-std-Z, time-Body-Accelerometer-Mag-mean, time-Body-Accelerometer-Mag-std, time-Gravity-Accelerometer-Mag-mean, time-Gravity-Accelerometer-Mag-std, time-Body-Accelerometer-Jerk-Mag-mean, time-Body-Accelerometer-Jerk-Mag-std, time-Body-Gyroscope-Mag-mean, time-Body-Gyroscope-Mag-std, time-Body-Gyroscope-Jerk-Mag-mean, time-Body-Gyroscope-Jerk-Mag-std, freq-Body-Accelerometer-mean-X, freq-Body-Accelerometer-mean-Y, freq-Body-Accelerometer-mean-Z, freq-Body-Accelerometer-std-X, freq-Body-Accelerometer-std-Y, freq-Body-Accelerometer-std-Z, freq-Body-Accelerometer-Jerk-mean-X, freq-Body-Accelerometer-Jerk-mean-Y, freq-Body-Accelerometer-Jerk-mean-Z, freq-Body-Accelerometer-Jerk-std-X, freq-Body-Accelerometer-Jerk-std-Y, freq-Body-Accelerometer-Jerk-std-Z, freq-Body-Gyroscope-mean-X, freq-Body-Gyroscope-mean-Y, freq-Body-Gyroscope-mean-Z, freq-Body-Gyroscope-std-X, freq-Body-Gyroscope-std-Y, freq-Body-Gyroscope-std-Z, freq-Body-Accelerometer-Mag-mean, freq-Body-Accelerometer-Mag-std, freq-Body-Accelerometer-Jerk-Mag-mean, freq-Body-Accelerometer-Jerk-Mag-std, freq-Body-Gyroscope-Mag-mean, freq-Body-Gyroscope-Mag-std, freq-Body-Gyroscope-Jerk-Mag-mean, freq-Body-Gyroscope-Jerk-Mag-std


You can also find the full list of variable names with the following R command once the `run_analysis.R` script has been run.

```R
names(tidyHarus)
```

For further information on what each variable represents (bear in mind that the names have been modified) please concult the originals `features_info.txt` and `features.txt` documents.
        