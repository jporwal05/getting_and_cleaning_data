# load dplyr
library(dplyr)

# download the file if not exists and extract it
if (!file.exists("SensorData.zip")) {
    # download the file
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  "SensorData.zip", "curl")
    # extract the zip file
    unzip("SensorData.zip")
}

# read the features
features <- read.delim("./UCI HAR Dataset/features.txt", 
                header = FALSE, 
                sep = "")

# read the activity labels corresponding to the activity id(s)
activity_labels <- read.delim("./UCI HAR Dataset/activity_labels.txt", 
                 header = FALSE, 
                 sep = "", 
                 col.names = c("Activity_ID", "Activity"))

# tidy and make up the training dataset first
# load measurements from training set
training_data <- read.delim("./UCI HAR Dataset/train/X_train.txt", 
                 header = FALSE, 
                 sep = "", 
                 col.names = features[, c(2)])

# load the subject data from training set
train_subject_data <- read.delim("./UCI HAR Dataset/train/subject_train.txt", 
                 header = FALSE, 
                 sep = "", 
                 col.names = c("Subject"))

# load the activity id(s) from training set
train_activities_data <- read.delim("./UCI HAR Dataset/train/y_train.txt", 
                 header = FALSE, 
                 sep = "", 
                 col.names = c("Activity_ID"))

# merge the train_activites_data and train_training_data
train_training_activities <- cbind(train_activities_data, training_data)

# merge the train_subject_data with train_training_activities data
train_subject_training_activities <- cbind(train_subject_data, train_training_activities)

# merge activity_labels with the train_subject_training_activities data using Activity_ID
train_labels_subject_training_activities <- merge(activity_labels, 
                                                  train_subject_training_activities, by = "Activity_ID")

# tidy and make up the test dataset
# load measurements from test set
test_data <- read.delim("./UCI HAR Dataset/test/X_test.txt", 
                       header = FALSE, 
                       sep = "", 
                       col.names = features[, c(2)])

# load the subject data from test set
test_subject_data <- read.delim("./UCI HAR Dataset/test/subject_test.txt", 
                       header = FALSE, 
                       sep = "", 
                       col.names = c("Subject"))

# load the activity id(s) from test set
test_activities_data <- read.delim("./UCI HAR Dataset/test/y_test.txt", 
                       header = FALSE, 
                       sep = "", 
                       col.names = c("Activity_ID"))

# merge the test_activites_data and test_data
test_testing_activities <- cbind(test_activities_data, test_data)

# merge the test_subject_data with test_testing_activities data
test_subject_testing_activities <- cbind(test_subject_data, test_testing_activities)

# merge activity_labels with the test_subject_testing_activities data using Activity_ID
test_lables_subject_testing_activities <- merge(activity_labels, 
                                                test_subject_testing_activities, by = "Activity_ID")

# merge train_labels_subject_training_activities with test_lables_subject_testing_activities
merged_data <- rbind(train_labels_subject_training_activities, test_lables_subject_testing_activities)

# extract only the measurements on the mean and standard 
# deviation for each measurement
merged_data_mean_std <- merged_data[, c("Subject", 
             "Activity",
             names(merged_data)[grep("(\\.mean\\.)|(\\.std\\.)", names(merged_data))])]

# make the column names more readable
colnames(merged_data_mean_std) <- c(sapply(names(merged_data_mean_std), 
                                           sub, pattern = "\\.\\.\\.", replacement = "\\."))
colnames(merged_data_mean_std) <- c(sapply(names(merged_data_mean_std), 
                                           sub, pattern = "\\.\\.$", replacement = ""))
colnames(merged_data_mean_std) <- c(sapply(names(merged_data_mean_std), 
                                           sub, pattern = "BodyBody", replacement = "Body"))
colnames(merged_data_mean_std) <- c(sapply(names(merged_data_mean_std), 
                                           toupper))

# convert to table df
merged_data_mean_std <- tbl_df(merged_data_mean_std)

# independent tidy data set with the average of each variable for each 
# activity and each subject.
tidy <- merged_data_mean_std %>% 
    group_by(SUBJECT, ACTIVITY) %>% 
    summarise_all("mean")

# print the end result
print(tidy)

# write the tidy data into a file
write.table(tidy, file = "jporwal05_tidy.txt", row.names = FALSE)