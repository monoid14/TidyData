# CodeBook #
for the file **summary\_data.txt**, delivered as the result    
of the Coursera course "Getting and Cleaning Data" assignment

## Background and Original Data ##

The **original data** is a set of text files containing tabular data. The data 
is recorded from smartphone sensors for a number of human subjects. The activities 
of the subjects are inferred from the recorded data.

The original dataset can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

 * A **description** of the original data can be found 
   [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).   
 * Within the dataset itself there are a couple of text files providing suplementary 
   description for the data. Those are the *README.txt* file and the 
   *features\_info.txt* file.

**Please study those files first, before reading the present document.**

A short description of the original data text files follows:

 - **X\_test.txt**, **X\_train.txt**: the TEST and TRAIN data files, having the 
   same structure (variables).
 - **features.txt**: the variable names (labels of the columns) of the previous 
   data files.
 - **y\_test.txt**, **y\_train.txt**: the activity ID for each observation (row) 
   in the respective data files.
 - **activity\_labels.txt**: the mapping of activity IDs to actual activity names.
 - **subject\_test.txt**, **subject\_train.txt**: the ID of the person subjects 
   for each observation in the respective data files.

Note that the following facts hold for the original dataset:

 - All observations in the TEST and TRAIN data files ("X\_test.txt" and 
   "X\_train.txt") are numeric. No header is contained in the files. Both files 
   have the same structure (number / type of cols).
 - The no of rows in the "features.txt" file equals the number of columns in 
   the TEST and TRAIN data files. This is normal, since "features.txt" contains the 
   column names of both those files.
 - The number of rows of "X\_test.txt" equals that of "y\_test.txt", since the latter 
   contains the activity codes that correspond to the lines of measurements in 
   the former file. The same holds for the files "X\_train.txt" and "y\_train.txt".
 - The number of rows of "X\_test.txt" equals that of "subject\_test.txt", since 
   the latter contains the human subject IDs that correspond to the lines of 
   measurements in the former file. The same holds for the files "X\_train.txt" 
   and "subject\_train.txt".
 
## Description of the Data Produced ##

The produced file **summary\_data.txt** contains a table consisting of a header 
plus 40 lines. The lines are organized in 81 columns (variables). The header 
contains the descriptive names of those variables.

 - The first column is a factor indicating the name of the activity deduced for 
   the human subject.
 - The second column contains the ID of the human subject.

Those two columns together are considered **key** for the table (unique combination 
of values). The rest of the columns are numeric and contain mean values that 
correspond to variables in the TEST and TRAIN data files ("X\_test.txt" and 
"X\_train.txt"). 
Specifically:

 - From the variables (columns) of the TEST and TRAIN data files, **only** those 
   that contain **mean** and **standard deviation** measurments are retained.
 - This projection is based on the original column names: **only** the columns 
   containing "mean" or "std" in their name survive to the result dataset.
 - Columns of the original TEST and TRAIN data (whose names are contained in 
   "features.txt") can be associated with the columns 3 to 81 of the result dataset 
   according to the following rules: (1) column names containing "\-" in the 
   original dataset, contain "\_" instead in the result dataset, and (2) column 
   names in the result dataset do not contain any "()" that may be contained in 
   column names of the original dataset.
 - Each column of the result dataset contains the **mean values** of the measurements 
   in the respective column of the original combined TEST and TRAIN data files. 
   Those mean values are calculated for **each group of activity/subject**.
 - The **units** for those values are the same as for the original dataset.

## Transformation Process ##

The transformation process is implemented in the script "run\_analysis.R".    
It is described in detail in the file **README.md**.
An overview of what this script does follows:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each
    measurement. 
 3. Uses descriptive activity names to name the activities in the data set.
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the
    average of each variable for each activity and each subject.

----------------------------------------------------
