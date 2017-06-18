##Getting and Cleaning Data

###Course Project

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Download the data source and put in a folder on your local drive.
Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
Run source("run_analysis.R"), then it will generate a new file tidy_data.txt in your working directory.

###Dependencies
run_analysis.R file will help you to install the dependencies automatically. It depends on reshape2 and data.table.

###Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.

Downloading, unzipping and reading in all the dataset
Merging the training and the testing sets to create one data set
Extracting only the measurements on the mean and standard deviation for each measurement
Using descriptive activity names to name the activities in the data set
Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

dtTrain, dtActTrain, dtTest, dtActTest, dtSubTrain and dtSubTest contain the data from the downloaded files.
dtTrain, dtTest, dtSubject merge the previous datasets to become dt for further analysis.
features contains the correct names for the dt dataset, which are applied to the column names stored in dtfeat, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
Finally, dattidy contains the relevant averages which will be later stored in a .txt file. 
dcast() from the reshape2 package is used to apply mean and ease the development.
