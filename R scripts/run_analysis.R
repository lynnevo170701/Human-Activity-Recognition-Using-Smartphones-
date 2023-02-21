#download zip files and unzip files
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, destfile = "./mydata.zip")
unzip("./mydata.zip")
library(tidyverse)
#read activity labels + features
#using read.delim() to read .txt files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt"
                             , header = F
                             , col.names = c("ClassLabels", "ActivityName"))
features <- read.table("./UCI HAR Dataset/features.txt"
                       , header = F
                       , col.names = c("Number", "FeatureName"))
mean_std_indices <- grep("(mean|std)\\(\\)"
                            , features$FeatureName) #two backslash to specify parenthesis ()
measurements <- features[mean_std_indices, "FeatureName"]
measurements <- gsub('[()]', "", measurements)

#read train data sets
train_df <- read.table("./UCI HAR Dataset/train/X_train.txt"
                      
                       , header = F)
train_df <- train_df[, mean_std_indices] #only select the mean and std columns
colnames(train_df) = measurements
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt"
                           , header = F
                           , col.names = "Activity")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt"
                           , header = F
                           , col.names = "SubjectNumber")
train_df <- cbind(train_subject, train_labels, train_df)

#read test data sets
test_df <- read.table("./UCI HAR Dataset/test/X_test.txt"
                      , header = F)
test_df <- test_df[, mean_std_indices]
colnames(test_df) = measurements
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt"
                          , header = F
                          , col.names = "Activity")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt"
                           , header = F
                           , col.names = "SubjectNumber")
test_df <- cbind(test_subject,test_labels, test_df)

#merge two data sets
merged_df <- rbind(train_df,test_df)

#changing activity labels to corresponding activity names
merged_df$Activity <- sapply(merged_df$Activity, function(x) {activity_labels$ActivityName[x]})

#average of each variable for each activity and each subject
tidy_data <- merged_df %>% 
  group_by(SubjectNumber, Activity) %>% 
  summarise(across(where(is.numeric), mean),
            .groups = "drop")
colnames(tidy_data) <- gsub("BodyBody", "Body", colnames(tidy_data))

#export merged_df as tidy_data.txt file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)
