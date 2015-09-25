# Getting and Cleaning Data assignment #  
Smartphone data assignment for the Coursera course "Getting and Cleaning data"

## Input and output ##

The **input** is a set of text files containing tabular data. The data is recorded 
from smartphone sensors for a number of human subjects. The activities of the 
subjects are inferred from the data. The text files containing the data are in a directory structure, whose root is assumed to be in the R working directory, 
together with the R script "run\_analysis.R".

A description of the input text files follows:

 - **X\_test.txt**, **X\_train.txt**: the TEST and TRAIN data files, having the same
   structure (variables)
 - **features.txt**: the variable names (labels of the columns) of the previous data
   files
 - **y\_test.txt**, **y\_train.txt**: the activity ID for each observation (row) in 
   the respective data files
 - **activity\_labels.txt**: the mapping of activity IDs to actual activity names
 - **subject\_test.txt**, **subject\_train.txt**: the ID of the person subjects for 
   each observation in the respective data files

The **result** of runing the script "run\_analysis.R" is the text file
**summary\_data.txt**, created in the R working directory. This text file contains 
the data resulting from step 5 of the following list of steps. According to the
assignment, the script is required to **meet the requirements in the following 
steps**:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each
    measurement. 
 3. Uses descriptive activity names to name the activities in the data set.
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the
    average of each variable for each activity and each subject.

## How the script works ##

A single script called **run\_analysis.R** takes as input the text files described 
above, performs the required steps (albeit not in the order they were presented), 
and produces the text file **summary\_data.txt**. For legibility the script assigns 
new dataframes to new names, and destroys dataframes that are no longer needed 
in order to reclaim memory.    
The script works as follows:

 - Check if the required for input data files exist, abord if not.

 - Read the **TEST** and **TRAIN data**. Read the variable names (contained in
   "features.txt"). The original variable names contain "-" and "()" characters, 
   which can create a problem should we attempt to use those names from within R.
   Therefore, the next step is to substitute \- and \(\) in variable names 
   with \_ and "" (empty str) respectively. Then **assign the proper variable names** 
   as column names in the TEST and TRAIN data.

 - Left join (*merge*) the **activity codes** for TEST and TRAIN data with the 
   respective **activity names** in a way that the original order of the activity codes 
   is preserved. The activity names are casted as factors - however note that the 
   factor levels do not correspond to the respective activity codes (not a problem 
   here, just a note).

 - Read the IDs of the **person subjects** for TEST and TRAIN data from the 
   respective input files.

 - Add the respective subject ID, activity code, and activity name columns 
   (*cbind*) to the TEST and TRAIN dataframes. Now the TEST and TRAIN data **cover 
   the requirements 3 and 4 above!**

 - Put together TEST and TRAIN data (*rbind*) to form a single dataset. The result 
   also **covers the requirement 1 above!**

 - Create a new dataframe that keeps only some of the variables (columns). The 
   variables that survive are the subject ID (col 1), the activity name (col 3), 
   as well as every every variable with a name that contains "mean" or "std" 
   (for standard deviation). The new dataframe also **covers the requirement 2 
   above!**

 - Create a final dataframe (*summ.data*) containing the average of each variable 
   for each activity / subject group. This last dataframe also **covers the 
   requirement 5 above!**

 - This final dataframe conforms to the "tidy data" requirements. In the final 
   step it is **written in the text file** "*summary\_data.txt*".

----------------------------------------
