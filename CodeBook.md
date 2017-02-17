# Code Book 
This is a code book that indicates all the variables and summaries calculated, along with units and other relevant information. 

## The data source 
* The data for the project was obtained from a UCI Machine Learning repository: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Saved the data in a folder in my working directory called UCI HAR Dataset

* The original description the data is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The data set information 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## The file run_analysis.R 
##Step 1: Merges the training and the test sets to create one data set. 
### Before the files can be merged, they must be read into R, assigned to variables and then read in. They are listed and defined below: 
*x_train, y_train, subject_train, x_test, y_test, subject_test,features, and activitylabels contain the downloaded content from the original data files. 
*Before merging the files, column names were added to the following files: x_train, y_train, subject_train, x_test, y_test, and subject_test. 
*merged_train and merged_test files contain the merged train and test files respectively. 
*all_filesmerged contains the merged dataset containing both the training and test sets creating one data set. 

##Step 2: Extracts only the measurements on the mean and standard deviation for each measurements. 
*mean_std looks for the mean and the standard deviation by looking the subjectID or the activityID. 

##Step 3: Uses descriptive activity names to name the activities in the data set. 
*activitylabels added activityId and activityType as header names. 
*descriptive_activity is the mean and standard deviation file, but replaces the id number with a descriptive label, i.e. walking. 

##Step 4: Appropriately labels the data set with descriptive variable names. 
*The descriptive_activity file was cleaned up, removing the following: i) the  small “t” at the start was converted to Time; ii) the small “f” was converted to “Frequency”; and iii) the parenthesis at the end were removed. 

##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
*second_tidydata is the clean data set, using the ddply function, adding in the column labels of “subjectId” and “activityId” with each of their means  