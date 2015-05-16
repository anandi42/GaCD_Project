#Getting and Cleaning Data Peer Assesment #1

setwd("~/data/GaCD_Project/")
rm(list = ls())
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
               "UCI HAR Dataset/activity_labels.txt",
               "UCI HAR Dataset/features.txt")
unzip(filename, files = filepaths)


createtables <- function(dir, group) {
  path1 <- file.path(dir, group, paste0("subject_", group, ".txt"))
  subj <- read.table(path1)
  path2 <- file.path(dir, group, paste0("X_", group, ".txt"))
  xdata <- read.table(path2)
  path3 <- file.path(dir, group, paste0("y_", group, ".txt"))
  ydata <- read.table(path3)
  path3 <- file.path(dir, "activity_labels.txt")
  activity <- read.table(path3, stringsAsFactors = FALSE)
  path4 <- file.path(dir, "features.txt")
  features <- read.table(path4, stringsAsFactors = FALSE)
  colnames(xdata) <- features$V2
  data <- cbind(subj, ydata, xdata)
  idx <- grep("mean[^meanFreq]|std", features$V2)
  feature_idx <- idx + 2
  means <- data[,c(1,2,feature_idx)]
  names(means)[1] <- "Subject"
  names(means)[2] <- "Activity"
  return(invisible(means))
}

testdata <- createtables("UCI HAR Dataset", "test")
traindata <- createtables("UCI HAR Dataset", "train")

#create tidy data

grouped_test <- testdata %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
grouped_train <- traindata %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

final_data <- rbind(grouped_test, grouped_train)

final_data$Activity <- gsubfn("[1|2|3|4|5|6]",list("1"="WALKING", 
                                                   "2"="WALKING_UPSTAIRS", 
                                                   "3"="WALKING_DOWNSTAIRS",
                                                   "4"="SITTING",
                                                   "5"="STANDING", 
                                                   "6"="LAYING"), 
                              as.character(final_data$Activity))

library(reshape2)
final_data <- melt(final_data, 
                   id=c("Subject", "Activity"), 
                   variable.name="Measurement", 
                   value.name="Mean_Value")





