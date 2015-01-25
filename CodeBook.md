---
title: "CodeBook"
output: html_document
---
## Purpose of this CodeBook

This codebook documents the variables and labels contained in the tidyMeansTable.txt file.  
This file contains the submission for Requirement 5 in the Getting and Cleaning Data course project.  
Review the README.md file for a description of how this dataset was created, and review the 
run_analysis.R file to see the code that created it.

The dataset is organized as follows

## Row Description

Rows are organized first by Activity being performed, then by subject.  Each of the 6 activities contains 30 rows (one for each subject), for a total of 180 rows of data

## Column Description

Columns are ActivityType, SubjectID, and 66 Features (see descriptions below)
  
### ActivityType Description  (Column 1)

ActivityType describes the activity the subject was performing when the features were measured.  There are 6 activity labels:  

- LAYING  
- SITTING  
- STANDING  
- WALKING  
- WALKING_DOWNSTAIRS  
- WALKING_UPSTAIRS  

### SubjectID Description  (Column 2)

30 subjects completed the activities and their features were measured during the activities.  Subjects are labeled 1 through 30

### Feature Description (Columns 3 to 68)

For the features, in each cell of the tidy dataset, the **mean** of a set of values is reported.  The group measures are organized by ActivityType and SubjectID (indicated in the first and second columns of the dataset)


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc and tGyro. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and 3-axis gravity acceleration signals (tBodyAcc and tGravityAcc) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time for each of the three axes to obtain Jerk signals (tBodyAccJerk and tBodyGyroJerk). Also the (non-axial) overall magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency-domain features in each of 3 axes: fBodyAcc, fBodyAccJerk, fBodyGyro, as well as frequency-domain non-axial feature magnitudes fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern - mean and standard deviation

#### Feature Naming Convention  
To determine the feature name for a specific feature, apply this structure:  
**[*Root*].{*function*}.<{*suffix*}>**
where:    
 - [*Root*] is one of the variables of interest (see feature list below),   
 - {*function*} is the required calculation - mean or standard deviation chosen from the set {mean, std},  
 - <{*suffix*}> is the optional suffix for the desired axis label in 3-axis measure set  {X, Y, Z}.  Note that suffix only applies to non-magnitude features  

for example, "tBodyAcc.mean.X"" refers to the mean of the time domain Body Accellerations measured in X 


#### Feature List
- Root names for time-domain 3-axial values which have a suffix in {X,Y,Z}

 -- tBodyAcc:  Body accelleration  
 -- tGravityAcc:  Gravity acceleration  
 -- tBodyAccJerk:  Body accelleration jerk  
 -- tBodyGyro :  Body gyro  
 -- tBodyGyroJerk:  Body gyro jerk  

- Root names for non-axial time-domain magnitudes

 -- tBodyAccMag:  Body acceleration  
 -- tGravityAccMag:  Gravity accelleration  
 -- tBodyAccJerkMag:  Body accelleration jerk  
 -- tBodyGyroMag:  Body gyro   
 -- tBodyGyroJerkMag:  Body gyro jerk    

- Root names for three-axis frequency-domain values which have a suffix in {X,Y,Z}  

 -- fBodyAcc: Body accelleration  
 -- fBodyAccJerk:  Body accelleration jerk  
 -- fBodyGyro:  Body gyro  

- Root names for non-axial frequency-domain magnitudes

 -- fBodyAccMag: Body accelleration   
 -- fBodyAccJerkMag:  Body accelleration jerk    
 -- fBodyGyroMag:  Body gyro    
 -- fBodyGyroJerkMag::  Body gyro jerk    









