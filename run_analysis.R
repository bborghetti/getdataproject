
#-----------------------------------------------------------------------------------------------
#Initialization
rm(list=ls())  # clear all variables to prevent variable corruptions



#  LOAD THE TABLES
subjectTrainData <- read.table("originalData/subject_train.txt", header = FALSE)
subjectTestData  <- read.table("originalData/subject_test.txt", header = FALSE)
XTrainData       <- read.table("originalData/X_train.txt", header = FALSE)
yTrainData       <- read.table("originalData/y_train.txt", header = FALSE)
XTestData        <- read.table("originalData/X_test.txt", header = FALSE)
yTestData        <- read.table("originalData/y_test.txt", header = FALSE)
activityData     <- read.table("originalData/activity_labels.txt", header = FALSE)
featureData      <- read.table("originalData/features.txt", header =FALSE)



#-----------------------------------------------------------------------------------------------
#REQUIREMENT #4: Appropriately labels the data set with descriptive variable names.
# PART 1:  use the existing names in FeatureValues (this will get cleaned up later in PART 2)
#  prepare for the merge by labeling feature value names with text values instead of V1, V2, etc. 
#  note this is much easier to do it now than after we bind the data together 
#    The tidy dataset will use the 561 featureData names as column header names for features

currentFeatureNames <-featureData$V2 #note that this will be used later

names(XTrainData) <- currentFeatureNames
names(XTestData)  <- currentFeatureNames

#-----------------------------------------------------------------------------------------------
#REQUIREMENT 1: Merges the training and the test sets to create one data set.
# PART 1:  Bind the feature values

#  (note this is actually just a rbind not a "merge" since there is no required join operation)
#
#   Since rows are observations, the Test Set and Training set will be
#   concatenated vertically (training goes in upper rows, test goes in lower rows) using rbind

featureValues  <- rbind(XTrainData, XTestData)


#-----------------------------------------------------------------------------------------------
#REQUIREMENT #2: Extracts only the measurements on the mean and standard deviation for each measurement.
#
# now we handle removing any featureValues (columns) which dont relate to "mean" or "standard deviation"
# this is actually REQUIREMENT #2, but it is easier to do before we finish merging the entire tidy dataset
# note that the assignment fails to specify which features are actually required
# and that in a forum post the CTA told us we get to decide 
# Therefore, I am using a tight definition here: only feature columns which have the explicit name
# containing the text "mean()" or "std()"  will be retained.  While there are other feature names which 
# use "Mean" or "meanFreq, I'm making the decision to leave them out 

# generate the boolean list indicating whether each featureData name contains "mean()" or "std()"  

keep <- grepl("mean()", as.character(featureData$V2[]),fixed=TRUE) |
  grepl("std()", as.character(featureData$V2[]),fixed=TRUE) 

#build a reduced set which only contains columns with "mean()" or "std()" using the boolean list

keepFeatureValues <- featureValues[,keep]

#-----------------------------------------------------------------------------------------------
#REQUIREMENT #4: Appropriately labels the data set with descriptive variable names. 
# PART 2
#  there is still some cleanup to do to make the feature names "descriptive"
#  note that I'm choosing to minimize the changes to the feature labels so there is maximal
#  correspondence with the original features collected in the experiment
#  Thus, I will only remove "illegal" characters "-", "(", and  ")"
#  these illegal characters were identified in one of the forum posts by the CTA

newFeatureNames <- names(keepFeatureValues)  #collect only column names we kept from the last step

#  use gsub to replace "-" with "."
newFeatureNames <- gsub("\\-", ".", newFeatureNames)
#  use gsub to replace "(" with ""
newFeatureNames <- gsub("\\(", "", newFeatureNames)
#  use gsub to replace ")" with ""
newFeatureNames <- gsub("\\)", "", newFeatureNames)

names(keepFeatureValues) <- newFeatureNames


#    The tidy dataset will use "ActivityType" as the column header name for the activity labels
names(yTrainData) <- "ActivityType"
names(yTestData)  <- "ActivityType"

#    The tidy dataset will use "SubjectID" as the column header name for subjects
names(subjectTrainData) <- "SubjectID"
names(subjectTestData)  <- "SubjectID"


#-----------------------------------------------------------------------------------------------
#REQUIREMENT 1: Merges the training and the test sets to create one data set.
# PART 2:  Finish the merging by Binding the activity labels and subjects
# and then finally binding all the columns together to make a single tidy dataset

#  (note this is actually just a rbind not a "merge" since there is no required join operation)
#
#   Since rows are observations, the Test Set and Training set will be
#   concatenated vertically (training goes in upper rows, test goes in lower rows) using rbind

activityLabels <- rbind(yTrainData, yTestData)
subjectObs     <- rbind(subjectTrainData, subjectTestData)

#   Concatenate the feature values and activity labels horizontally (1 subject column, 66 features columns,
#   followed by 1 activity Label column)

allData <- cbind(subjectObs,keepFeatureValues,activityLabels)

# as a final clean up action for our tidy dataset, 
# we re-order rows of our data based on SubjectID (column 1)
# note that this will interleave the testing and training data together by subject
# instead of keeping them segregated

allData <- allData[order(allData$SubjectID),]


#-----------------------------------------------------------------------------------------------
#REQUIREMENT #3: Uses descriptive activity names to name the activities in the data set
#
#   The "y" label information is converted from numbers to activity descriptors
#   using the 6 activity labels provided in activityData

lookup <-function(x,y) y[x] #looks up a list member from an index x is a index, y is a list 
allData$ActivityType <- sapply(activityLabels,lookup, y=activityData$V2)



#-----------------------------------------------------------------------------------------------
#REQUIREMENT #5: From the data set in step 4, creates a second, independent 
#         tidy data set with the average of each variable for each 
#         activity and each subject.
#
#         This will be a table (subjectID by Activity by Feature) of means of the features

library(dplyr)  #using dplyr is much easier for this part

gData<-group_by(allData,ActivityType,SubjectID) #group by activity type, then by subjectID

meansData<-summarise_each(gData,funs(mean)) # call the means on the group

write.table(meansData, file="tidyMeansTable.txt", row.names=FALSE) #save the resulting tidy dataset



