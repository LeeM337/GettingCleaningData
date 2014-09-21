GettingCleaningData
===================

Course Project


Prerequisites:
The run_analysis.R script assumes that the directory "UCI HAR Dataset" is in
the current working directory

It performs the assigned tasks:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



The structure of the original data:

[The structure is the same for both the "test" and the "train" directories]
The feature data on, for example, line number n of "UCI HAR Dataset/test/X_test.txt" corresponds to the activity-number given on line n in the file "UCI HAR Dataset/y_test.txt" and was carried out by the subject whose number is listed on line n in the file "UCI HAR Dataset/test/subject_test"
The activity corresponding to each activity-number is then obtained from the file "UCI HAR Dataset/activity_labels.txt" 


The script run_analysis.R does the following:

The "test" and "train" datasets are combined in a table with columns for subject, activity, and for all the features listed in the features_info.txt file which contain the pattern std() or mean() in their names. The column names for these extracted features are created by removing the difficult characters:   -  and () 
In addition, "BodyBody" is replaced with "Body" since this appears to be an error in the original naming (Note: this is done so that the variables match those in the original features_info.txt file)
Finally, the variable names are written in lower case letters only (in accordance with "tidy-data" practice)

Using ddply() function from the plyr-library, the mean of each of the 66 feature variables is calculated for each subject and activity.

A file "tidydata.txt" is saved to the working directory, with column names the same as above except that now each value in the features columns is the mean value for that given subject and activity.

