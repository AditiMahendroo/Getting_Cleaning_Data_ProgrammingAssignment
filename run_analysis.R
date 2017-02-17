fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download the zip files using the below code 
download.file(fileURL, destfile = "~/Documents/Coursera/Working Directory/Dataset.zip")

##unzip the files 
unzip(zipfile= "~/Documents/Coursera/Working Directory/Dataset.zip", exdir = "~/Documents/Coursera/Working Directory/")

## Reading in training tables 
x_train <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/train/subject_train.txt")

## Reading in the test tables
x_test <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/test/subject_test.txt")

## Reading in the features information 
features <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/features.txt")

## Reading in the activity labels 
## Need for the third question
activitylabels <- read.table("~/Documents/Coursera/Working Directory/UCI HAR Dataset/activity_labels.txt")

## Rename the column names for train
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

## Rename the column names for test 
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

## Merge the train and test files first using cbind 
merged_train <- cbind(x_train, y_train, subject_train)
merged_test <- cbind(x_test, y_test, subject_test)

## Once complete, then merge all the files using rbind
all_filesmerged <- rbind(merged_train, merged_test)

## Find the mean and standard deviation 
mean_std <- all_filesmerged[grep(("mean|std|subjectId|activityId"), names(all_filesmerged))]

## Use descriptive activity names to name the activities
## in the data set, but first need to add names to activity labels
colnames(activitylabels) <- c("activityId","activityType")
descriptive_activity <- merge(mean_std, activitylabels, by="activityId",
                              all.x=TRUE)

##Appropriately label the data set with descriptive variables names
##aka clean up some of the data labels 
names(descriptive_activity) <- gsub("^t", "Time", names(descriptive_activity))
names(descriptive_activity) <- gsub("^f", "Frequency", names(descriptive_activity))
names(descriptive_activity) <- gsub('\\(|\\)',"", names(descriptive_activity))

## From the data set in step 4, create a second, independet tidy
## data set with the average of each variable for each activity 
## and each subject 
second_tidydata <- ddply(descriptive_activity, c("subjectId", "activityId"), numcolwise(mean))
  
##write it into a text file 
write.table(second_tidydata, "second_tidydata.txt", row.name=FALSE)