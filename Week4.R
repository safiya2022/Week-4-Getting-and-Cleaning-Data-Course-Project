library(dplyr)
library(data.table)
setwd("C:/Users/09833/Documents/R_training/Data_cleaning/week4")

datapath = ("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
files = list.files(datapath, recursive=TRUE)

##############1.Merges the training and the test sets to create one data set.######################

# Read the training data

xtrain = read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE)
ytrain = read.table(file.path(datapath, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE)


# Read the testing data

xtest = read.table(file.path(datapath, "test", "X_test.txt"),header = FALSE)
ytest = read.table(file.path(datapath, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(datapath, "test", "subject_test.txt"),header = FALSE)

# Read the features and activity data, link the features(col names) to the data

features = read.table(file.path(datapath, "features.txt"),header = FALSE)


colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"


# Merge all data together

total_train = cbind(ytrain, subject_train,xtrain)
total_test = cbind(ytest, subject_test, xtest)
all_data = rbind(total_train, total_test)


##############2. Extracts only the measurements on the mean and standard deviation for each measurement. ######################

colname = colnames(all_data)
select_name =  (grepl("activityId" , colname) | grepl("subjectId" , colname) | grepl("mean.." , colname) | grepl("std.." , colname))
select_data <- all_data[, select_name == TRUE]

##############3/4. Use descriptive activity names to name the activities in the data set with descriptive variable names. ######################
activityLabels = read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)
colnames(activityLabels) <- c('activityId','activityType')
activity_data <-  merge(select_data, activityLabels, by='activityId', all.x=TRUE)

##############5. creates a second, independent tidy data set with the average of each variable for each activity and each subject. ######################

final_data <- activity_data %>%
        group_by(subjectId,activityId) %>%
        summarize_all(mean,na.rm = TRUE) %>%
        ungroup

write.table(final_data, "final_data.txt",row.name=FALSE)

