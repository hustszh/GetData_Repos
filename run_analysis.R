library(dplyr)

# 1. read train and test data
train_data <- read.fwf("./data/train/X_train.txt", widths=c(-2, 14, rep( c(-1, 15), times=560 ) ) )
test_data <- read.fwf("./data/test/X_test.txt", widths=c(-2, 14, rep( c(-1, 15), times=560 ) ) )

## bind train and test data together
total_data <- rbind(train_data, test_data)

# 2. read activity and subject data
train_activity_data <- read.csv("./data/train/y_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_subject_data <- read.csv("./data/train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE)

test_activity_data <- read.csv("./data/test/y_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_subject_data <- read.csv("./data/test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE)

total_activity_subject_data <- rbind( cbind(train_activity_data, train_subject_data),
                                      cbind(test_activity_data, test_subject_data) )
names(total_activity_subject_data) <- c("activity", "subject")

# 3. read features.txt file
features <- read.csv("./data/features.txt", sep=" ", header=FALSE, stringsAsFactors=FALSE)

## set column names for total data
names(total_data) <- features[,2]

# 4. choose the columns that column name contains "mean()" or "std()"
mean_std_cols <- which(grepl("mean\\(\\)", names(total_data)) | grepl("std\\(\\)", names(total_data)) )

## bind activity_subject data and total data
mean_std_data <- cbind( total_activity_subject_data, total_data[, mean_std_cols] )

# 5. calculate the average of each variable for each activity and each subject in mean_std_data
average_data <- mean_std_data %>%
                group_by( activity, subject ) %>%
                summarise_each( funs(mean) )

# 6. read activity label data
activity_label_data <- read.csv("./data/activity_labels.txt", sep=" ", 
                                header=FALSE, stringsAsFactors=FALSE )
names(activity_label_data) <- c("activity","activity_label")

# 7. merge activity_label_data and average_data
final_data <- inner_join(activity_label_data, average_data, by="activity")

# 8. output the result
write.table(final_data, file="tidyData.txt", sep=",", row.names=FALSE)

