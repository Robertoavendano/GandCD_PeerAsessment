
library(reshape2)

# Read Test data files
# Read data from txt files, space delimited, without header 

subject_Test <- read.table("subject_test.txt", header = FALSE)

y_Test <- read.table("y_test.txt", header = FALSE)
x_Test <- read.table("X_test.txt", header = FALSE)

# Combine all the test data sets by adding the columns

testSet <- cbind(subject_Test, y_Test, x_Test)

# Read Train data files
# Read data from txt files, space delimited, without header 

subject_Train <- read.table("subject_train.txt", header = FALSE)

y_Train <- read.table("y_train.txt", header = FALSE)
x_Train <- read.table("X_train.txt", header = FALSE)

# Combine all the train data sets by adding the columns

trainSet <- cbind(subject_Train, y_Train, x_Train)

# Combine the test set and the train set by adding the rows

dataSet <- rbind(testSet, trainSet)

# Read features.txt file to get the column names
# Read data from txt files, space delimited, without header, 
# variables - class "character"}

features <- read.table("features.txt", header = FALSE, 
                       stringsAsFactors=FALSE)

# Create a vector with the column names using the data from the  features´ second column 

names <- c("subject", "activity", features$V2)
names(dataSet) <- names

# Find the column names that contain "subject" or "activity" or "mean()" or "std()"

msnames <- grep("subject|activity|-mean\\(\\)|-std\\(\\)", names, 
                perl=TRUE, value=TRUE)
extractDataSet <- dataSet[,msnames]

# Read activity_labels.txt file to get the activity labels
# Read data from txt files, space delimited, without header

activities <- read.table("activity_labels.txt", header = FALSE)
aLevel <- activities[,"V1"]
aLabel <- activities[,"V2"]

# Convert the numbers to descriptive activity names in the activity column

extractDataSet$activity <- factor(extractDataSet$activity, levels=aLevel,
                                  labels=aLabel)

# Replace the "-" with "_" in the variable names

newNames <- gsub("-", "_", names(extractDataSet),)

# Remove "()" in the variable names

newNames <- gsub("\\(\\)", "", newNames,)

names(extractDataSet) <- newNames

# Create data set with the average of each variable for each activity and each subject

dataSetWitjAverages <- aggregate( .~subject+activity, extractDataSet, mean )

# Create tidy data set

tidyDataSet <- melt(dataSetWitjAverages, id.vars = c("subject", "activity"),
                    variable.name = "feature", value.name = "average")

# Write the data set to a txt file

write.table(tidyDataSet, "tidyDataSet.txt", row.name=FALSE) 

# end

