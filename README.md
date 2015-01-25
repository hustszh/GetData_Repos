# GetData_Repos
## Project Target
This is the project for the "Getting and Cleaning Data" Course Project on Coursera, offered by Johns Hopkins University. The target is to produce a tidy dataset from the UCI HAR Dataset. The raw data can be found from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

## Step
1. download the raw data and extract it to a directory called "data" in R working directory.
2. install package "dplyr" if the package has not been installed yet.
3. run the stript "run_analysis.R".
4. the file "tidyData.csv" is the output result.

## How does script works
1. read train and test data, then bind them together, the result called "total_data".
2. read activity and subject data, the result called "activity_subject_data".
3. read "features.txt" file.
4. choose the columns that column name contains "mean()" or "std()" from the data set total_data, then bind activity_subject_data and total_data, the result called "mean_std_data".
5. calculate the average of each variable for each activity and each subject in mean_std_data.
6. read activity label data, the result called "activity_label_data".
7. merge activity_label_data and average_data by "activity", the result called "final_data".
8. output the final data to file called "tidyData.csv".

## Codebook
check "codebook.md"
