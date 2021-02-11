# run_analysis.R - *Fielding Isaacs 2021*
## Getting and Cleaning Data Course Project
### *Coursera Getting and Cleaning Data*

## Process

### Included Libraries

- dplyr
- tidyr

## Step 0 - Get the data and read it in.

### Step 0.1 - Change working directory

- Change the working directory to the data folder

### Step 0.2 - Download the file if it doesn't already exist

- Downloads raw accelerometer data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip via the download.file() function using the curl method into a zip file titled Dataset.zip in the data directory

### Step 0.3 - Unzip the file if it hasn't already been done

Using the unzip() function, extract the dataset into the data directory if the file has not already been unzipped.

### Step 0.4 - Read features and activity labels

Move into the UCI HAR Dataset folder and read the following files:
- activity_labels.txt - read into actLabels vector
- features.txt - read into features vector

### Step 0.5 - Read in the training data

Move into the train directory and read the following files:

- y_train.txt read into the trainY vector
- X_train.txt read into the trainX data frame
- subject_train.txt read into the trainS vector

### Step 0.6 - Read in the test data

Move into the test directory and read the following files:

- y_test.txt read into the testY vector
- X_test.txt read into the testX data frame
- subject_test.txt read into the testS vector

### Step 0.7 - Restore the working directory

- Set the working directory back to the project root.

## Step 1   - Merge the training and test sets

### Step 1.1 - Assign feature names to training data columns

- Use the names() function to name the vectors and data frame generated in Step 0.
- Y vectors are named "Activity"
- S vectors are named "Subject"
- The features vector is used via the names() function to apply column names to the X data frames.

### Step 1.2 - Assign feature names to test data columns

- Step 1.1 is repeated on the test vectors and data frame.

### Step 1.3 - Bind subject IDs to training data

- The trainS, trainY and trainX objects are column bound via the cbind() function into a single data frame named trainSYX.

### Step 1.4 - Bind subject IDs to test data

- Step 1.3 is repeated on testS, testY, and testX into the data frame testSYX.

### Step 1.5 - merge data sets

- trainSYX and testSYX are merged together via the rbind() function into the mergedSYX data frame.

## Step 2   - Extract measurements on mean and std dev for each measurement

- the grep() and concatenate() functions are used to bind together the Subject, Activity, mean() and std() factors from the mergedSYX data frame, into the extracted dataframe.

## Step 3   - develop descriptive activity names to the data set

- The actLabel data frame is identified as containing an activityID and Activity factor.  the Activity factor represents the descriptive name corresponding to the numbered activityID.

## Step 4   - apply labels to data set

- A while() loop is used to iterate through the value of the Activity column for each row in the extracted dataframe.  the number value is then indexed against the actLabels dataframe, and the corresponding descriptive name replaces the original numeric value in the extracted dataframe.

## Step 5   - generate set of averages for each activity and subject

### Step 5.1 - group data by Subject and Activity

- First, a dataframe titled grouped is produced using the group_by() function to group the data by Subject and Activity.

### Step 5.2 - Return set of mean() and std() data grouped by Subject and Activity

- Next, the averaged dataframe is produced using the summarise_all and mean functions to generate averages of the mean() and std() factors of the data set.

## Step 6   - write set of averages to averages.txt

- The averaged dataframe is written to the file averages.txt via the write.table() function, with a single space as a separator and the column names written in as header data.