#Tidying up the Human Activity Recognition Dataset

**Author: https://github.com/anandi42**  

**Created for [Getting and Cleaning Data class on Coursera](https://www.coursera.org/learn/data-cleaning)**

_Updated: 11/19/2018_ 

**Summary**: Given the dataset available at [the UCI Machine Learning Repository]((https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)), we will construct a final tidy dataset, which contains an average value for each feature at every activity-subject pair. ([Source .zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).)

This repo contains:  
  * [run_analysis.R](run_analysis.R), an R script, which downloads the source data archive and creates the final dataset.  
  * [CodeBook.md](CodeBook.md), listing and description of variables in data.   
  * [tidydata.txt](tidydata.txt), the final data, which can be read into r with the code below:  `read.table("tidydata.txt", sep="\t", header = TRUE)`

Read on for a detailed description of the construction of this dataset.

#Setup steps (some optional)
The [run_analysis.R](run_analysis.R) file contains some optional setup steps like creating a subdirectory to work with the data. These can be supressed by commenting out the lines if needed. 
_Packages required_: dplyr, reshape2, gsubfn

#Creation of the Dataset
To create the dataset, 7 files from the original .zip archive were used

```
## [1] "UCI HAR Dataset/test/subject_test.txt"  
## [2] "UCI HAR Dataset/test/X_test.txt"        
## [3] "UCI HAR Dataset/test/y_test.txt"        
## [4] "UCI HAR Dataset/train/subject_train.txt"
## [5] "UCI HAR Dataset/train/X_train.txt"      
## [6] "UCI HAR Dataset/train/y_train.txt"      
## [7] "UCI HAR Dataset/features.txt"
```

 A user-defined function, `createtables`, reads in the data from the `X_test`(or `X_train`), `subject_test`(or `subject_train`), and `y_test`(or `y_train`) files to create the initial datasets. The measurement names in `features` are used as the column labels in `X`. The end result are 2 datasets. For both, the first colum is the subject identifier, the second colum are the activity identifiers (i.e 1-6), and the remaining columns correspond to the extracted feature measurements from `features`.  
 
###Step 1: Merging Test and Training Datasets:  
The test and training datasets are clipped together with `rbind`.  

###Step 2: Extract only the mean and standard deviation measurements:  
There are 33 features listed for the UCI dataset in the file `features_info.txt` (XYZ represents 3 variables, one for each axis): 

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

The search string "mean[^meanFreq]|std" was passed to `grep()` to get only those measurements representing mean and std. The meanFreq variable is the "Weighted average of the frequency components to obtain a mean frequency", so does not represent the mean of one of the 33 mean/std features. Therefore, the grep command returns 66 (33*2) variables. 

###Step 3: Use Descriptive Activity Names:  
Using the information in `activity_labels.txt`, the second column is converted from digits to descriptive labels.

###Step 4: Appropriately label the dataset:  
The current dataset is now a long form dataset with the columns:  
*SubjectID: subject number  
*ActivityType:activity labels  
*Measurement: name of feature  
*MeasureValue: value of Measurement  

 Since the values of Measurement will later be used as variable names, two cleanup steps are used to remove "()" and replace "-" with underscores. For example: `fBodyAcc-mean()-X` becomes `fBodyAcc_mean_X`. 

###Step 5: Create a second indepedent tidy dataset:  
The current long form dataset is casted into a wide form and also aggregated by the mean of the measurement at each subject-activity combination. This dataset is written to a text file so that it can be read back into R, like this: 

```r
final <- read.table("tidydata.txt", sep="\t", header = TRUE)
dim(final)
## [1] 180  68
```

Thus, the final dataset represents 66 mean and std observations obtained at each of the 6 activity types for each of the 30 subjects. This produces 180 (30*6) observations of 68 variables (66 mean/std values plus SubjectID and Activity Type).  

This final dataset represents a tidy dataset because it fullfills the requirements of [one variable per column, and one observation per row](http://vita.had.co.nz/papers/tidy-data.pdf). The columns are variables that represent the subject number, activity type, and then the mean value of each of the 66 mean and std features. Each row is a single mean observation for one subject at one specific activity. 
