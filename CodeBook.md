# *Cleaning and Getting Data* course project code book

### Analysis process

The analysis script,`run_analysis.R`, performs 5 steps in described in projest requirement as following:

1. Both test and training datasets are read in and merged into one data frame by using cbind() and rbind()
2. Selcted columes with mean and std (converted column names to unique and applied dplyr::select() and also included activityId for following process)
3. Spte 2 out file is then merged with activity_type by activityId (used dylpr::left_join())
4. Changed variable names with descriptive names by using gsub()
5. To construct tidy data set, selected activityId, activityType, and variable names contain "mean". This list is then transformed to tidy data set by using tidyr::gather(). This output can converted to wide format by applying spread().


### Columns in output file

The columns included in the output file are listed below:
  - activityId: The id of the experiment participant.
  - activityType: The name of the activities
      + WALKING
	  + WALKING_UPSTAIRS
	  + WALKING_DOWNSTAIRS
	  + SITTING
	  + STANDING
	  + LAYING
	  
  - features: The detailed description of the different measurement types can be found in the `features_info.txt` file included in the data [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
      + time_BodyAcc_mean_X
	  + time_BodyAcc_mean_Y
	  + time_BodyAcc_mean_Z
	  + time_GravityAcc_mean_X
	  + time_GravityAcc_mean_Y
	  + time_GravityAcc_mean_Z
	  + time_BodyAccJerk_mean_X
	  + time_BodyAccJerk_mean_Y
	  + time_BodyAccJerk_mean_Z
	  + time_BodyGyro_mean_X
	  + time_BodyGyro_mean_Y
	  + time_BodyGyro_mean_Z
	  + time_BodyGyroJerk_mean_X
	  + time_BodyGyroJerk_mean_Y
	  + time_BodyGyroJerk_mean_Z
	  + frequency_BodyAcc_mean_X
	  + frequency_BodyAcc_mean_Y
	  + frequency_BodyAcc_mean_Z
	  + frequency_BodyAccJerk_mean_X
	  + frequency_BodyAccJerk_mean_Y
	  + frequency_BodyAccJerk_mean_Z
	  + frequency_BodyGyro_mean_X
	  + frequency_BodyGyro_mean_Y
	  + frequency_BodyGyro_mean_Z
	  
  - average: mean value of features for each actovityId(subject) and activityType