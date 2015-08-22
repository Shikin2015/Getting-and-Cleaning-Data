#  Code Book

This is a code book that describes the variables, data, and any transformations or work that was performed to clean up the data.

#  The data source

   •    Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

   •    Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#  Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#  The data

The dataset includes the following files:

   •    'README.txt'

   •    'features_info.txt': Shows information about the variables used on the feature vector.

   •    'features.txt': List of all features.

   •    'activity_labels.txt': Links the class labels with their activity name.

   •    'train/X_train.txt': Training set.

   •    'train/y_train.txt': Training labels. 

   •    'test/X_test.txt': Test set.

   •    'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

   •    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

   •    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and •  'total_acc_z_train.txt' files for the Y and Z axis.

   •    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

   •    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

For each record in the dataset it is provided:

   •    Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

   •    Triaxial Angular velocity from the gyroscope.

   •    A 561-feature vector with time and frequency domain variables.

   •    Its activity label.

   •    An identifier of the subject who carried out the experiment.
 
See Readme file into 'UCI HAR Dataset' for more information.

#  Transformation details

The raw data sets are processed with the script run_analysis.R script to create a tidy data set.

The script run_analysis.R performs the 5 steps as instructed in the course project's definition.

   1.    Merge the training and test sets to create one data set Concatenate the data tables by rows using rbind Set names to variables using names(dataSubject)<-c("subject"), names(dataActivity)<- c("activity") and names(dataFeatures)<- FeaturesNames$V2 Merge column to get the data frame for all data using cbind

   2.    Extract only the measurements on the mean and standard deviation for each measurement Subset name of Features by measurements on the mean and standard deviation with mean() or std() Subset the data frame Data by selected names of features

   3.    Use descriptive activity names to name the activities in the data set Read descriptive activity names from "activity_label.txt" Factorize variable activity in the data frame MData by using descriptive activity names using factor()

   4.    Appropriately label the data set with descriptive activity names Names of features will be labeled using descriptive variable names in names(MData)

   5.    Creates a second, independent tidy data set with the average of each variable for each activity and each subject write.table(MData2, file = "tidydata.txt",row.name=FALSE)

#  Tidy data set

##Variables

The tidy data set contains :

   •    an identifier of the subject who carried out the experiment (Subject). Its range is from 1 to 30.

   •    an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
 
   •    mean of all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal (numeric value)

The variable name convention is like the following:

   •  measurement: the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable: gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean,tBodyGyroJerkMean.

   •    .mean/std: mean or standard deviation of the measurement

   •    .X/Y/Z: one direction of a 3-axial signal

   •    .mean: global mean value

The data set is written to the file 'tidydata.txt'.



