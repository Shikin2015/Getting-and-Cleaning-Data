#______________________________________________________________________________________________________________________
# R script called run_analysis.R that does the following:
#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#Input data for the project: 
#    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#Output File: 
#    tidydata.txt
#_____________________________________________________________________________________________________________________

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("F:/Module3/Project")

# Clean up workspace
rm(list=ls())

# Step 1: Read data from the files into the variables
#---------------------------------------------------------
f_path <- file.path("UCI HAR Dataset")

## a. Read the activity files
activityTest  <- read.table(file.path(f_path, "test" , "Y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(f_path, "train", "Y_train.txt"),header = FALSE)

## b. Read the Subject files
subjectTrain <- read.table(file.path(f_path, "train", "subject_train.txt"),header = FALSE) 
subjectTest  <- read.table(file.path(f_path, "test" , "subject_test.txt"),header = FALSE)  

## c. Read the Fetures files
featuresTest  <- read.table(file.path(f_path, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(f_path, "train", "X_train.txt"),header = FALSE)

# Steps 2. Merge the training and test sets to create one data set.
#--------------------------------------------------------------------

## a. Concatenate the data tables by rows
dataSubject <- rbind(subjectTrain, subjectTest)
dataActivity<- rbind(activityTrain, activityTest)
dataFeatures<- rbind(featuresTrain, featuresTest)

## b. Assign names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
featuresNames <- read.table(file.path(f_path, "features.txt"),head=FALSE)
names(dataFeatures)<- featuresNames$V2

## c. Merge column to get the data frame for all data
dataMerge <- cbind(dataSubject, dataActivity)
View(dataMerge) # to view merged data of Subject and Activity

MData <- cbind(dataFeatures, dataMerge)
View(MData) # to view merged data of Subject, Activity and Features

# Step3: Extract only the measurements on the mean and standard deviation for each measurement.
#---------------------------------------------------------------------------------------------

## a. Subset name of Features by measurements on the mean and standard deviation with mean() or std()
subfeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]

## b. Subset the data frame MData by selected names of features
selectedNames<-c(as.character(subfeaturesNames), "subject", "activity" )
MData<-subset(MData,select=selectedNames) 
str(MData) # to check the structure of the data frame MData

# Step 4: Use descriptive activity names to name the activities in the data set
#---------------------------------------------------------------------------------------------

## a. Read descriptive activity names from "activity_label.txt"
activityLabels <- read.table(file.path(f_path, "activity_labels.txt"), header=FALSE)

## b. Factorize variable activity in the data frame MData by using descriptive activity names 
MData$activity <- factor(MData$activity, labels = activityLabels[,2])
head(MData$activity,30) 
View(MData)  ##to view factorized variables

# Step 5: Appropriately label the data set with descriptive activity names. 
#         Labelling names of features using descriptive variable names
#------------------------------------------------------------------------

names(MData)<-gsub("^t", "Time", names(MData)) # prefix t is replaced by time
names(MData)<-gsub("^f", "Frequency", names(MData)) # prefix f is replaced by frequency
names(MData)<-gsub("Acc", "Accelerometer", names(MData)) # Acc is replaced by Accelerometer
names(MData)<-gsub("Gyro", "Gyroscope", names(MData)) #Gyro is replaced by Gyroscope
names(MData)<-gsub("Mag", "Magnitude", names(MData)) #Mag is replaced by Magnitude
names(MData)<-gsub("BodyBody", "Body", names(MData)) #Body is replaced by Body
names(MData)<-gsub("-std","StdDev", names(MData)) #-std is replaced by StdDev
names(MData)<-gsub("-mean","Mean", names(MData)) #-mean is replaced by Mean
names(MData)<-gsub("[-()]", "", names(MData)) #-() is replaced by ""

## check the replacement made
names(MData)

# Step 6: Creates a second independent tidy data set with the average of each variable for each activity & each subject.  
#         Independent tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 5
#----------------------------------------------------------------------------------------------------------------------------

library(plyr)
MData2<-aggregate(. ~subject + activity, MData, mean)
MData2<-MData2[order(MData2$subject,MData2$activity),]
write.table(MData2, file = "tidydata.txt",row.name=FALSE)



