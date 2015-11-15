# Course project
# The data linked to from the course website represent data collected from the accelerometers from
# the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Here are the data for the project:    
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following steps. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject.


# working directory where downloaded file was unziped
setwd("C:/MyData/LearnR/Coursera/Getting_and_Cleaning_Data/UCI HAR Dataset")

# Read all training data from unziped data dirctory
features <- read.table('./features.txt',header=FALSE);            
activity_type <- read.table('./activity_labels.txt',header=FALSE);     
subject_train <- read.table('./train/subject_train.txt',header=FALSE); 
x_train <- read.table('./train/x_train.txt',header=FALSE);       
y_train <- read.table('./train/y_train.txt',header=FALSE);       


## Q1: Merges the training and the test sets to create one data set.
# Assign colnames
names(features) <- c('activityId','activityType')
names(activity_type) <- c('activityId','activityType')
names(subject_train) <- "subjectId"
names(x_train) <- features[,2]
names(y_train) <- 'activityId'

# Merge all training data
all_train <- cbind(subject_train, x_train, y_train)

# Read all training data from unziped data dirctory
subject_test <- read.table('./test/subject_test.txt',header=FALSE); 
x_test <- read.table('./test/x_test.txt',header=FALSE);       
y_test <- read.table('./test/y_test.txt',header=FALSE);       

# Assign colnames
names(subject_test) <- "subjectId"
names(x_test) <- features[,2]
names(y_test) <- 'activityId'

# Merge all training data
all_test <- cbind(subject_test, x_test, y_test)

# == Merge all Training and Test data
total_data <- rbind(all_train, all_test)


## Q2: Extracts only the measurements on the mean and standard deviation for each measurement
library(dplyr)

# == convert column name to unique
valid_column_names <- make.names(names=names(total_data), unique=TRUE, allow_ = TRUE)
names(total_data) <- valid_column_names

selected_data <- select(total_data, contains("mean..."), contains("std..."), activityId)

## Q3: Uses descriptive activity names to name the activities in the data set

selected_data  <-  selected_data %>% left_join(activity_type, by="activityId")


## Q4: Appropriately labels the data set with descriptive variable names
col_names <- names(selected_data)

# clean-up variable name
for (i in 1:length(col_names)){
    col_names[i] <- gsub(".mean...", "_mean_", col_names[i])
    col_names[i] <- gsub(".std...", "_std_", col_names[i])
    col_names[i] <- gsub("^t", "time_", col_names[i])
    col_names[i] <- gsub("^f", "frequency_", col_names[i])    
}

# replace old names with new variable names
names(selected_data) <- col_names

## Q5: From the data set in step 4, creates a second, independent tidy data set with the average
##     of each variable for each activity and each subject

library(tidyr)
tidy_data <- selected_data %>% 
    select(activityType, contains("mean")) %>%
    gather(subject, average, - activityType)

# write tidy data
write.table(tidy_data, './tidy_data.txt', row.names=FALSE, sep=",")





