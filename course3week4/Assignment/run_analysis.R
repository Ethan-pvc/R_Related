# load library
library(dplyr)

# set working directory and path
setwd("C:/Users/Sinyi/Desktop/Coursera/Course_3/Week4/Assignment")

# load the activity label and variable name
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt",
                             col.names=c("activityID","activityLabel"))
var_name <- read.table("./UCI HAR Dataset/features.txt")

# load the training and testing data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=var_name[,2])
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="activityID")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.name="subjectID")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=var_name[,2])
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="activityID")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.name="subjectID")


# 1. Merges the training and the test sets to create one data set
train_set <- cbind(y_train,subject_train,x_train)
test_set <- cbind(y_test,subject_test,x_test)
total_set <- rbind(train_set,test_set)

# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
col_names <- colnames(total_set)
mean_and_sd <- (grepl("activityID" , col_names) | grepl("subjectID" , col_names) | 
        grepl("mean.." , col_names) | grepl("std.." , col_names) )
set_mean_and_sd <- total_set[ , mean_and_sd == TRUE]

# 3. Uses descriptive activity names to name the activities in the data set
set_mean_and_sd$activityID <- factor(set_mean_and_sd$activityID, 
                                     labels = as.character(activity_label[,2]))

# 4. Appropriately labels the data set with descriptive variable names.
des_col <- colnames(set_mean_and_sd)
for (i in 1:length(des_col)) 
{
   
    des_col[i] <- gsub("Acc", "Accelerator", des_col[i])
    des_col[i] <- gsub("Mag", "Magnitude", des_col[i])
    des_col[i] <- gsub("Gyro", "Gyroscope", des_col[i])
    des_col[i] <- gsub("^t", "time", des_col[i])
    des_col[i] <- gsub("^f", "frequency", des_col[i])
}
colnames(set_mean_and_sd) <- des_col

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
Average_table <- set_mean_and_sd %>% 
    group_by(activityID, subjectID) %>% 
    summarize_all(funs(mean))

write.table(Average_table, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE)


