GandCD_PeerAsessment
====================

# Project for the course in coursera

# Getting and Cleaning Data Course Project

The zip file getdata-projectfiles-UCI HAR Dataset.zip was downloaded and then its files extracted in the working directory.
This creates all the files in the  working directory that contains no subfolders and four 
files - activity_labels.txt, features.txt, features_info.txt, and README.txt, subject_test.txt, X_test.txt,
and y_test.txt, subject_train.txt, X_train.txt, y_train.txt.

The R script file run_analysis.R contains code that does the following:

# Merges the training and test sets

It reads the test data files subject_test.txt, X_test.txt, and y_test.txt using read.table(). 

The row number of the three test datasets is equal - 2947 rows.
It combines the columns of the three test datasets using cbind() and creates testSet with total of 563 columns (1+1+561).

It reads the train data files subject_train.txt, X_train.txt, and y_train.txt using read.table(). 
The row number of the three train datasets is equal - 7352 rows.
It combines the columns of the three train datasets using cbind() and creates trainSet with total of 563 columns (1+1+561).
It combines the rows of the test set and the train set using rbind(). This gives a total of 10299 rows (2947+7352).
Extracts the measurements on the mean and standard deviation for each measurement

It reads the features.txt file to get the columns names.

It creates a vector with the column names. First two column names will be "subject", and "activity". 
The rest will use the data from the second column of the features file.

Sets the names of the columns to be the created vector using names().
It creates a vector with column names that contain "subject" or "activity" or "mean()" or "std()" using grep()
and regular expression "subject|activity|-mean\(\)|-std\(\)".
Extract only the data that is in the columns with column names in this vector - 68 columns.
It gives descriptive activity names to the activities in the data set

From the activity_labels.txt file we can get the activity lable for each numeric value ( 1 - WALKING, 2 - WALKING_UPSTAIRS, etc.).
Using factor() function on the activity column we can convert the numeric values to the activity labels.
It properly labels the data set with descriptive variable names

The names were kept short for simplicity. The meaning of the abbreviations will be listed in the Code Book.

Using gsub() removed the characters "()" and replaced "-" with "_", so "tBodyAcc-mean()-X" became "tBodyAcc_mean_X".
Creates a tidy data set with the average of each variable for each activity and each subject

Using aggregate() to create a data set with the average of each variable for each activity and each subject. It has 180 rows (30 subjects * 6 activities) and 68 columns("subject", "activity", and all the mean and standard deviation features). After reading Hadley Wickham's paper on Tidy Data http://vita.had.co.nz/papers/tidy-data.pdf (listed in the week 3 Reshaping data lecture) and considering that this dataset has four variables - subject, activity, feature and average. To make it tidy, we can turn columns into rows. 
Using melt() from the reshape2 package create a tidy data set with ID variables "subject" and "activity" that identify individual rows of data, variable column with the features, and value column with the averages. It has 11880 rows (30 subjects * 6 activities * 66 features) and 4 columns ("subject", "activity", "feature", and "average").
Write the tidy data set to a tidyDataSet.txt file.

Can read the text file with the tidy data set into R using: read.table("tidyDataSet.txt", header = TRUE)

