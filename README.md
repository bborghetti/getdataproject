---
output: html_document
---
# getdataproject
Course project for coursera get data class in data science specialization

## Goal:
Build 2 tidy datasets from existing data

## Description of the directory structure:

the root level contains:

 - README.md file:  the file you are reading
 - run_analysis.R file:  the script to create the tidy datasets
 - CodeBook.md file:  explains the columns and rows in the tidy dataset for requirement 5 (per forum post)
 - Rstudio & Git project files:  several files that RStudio uses to manage the project & versioning info
 - originalData folder:  contains all the prior existing data in one place.  

Note that I moved all the data files from training and test into this originalData folder.  It also contains the label files for features and activities.  By having a single directory for all the data & labels, loading is easier since there is only one path name.  The folder contains the following files:

  - originalData/subject_train.txt
  - originalData/subject_test.txt
  - originalData/X_train.txt
  - originalData/y_train.txt
  - originalData/X_test.txt
  - originalData/y_test.txt
  - originalData/activity_labels.txt
  - originalData/features.txt

## Description of the run_analysis.R file:

Overarching principle... If the order of steps for merging the dataset is determined carefully, one can eliminate extra work of trying to alter the dataset after it has been merged.  Thus, while the requirements
were labeled 1 through 5, I found that by performing parts of the requirements earlier than indicated
I could reduce the work required in tweaking the dataset after it was merged.   Thus, the sequence I
followed was:

- Load all the files  
- Fix the featureValue data   
  -- name the feature value columns for train and test using the featureData information [REQUIREMENT 4]  
  -- merge the training and test sets via vertical binding (rbind) [REQUIREMENT 1]  
  -- determine which features to keep (means & stds) and remove the others [REQUIREMENT 2]  
  -- fix the column headers for the feature values that were kept [REQUIREMENT 4]  
- Fix the ActivityData   
  -- change the column name [REQUIREMENT 4]  
- Fix the subjectData   
  -- change the subject column name [REQUIREMENT 4]  
- Build the full tidy dataset [REQUIREMENT 1]  
  -- bind the activity data training & testing together (rbind)  
  -- bind the subject data training & testing together (rbind)  
  -- bind the subject data, feature data, and activity data together (cbind)  
  -- reorder the dataset by subjectID (instead of leaving sort by training/testing)  
- Replace the activity data number values with descriptive activity names [REQUIREMENT 3]  
- Build & save the tidy dataset which documents the means of the feature values for each ActivityType and Subject [REQUIREMENT 5]  
