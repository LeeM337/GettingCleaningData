
library(plyr)

activityKey <- read.table("./UCI HAR Dataset/activity_labels.txt")

#read in the feature names and extract the position and names of those which are
#the mean or std of a feature
#e.g. in "featuresMean" column 1 contains the index of the feature named in column 2
features <- read.table("./UCI HAR Dataset/features.txt")
featuresMean <- features[grep("mean[()]",features[,2]),]
featuresStd <- features[grep("std[()]",features[,2]),]
featuresMean[,2] <- as.character(featuresMean[,2])
featuresStd[,2] <- as.character(featuresStd[,2])

#remove "-" and "()" symbols from feature names
featuresMean[,2] <- gsub("-|[()]","",featuresMean[,2])
featuresStd[,2] <- gsub("-|[()]","",featuresStd[,2])

#some feature names in the features.txt file appear to have a naming error and do
#not correspond to the names stated in features_info.txt
#I replace occurences of "BodyBody" with just "Body" to match the definitions
#given in features_info.txt
featuresMean[,2] <- gsub("BodyBody","Body",featuresMean[,2])
featuresStd[,2] <- gsub("BodyBody","Body",featuresStd[,2])

#rewrite the feature names as all lower case letters inline with principles of tidy-data
featuresMean[,2] <- tolower(featuresMean[,2])
featuresStd[,2] <- tolower(featuresStd[,2])

#read in data from test directory
subjectTest <-read.table("./UCI HAR Dataset/test/subject_test.txt")
labelsTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
dataTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

#read in data from train directory
subjectTrain <-read.table("./UCI HAR Dataset/train/subject_train.txt")
labelsTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
dataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

#combine the test and train data
colnumbers <- c(featuresMean[,1],featuresStd[,1])
fullData <- rbind(dataTest[,colnumbers],dataTrain[,colnumbers])
names(fullData) <- c(featuresMean[,2],featuresStd[,2])

#add a subject and activity column
fullData$subject <- c(subjectTest[,],subjectTrain[,])
fullData$activity <- activityKey[c(labelsTest[,],labelsTrain[,]),2]

#create the tidy-data by averaging each feature for each subject and activity
summarisedData <- ddply(fullData,.(subject,activity),numcolwise(mean))
write.table(summarisedData, file="tidydata.txt", row.names=FALSE)




