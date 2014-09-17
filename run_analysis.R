#downloads and unzips data file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip")
unzip("Dataset.zip")

#reads in files as text
trainx=read.table("./UCI HAR Dataset/train/X_train.txt")
trainy=read.table("./UCI HAR Dataset/train/y_train.txt")
trainsub=read.table("./UCI HAR Dataset/train/subject_train.txt")

testx=read.table("./UCI HAR Dataset/test/X_test.txt")
testy=read.table("./UCI HAR Dataset/test/y_test.txt")
testsub=read.table("./UCI HAR Dataset/test/subject_test.txt")

features=read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
activity=read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)

#1 separately merge train and test files, then merge together
trainMerge=cbind(trainsub,trainy, trainx)
testMerge=cbind(testsub, testy, testx)
mergeAll=rbind(trainMerge,testMerge)

#2 finds mean and std deviation for each of 561 measurements
#can disregard first two columns volunteer and activity
means=colMeans(mergeAll)
stddevs=apply(mergeAll, 2, sd)
meanStddev=cbind(means,stddevs)

#3 activity is displayed by name instead of numbers
for (i in 1:6){
    indexes = (mergeAll[,2]==i)
    for (j in 1:length(indexes)) {
        if (indexes[j] == TRUE) {

            mergeAll[j,2]=activity[i,2]
        }
    }
}

#4 part 1 extract the names the 561-feature vector 
featuresNames=features[,2]
#name the datatable with the correct values: subject/volunteer, y/labels/activity
colnames(mergeAll)[1] = "volunteer"
colnames(mergeAll)[2] = "activity"

#5 creates dataset with average of each variable for each activity and each subject
library(reshape2)
dataMelt=melt(mergeAll, id=c("volunteer", "activity"), measure.vars=c(3:563))
meanData=dcast(dataMelt, volunteer + activity ~ variable, fun.aggregate = mean)

#4 part 2 rename columns, this time with featurenames, naming is occuring after dcast because only 477 unique names, instead of 561
names(meanData)=c("volunteer","activity",featuresNames)

#write data table
write.table(meanData, file="tidyData.txt", row.name=FALSE)

#extra code
#sdData=dcast(dataMelt,volunteer+activity ~ variable, sd, na.rm=TRUE)

#library(plyr)
#meanData=ddply(mergeAll,.(volunteer,variable),summarize, mean=mean(value))
#meanVolunteer=dcast(meanData, volunteer+activity~variable, value.var="mean")

#sdData=ddply(dataMelt,.(volunteer,variable),summarize, sd=sd(value))
#sdVolunteer=dcast(sdData, volunteer+activity~variable, value.var="sd")
#data=dcast(dataMelt, volunteer ~variable, mean)

#sdVolunteer=ddply(mergeAll,.(volunteer),colwise(sd))
#meanVolunteer=ddply(mergeAll,.(volunteer),numcolwise(ave))

#data=ddply(dataMelt,.(volunteer,variable),summarize, mean=mean(value))
#meanVolunteer=dcast(data, volunteer~variable, value.var="mean")
