##run_analysis.R - Fielding Isaacs 2021
##Getting and Cleaning Data Course Project
##Coursera Getting and Cleaning Data

#L - Include Libraries
library(dplyr)
library(tidyr)
#0   - Get the data and read it in.

#0.1 - Change working directory

if(getwd() != "data") {
  print("Changing directory to data/")
  setwd("data")
} else {
  errorCondition("Unable to set correct directory, launch from project root.")
}

#0.2 - Download the file if it doesn't already exist

if(!file.exists("Dataset.zip")) {
  print("Downloading Data set")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              method="curl",
              destfile = "Dataset.zip")
} else {
  print("Data set already exists")
}

#0.3 - Unzip the file if it hasn't already been done

if(file.exists("Dataset.zip")) {
  if(!file.exists("UCI HAR Dataset")) {
    print("Unzipping Data set")
    unzip("Dataset.zip")
  } else {
    print("Data set already unzipped.")
  }
} else {
  errorCondition("Data Set not downloaded, something is wrong, exiting.")
}

#0.4 - Read features and activity labels

setwd("UCI HAR Dataset")
features <- read.table("features.txt")
actLabels <- read.table("activity_labels.txt",sep=" ")

#0.5 - Read in the training data

print("Reading in training data")

setwd("train")
trainY <- read.table("y_train.txt")
trainX <- read.table("X_train.txt")
trainS <- read.table("subject_train.txt")
setwd("..")

#0.6 - Read in the test data

print("Reading in testing data")

setwd("test")
testY <- read.table("y_test.txt")
testX <- read.table("X_test.txt")
testS <- read.table("subject_test.txt")
setwd("..")

#0.7 - Restore the working directory

print("Changing directory to project root")
setwd("..")
setwd("..")
presDir <- getwd()
print(paste0("Should be in project root, now in: ", presDir))

#1   - Merge the training and test sets

print("Merging test and training sets")

#1.1 - Assign feature names to training data columns

print("Assigning Column Names to training sets")
names(trainX) <- features[,2]
names(trainY) <- "Activity"
names(trainS) <- "Subject"

#1.2 - Assign feature names to test data columns

print("Assigning Column Names to test sets")
names(testX) <- features[,2]
names(testY) <- "Activity"
names(testS) <- "Subject"

#1.3 - Bind subject IDs to training data

print("Binding training columns")
trainSYX <- cbind(trainS,trainY,trainX,deparse.level = 1)

#1.4 - Bind subject IDs to test data

print("Binding test columns")
testSYX <- cbind(testS,testY,testX,deparse.level = 1)

#1.5 - merge data sets

print("Binding test and training rows")
mergedSYX <- rbind(trainSYX,testSYX,make.row.names = FALSE)

#2   - Extract measurements on mean and std dev for each measurement

print("Extracting Subject, Activity, mean() and std() rows")
extractList <- c(1,2,
                 grep("mean()",names(mergedSYX)),
                 grep("std()",names(mergedSYX))
                 )
extracted <- mergedSYX[,extractList]

#3   - develop descriptive activity names to the data set

print("developing descriptive activity names")
names(actLabels) <- c("activityID","Activity")

#4   - apply labels to data set

print("Applying descriptive activity names to data set")
rowID <- 1
rowMax <- length(extracted$Activity)
while (rowID <= rowMax) {
  if (!is.na(extracted[rowID,2])) {
    extracted[rowID,2] <- actLabels[extracted[rowID,2],2]
  }
  rowID <- rowID + 1
}

#5   - generate set of averages for each activity and subject

print("Generating set of averages")

#5.X - group data by Subject and Activity

grouped <- group_by(extracted,Subject,Activity)
averaged <- summarise_all(grouped,mean)

#6   - write set of averages to averages.txt

print("Writing set of averages to file")
write.table(averaged,file = "averages.txt",sep = " ", col.names = TRUE)
finishedPath <- paste0("Averages written to ",getwd(),"/averages.txt")
print(finishedPath)