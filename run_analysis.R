##Merges the training and the test sets to create one data set.
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./smart.zip")
unzip ("./smart.zip", exdir = "./")
f <- file.path(getwd(),"UCI HAR Dataset")
list.files(f, recursive = TRUE)

dtSubTrain <- data.table(read.table(file.path(f, "train","subject_train.txt")))
dtSubTest <- data.table(read.table(file.path(f, "test", "subject_test.txt")))
dtActTrain <- data.table(read.table(file.path(f, "train", "Y_train.txt")))
dtActTest <- data.table(read.table(file.path(f, "test", "Y_test.txt")))
dtTrain <- data.table(read.table(file.path(f, "train", "X_train.txt")))
dtTest <- data.table(read.table(file.path(f, "test", "X_test.txt")))

### Merge subjects. Training subjects[1:2947] and testing subjects[2948:10299]
dtSubject <- rbind(dtSubTrain, dtSubTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActTrain, dtActTest)
setnames(dtActivity, "V1", "activityNum")
## Merge training and testing data 
dt <- rbind(dtTrain, dtTest)
dtSubject <- cbind(dtSubject, dtActivity)
dt <- cbind(dtSubject, dt)
setkey(dt, subject, activityNum)

## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
dtfeat <- fread(file.path(f,"features.txt"))
setnames(dtfeat, names(dtfeat), c("featureNum", "featureName"))
dtfeat <- dtfeat[grepl("mean\\(\\)|std\\(\\)", featureName)]
dtfeat$featureCode <- dtfeat[, paste0("V", featureNum)]
select <- c(key(dt), dtfeat$featureCode)
dt <- dt[, select, with = FALSE]


## 3 Uses descriptive activity names to name the activities in the data set
dtActNames <- fread(file.path(f,"activity_labels.txt"))
setnames(dtActNames, names(dtActNames), c("activityNum", "activityName"))
## merge data with activity names
dt <- merge(dt, dtActNames, by = "activityNum", all.x = TRUE)
setkey(dt, subject, activityNum, activityName)
## reshape the data 
## Appropriately labels the data set with descriptive variable names.

## From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
dattidy   = dcast(dt, subject + activityName ~ featureName, mean)
write.table(dattidy, file = "./tidy_data.txt")








