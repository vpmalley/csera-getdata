
download <- function() {
# downloading, unzipping files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata-course-project.zip", method = "curl")
unzip("getdata-course-project.zip")
}

run_analysis <- function() {

setwd("UCI HAR Dataset")

# loading data sets in memory

features <- read.table("features.txt")
# transforming the factor containing the feature values in a vector of character
features_names <- as.character(levels(features$V2))[features$V2]
activity_labels <- read.table("activity_labels.txt", col.names = c("act_index", "activity"))

setwd("train")
# the main train data
train_data <- read.table("X_train.txt", col.names = features_names) # the features are the column names
# the activity data (activity ids) for train
train_activity <- read.table("y_train.txt")
# the subject identifiers for the train data
train_subject <- read.table("subject_train.txt")

setwd("..")
setwd("test")
# the main test data
test_data <- read.table("X_test.txt", col.names = features_names) # the features are the column names
# the activity data (activity ids) for test
test_activity <- read.table("y_test.txt")
# the subject identifiers for the test data
test_subject <- read.table("subject_test.txt")

# aggregating data about activity to test and train data sets
test_data$act_index <- test_activity$V1
train_data$act_index <- train_activity$V1

# aggregating data about subject to test and train data sets
test_data$subject <- test_subject$V1
train_data$subject <- train_subject$V1

# merging the two data sets (aggregating the rows of the two data sets for all columns)
all_data <- merge(test_data, train_data, all = TRUE)

# we merge the activity labels to the current data
data_labelled <- merge(all_data, activity_labels, by.x = "act_index", by.y = "act_index")

# At that point, the data_labelled data set has been verified with
# 564 cols, the 561 of the initial data set, the activity id (act_index), the activity label (activity) and the subject identifier (subject)
# 10299 rows, corresponding to the sum of the rows of the test and train data sets


# Extracting only the mean and standard

# determining the columns containing "mean" or "std"
meanstdCols <- grep("[Mm]ean|[Ss]td", names(data_labelled))
# we aggregate all interesting columns, including the activity and subject id
allCols <- c(names(data_labelled)[meanstdCols], "activity", "subject")

# We restrict the data to the columns we are interested in
mean_std_data <- data_labelled[, allCols]



setwd("../..")
# for each interesting variable, we build a table giving the average value for each subject and activity
avg_activity_subject = list()
for (colName in names(mean_std_data)) {
  if ((colName != "activity") && (colName != "subject")) {
    avg_activity_subject[[colName]] <- tapply(mean_std_data[, colName], data.frame(mean_std_data$activity, mean_std_data$subject), mean)
    write.table(avg_activity_subject[[colName]], "avg_activity_subject.txt", row.name = TRUE, append = TRUE)
    
  }
}

}

