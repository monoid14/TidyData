###############################################################################
## Course Assignment, script is required to do the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
##-----------------------------------------------------------------------------
## Input files:
## X_test.txt, X_train.txt: the TEST and TRAIN data
## features.txt: the labels of the columns (var names) in the previous files
## y_test.txt, y_train.txt: the activity ID for each observation in the data
## activity_labels.txt: the mapping of activity IDs to activity names
## subject_test.txt, subject_train.txt: the ID of the person subjects for each 
##                                      observation
###############################################################################


## set directory containing the data - path relative to working dir
data.dir <- "./UCI HAR Dataset/"


## check if the data files exist, abord if not
if (!file.exists(paste(data.dir, "features.txt", sep = "")) |
    !file.exists(paste(data.dir, "activity_labels.txt", sep = "")) |
    !file.exists(paste(data.dir, "test/X_test.txt", sep = "")) |
    !file.exists(paste(data.dir, "test/y_test.txt", sep = "")) |
    !file.exists(paste(data.dir, "test/subject_test.txt", sep = "")) |
    !file.exists(paste(data.dir, "train/X_train.txt", sep = "")) |
    !file.exists(paste(data.dir, "train/y_train.txt", sep = "")) |
    !file.exists(paste(data.dir, "train/subject_train.txt", sep = ""))
    )
    stop(paste("Data file(s) cannot be found under directory: ", data.dir, sep = ""))


## read TEST and TRAIN data 
## and assign the proper variable names contained in "features.txt"
test.data  <- read.table(file = paste(data.dir, "test/X_test.txt", sep = ""), 
                         colClasses = "double",  #recycling for all variables
                         header = FALSE)
train.data <- read.table(file = paste(data.dir, "train/X_train.txt", sep = ""), 
                         colClasses = "double",  #recycling for all variables
                         header = FALSE)
var.labels <- read.table(file = paste(data.dir, "features.txt", sep = ""), 
                         col.names = c("Feat.ID", "Feat.Name"), 
                         colClasses = c("integer", "character"), 
                         header = FALSE)
#substitute "-" and "()" in variable names, otherwise cannot be used from within R
var.labels$Feat.Name <- gsub("-", "_", var.labels$Feat.Name)
var.labels$Feat.Name <- gsub("\\(|\\)", "", var.labels$Feat.Name)
#assign the variable names
colnames(test.data)  <- var.labels$Feat.Name
colnames(train.data) <- var.labels$Feat.Name
var.labels <- NULL    #not needed anymore


## join the activity codes for TEST and TRAIN data with respective activity names
test.activ  <- read.table(file = paste(data.dir, "test/y_test.txt", sep = ""), 
                          col.names = "Activ.ID", 
                          colClasses = "integer",
                          header = FALSE)
train.activ <- read.table(file = paste(data.dir, "train/y_train.txt", sep = ""), 
                          col.names = "Activ.ID", 
                          colClasses = "integer",
                          header = FALSE)
activ.names <- read.table(file = paste(data.dir, "activity_labels.txt", sep = ""), 
                          col.names = c("ID", "Activ.Name"), 
                          colClasses = c("integer", "factor"),  #WARN: flevel!=Activ.ID
                          header = FALSE)
test.activ  <- merge(test.activ, activ.names, 
                     by.x = "Activ.ID", by.y = "ID", 
                     all.x = TRUE, all.y = FALSE, sort = FALSE)  #rec order unchanged!
train.activ <- merge(train.activ, activ.names, 
                     by.x = "Activ.ID", by.y = "ID", 
                     all.x = TRUE, all.y = FALSE, sort = FALSE)  #rec order unchanged!
activ.names <- NULL


## read the IDs of the person subjects for TEST and TRAIN data
test.subj  <- read.table(file = paste(data.dir, "test/subject_test.txt", sep = ""), 
                         col.names = "Subject.ID", 
                         colClasses = "integer",
                         header = FALSE)
train.subj <- read.table(file = paste(data.dir, "train/subject_train.txt", sep = ""), 
                         col.names = "Subject.ID", 
                         colClasses = "integer",
                         header = FALSE)


## add subject and activity columns to TEST and TRAIN dataframes.
## final TEST and TRAIN data cover the requirements 3, 4 above!
test.subj.activ <- cbind(test.subj, test.activ)
test.data.final <- cbind(test.subj.activ, test.data)  #final TEST data
test.data <- NULL; test.subj <- NULL; test.activ <- NULL; test.subj.activ <- NULL
train.subj.activ <- cbind(train.subj, train.activ)
train.data.final <- cbind(train.subj.activ, train.data)  # final TRAIN data
train.data <- NULL; train.subj <- NULL; train.activ <- NULL; train.subj.activ <- NULL


## put together TEST and TRAIN data to form a single dataset.
## covers requirement 1 above!
tt <- rbind(test.data.final, train.data.final)
test.data.final <- NULL; train.data.final <- NULL


## extracts only the measurements on the mean and standard deviation for 
## each measurement (var names containing "mean" or "std"), thus covering 
## requirement 2 above! Keep subject ID and activity name (cols 1 and 3)
req.cols <- c(1, 3, grep("(mean|std)", colnames(tt)))
tt.mean_std <- tt[ , req.cols]
tt <- NULL


## creates a tidy data set "summ.data" containing the average of each variable 
## for each activity / subject group, covering the requirement 5 above!
library(dplyr)
summ.data <- 
    tt.mean_std %>%
    group_by(Activ.Name, Subject.ID) %>% 
    summarize_each(funs(mean))
tt.mean_std <- NULL


## output the result "summ.data" in a txt file
write.table(summ.data, "summary_data.txt", row.names = FALSE)
