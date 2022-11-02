This document is a codebook that provides descriptions of the variables, the data, and all transformations and work used to process the data.

##The Data Source

Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The datafolder name is: '\UCI HAR Dataset'

Data set information details could be get from : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

 
##The main source data 

The main useful dataset/information includes the following files (other subfolder data files are not used for this project):

'README.txt'

'features_info.txt':  feature vector information.

'features.txt':   all features.

'activity_labels.txt': activity names.

'train/X_train.txt': training set.

'train/y_train.txt': training labels.

'test/X_test.txt': test set.

'test/y_test.txt': test labels.

 

##Data processing procedure by week4.R

1. Read the training and test data 
2. Read the features data,  link these information to training and test data, define variable names
3. select the mean and std variables
4. Marge data and activity labels by activity ID
4. Create a tidy data called 'final_data.txt' with the average of each variable for each activity and subject.
 