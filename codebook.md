The original data was collected on 30 individuals, so there are IDs "1" through "30" for each of the subjects in the study.

The "activity_labels" file in the original data set contained the activity ID as well as the activity. It can be considered a look-up table, and was structured as follows-

Walking
Walking Upstairs
Walking Downstairs
Sitting
Standing
Laying
The "features" file in the original data set contained the list of the 561 variables for the measurements. Only the first 10 are shown here:

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tBodyAcc-mad()-X
tBodyAcc-mad()-Y
tBodyAcc-mad()-Z
tBodyAcc-max()-X
A description of the various measurement types was in the "features_info" file:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Merging the training and testing data sets as described in the "readme" file here

https://github.com/datasourcery/tidy_data_project/blob/master/README.md

resulted in a data frame of dimensions (10299, 563).

The 561 variables were filtered to inclue only the variables for mean and standard deviation measurements, and re-labled for improved readability. 66 measurement variables survived the filter, and were combined with the subject and activity IDs as columns of a data frame. Only the first 10 are shown here:

"Subject ID"
"Activity"
"TimeBodyAccelerationMean-X"
"TimeBodyAccelerationMean-Y"
"TimeBodyAccelerationMean-Z"
"TimeBodyAccelerationSD-X"
"TimeBodyAccelerationSD-Y"
"TimeBodyAccelerationSD-Z"
"TimeGravityAccelerationMean-X"
"TimeGravityAccelerationMean-Y"
The mean of each variable for each activity and subject tuple was then computed, resulting in a data frame of dimensions (180, 68). This reflects the 6 activities performed by the 30 indviduals (6x30 = 180) and the (2 + 66 = 68) columns for subject, activity, and measurements.

The resulting data frame looks like this (only the first row of the first 3 columns are shown here):

Subject ID	Activity	TimeBodyAccelerationMean-X
1	LAYING	0.2215982
