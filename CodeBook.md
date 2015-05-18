# Getting and Cleaning Data: Course Project
Sunday, May 17, 2015  
#Codebook for Tidy UCI HAR Data Set

  This document provides details about the construction and content of the tidy data set generated from the file run_ananlysis.R.  
  The source of the [data][1] is UCI's Machine Learning repository. Information about the original data [can be found here][2].  
  
 
##Creation of the Dataset
  The file runanalysis.R provides the code used to process and tidy the dataset. Processing starts with a downloaded zip file and ends with a single tidy dataset written to a text file.  
  After downloading the source data file, reading the description of the UCI dataset, we see that there are 8 key files that will construct our datasets:
 
```
## [1] "UCI HAR Dataset/test/subject_test.txt"  
## [2] "UCI HAR Dataset/test/X_test.txt"        
## [3] "UCI HAR Dataset/test/y_test.txt"        
## [4] "UCI HAR Dataset/train/subject_train.txt"
## [5] "UCI HAR Dataset/train/X_train.txt"      
## [6] "UCI HAR Dataset/train/y_train.txt"      
## [7] "UCI HAR Dataset/activity_labels.txt"    
## [8] "UCI HAR Dataset/features.txt"
```
  
  A user-defined function, `createtables`, puts together three tables to generate the datasets: `X_test`, `subject_test`, and `y_test` (or train) to create the initial datasets. The measurement names in `features` are used as the column labels in `X`. The end result is a dataset where the first colum is the subject identifier, the second colum are the activity identifiers (i.e 1-6), and the remaining columns correspond to the extracted feature measurements from `features`.  
  
###Step 1: Merging Test and Training Datasets:  
The test and training datasets are clipped together with `rbind`.  

###Step 2: Extract only the mean and standard deviation measurements:  
There are 33 features listed for the UCI dataset are (where XYZ represents 3 variables, one for each axis): 

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag    

The search string "mean[^meanFreq]|std" is passed to `grep()` to get only those measurements representing mean and std. The meanFreq variable is not one of the `mean()` or `std()` measures of the 33 features listed above.  

###Step 3: Use Descriptive Activity Names:  
Using the `activity_labels` file, we change the second column of the curent data from digits 1-6 to descriptive labels: WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING. 

###Step 4: Appropriately label the dataset:  
The current dataset is now a long form dataset with the column labels `SubjectID`, `ActivityType`, `Measurement`, `MeasureValue`, representing the subject number, activity labels, the specific feature measurement, and the value of that measurement. We also perform 2 clean up steps to remove "()" from the feature variable names, and replace "-" with underscores. Thus `fBodyAcc-mean()-X` becomes `fBodyAcc_mean_X`. This cleanup step is done 

###Step 5: Creating a second indepedent tidy dataset:  
The current long form dataset is casted into a wide dataset, aggregating by the mean of the measurement at each subject and each activity. This dataset is written to a text file so that it can be read back into R. 


```r
final <- read.table("tidydata.txt", sep="\t", header = TRUE)
dim(final)
```

```
## [1] 180  68
```

Thus, the final dataset represents the means and st. dev. of 33 measures at each of the 6 activity types for each of the 30 subjects, or 180 observations of 68 variables (66 mean/std values plus SubjectID and Activity Type).  

This final dataset represents a tidy dataset because it fullfills the requirements of [one variable per column, and one observation per row][3]. The colums represent Subject, ActivityType and then the average mean and std of each of the 33 features. 


[1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "UCI HAR Dataset"  

[2]: https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Details of UCI HAR Dataset"  

[3]: http://vita.had.co.nz/papers/tidy-data.pdf "Hadley Wickham, Tidy Data"
