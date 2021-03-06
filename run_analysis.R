#Getting and Cleaning Data Peer Assesment #1
#See README for further explanation of the steps coded below. 

##Setup Steps
##packages required: dplyr, reshape, gsubfn
rm(list = ls())
library(dplyr)
library(reshape2)
library(gsubfn)

#Use the following lines if you wish to work in a subdiretory from working diretory for this project

subDir <- "data"
if (dir.exists(subDir)){
  setwd(subDir)
} else {
  dir.create(subDir, showWarnings = FALSE)
  setwd(subDir)
}


##Get the Data
download.path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "UCIdataset.zip"

if (!file.exists(filename)) {
  download.file(download.path, filename)
}

filepaths <- c("UCI HAR Dataset/test/subject_test.txt",
               "UCI HAR Dataset/test/X_test.txt",
               "UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/train/subject_train.txt",
               "UCI HAR Dataset/train/X_train.txt",
               "UCI HAR Dataset/train/y_train.txt",
               "UCI HAR Dataset/features.txt",
               ##Not used by script, but useful for reference
               "UCI HAR Dataset/activity_labels.txt",
               "UCI HAR Dataset/features_info.txt",
               "UCI HAR Dataset/README.txt")
unzip(filename, files = filepaths)

##Step 1: Merge test and training sets
createtables <- function(dir, group) {
  path1 <- file.path(dir, group, paste0("subject_", group, ".txt"))
  subj <- read.table(path1, col.names="subj")
  path2 <- file.path(dir, group, paste0("X_", group, ".txt"))
  xdata <- read.table(path2)
  path3 <- file.path(dir, group, paste0("y_", group, ".txt"))
  ydata <- read.table(path3, col.names="act")
  path4 <- file.path(dir, "features.txt")
  features <- read.table(path4, stringsAsFactors = FALSE)
  colnames(xdata) <- features$V2
  data <- cbind(subj, ydata, xdata)
  return(invisible(data))
}

testdata <- createtables("UCI HAR Dataset", "test")
traindata <- createtables("UCI HAR Dataset", "train")

alldata <- rbind(testdata, traindata)
rm(list = c("testdata", "traindata"))

#Step 2: Extract mean and std measuments
idx <- grep("mean[^meanFreq]|std", colnames(alldata))
alldata <- alldata[,c(1,2,idx)]  

#Use Descriptive Activity Names *using info in activity_labels.txt*
alldata$act <- gsubfn("[1|2|3|4|5|6]",list("1"="WALKING", 
                                           "2"="WALKING_UPSTAIRS", 
                                           "3"="WALKING_DOWNSTAIRS",
                                           "4"="SITTING",
                                           "5"="STANDING", 
                                           "6"="LAYING"), 
                              as.character(alldata$act))

#Step 4:  Appropriately label the dataset
alldata <- melt(alldata, id=c("subj", "act")) 
colnames(alldata) <- c("SubjectID", "ActivityType", "Measurement", "Measure_Value") 
alldata$Measurement <- gsub("\\()", "", alldata$Measurement)
alldata$Measurement <- gsub("\\-", "\\_", alldata$Measurement)
  
#Step 5: Create a second indepedent tidy dataset
final <- dcast(alldata, SubjectID + ActivityType ~ Measurement, mean, value.var="Measure_Value")
write.table(final, "tidydata.txt", row.names=FALSE, sep="\t")


