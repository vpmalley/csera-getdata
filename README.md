csera-getdata
=============

Cleaning a data set, following the project of Getting and Cleaning Data course on Coursera

# Initial Data

In an archive
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And code book:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Analysis script

The script run_analysis.R takes care of the whole cleaning. There is a function run_analysis() that will download the data files, load the data in memory, clean the data as expected and write a text file including the final data set. It will return this final data set.

It is expected that the unzipped data is present in the directory where the run_analysis() function is executed (i.e. your directory should contain a folder "). The output will be a file avg_activity_subject.txt.
You can also download the data and unzip it by running the function download() in the same source file

setwd("myworkingdirectory")
source("run_analysis.R")
avg_activity_subject <- run_analysis()

# Code Book

This work is based on the following referenced work:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This work consists of a cleaned data set. The returned data set is a list containing tables for each of the variables. Each table presents the average value of the variable for an activity and a subject.

You can find a detailed list of the variables in the features.txt and features_info.txt files of the data.
