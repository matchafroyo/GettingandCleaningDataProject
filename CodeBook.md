---
title: "CodeBook.md for run_analysis.R"
author: "matchafroyo"
date: "Tuesday, September 16, 2014"
output: html_document
---

###Synoposis
This project makes a tidy data set from data collected from the accelerometers from the Samsung Galaxy S smartphone. For more info, README.md 

###Merging of data
The train and test files represent ~70% and ~30% of the total data.  The separated data are merged together with the following strategy:
    1.The train set/data, labels/activity, and subject/volunteer are merged together
    2.The test set/data, labels/activity, and subject/volunteer are merged together.
    3.The train merge and test merge are merged into one datatable mergeAll.
    
###Labeling of data
    1.mergeAll is labeled appropriately with "volunteer", "activity", and names from features.txt
    Note, the name features.txt has only 477 unique names, even though there is unique data for 561 data.  
    Due to nature of dcast, the names from features.txt had to be added after dcast.
    2.The labels/activity #s are replaced by descriptions from activity_labels.txt
    
###Analysis of data
Mean and standard devations for each measurement were calculated and an independent tidy data set with the average of each variable for each activity and each subject was created.

###Variables
-volunteer: id-ed by numbers 1-30 for the 30 volunteers between 19-48 years who participated

-activity: displays 1 of 6 activities-LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS (the activities appear in this alphabetical order for each volunteer in the tidy data set): they performed while wearing a smartphone (Samsung Galaxy S II) on the waist

-561 feature vector with time and frequency domain variables were measured: having names such as "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z"... "angle(Z,gravityMean)"