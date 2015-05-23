#Codebook for dataset created from the HAR dataset

  This document provides details the dataset [created by run_analysis.R.](run_analysis.R)
 
List of Variables:

```
##  [1] "SubjectID"                 "ActivityType"             
##  [3] "fBodyAcc_mean_X"           "fBodyAcc_mean_Y"          
##  [5] "fBodyAcc_mean_Z"           "fBodyAcc_std_X"           
##  [7] "fBodyAcc_std_Y"            "fBodyAcc_std_Z"           
##  [9] "fBodyAccJerk_mean_X"       "fBodyAccJerk_mean_Y"      
## [11] "fBodyAccJerk_mean_Z"       "fBodyAccJerk_std_X"       
## [13] "fBodyAccJerk_std_Y"        "fBodyAccJerk_std_Z"       
## [15] "fBodyAccMag_mean"          "fBodyAccMag_std"          
## [17] "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"  
## [19] "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 
## [21] "fBodyBodyGyroMag_mean"     "fBodyBodyGyroMag_std"     
## [23] "fBodyGyro_mean_X"          "fBodyGyro_mean_Y"         
## [25] "fBodyGyro_mean_Z"          "fBodyGyro_std_X"          
## [27] "fBodyGyro_std_Y"           "fBodyGyro_std_Z"          
## [29] "tBodyAcc_mean_X"           "tBodyAcc_mean_Y"          
## [31] "tBodyAcc_mean_Z"           "tBodyAcc_std_X"           
## [33] "tBodyAcc_std_Y"            "tBodyAcc_std_Z"           
## [35] "tBodyAccJerk_mean_X"       "tBodyAccJerk_mean_Y"      
## [37] "tBodyAccJerk_mean_Z"       "tBodyAccJerk_std_X"       
## [39] "tBodyAccJerk_std_Y"        "tBodyAccJerk_std_Z"       
## [41] "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"      
## [43] "tBodyAccMag_mean"          "tBodyAccMag_std"          
## [45] "tBodyGyro_mean_X"          "tBodyGyro_mean_Y"         
## [47] "tBodyGyro_mean_Z"          "tBodyGyro_std_X"          
## [49] "tBodyGyro_std_Y"           "tBodyGyro_std_Z"          
## [51] "tBodyGyroJerk_mean_X"      "tBodyGyroJerk_mean_Y"     
## [53] "tBodyGyroJerk_mean_Z"      "tBodyGyroJerk_std_X"      
## [55] "tBodyGyroJerk_std_Y"       "tBodyGyroJerk_std_Z"      
## [57] "tBodyGyroJerkMag_mean"     "tBodyGyroJerkMag_std"     
## [59] "tBodyGyroMag_mean"         "tBodyGyroMag_std"         
## [61] "tGravityAcc_mean_X"        "tGravityAcc_mean_Y"       
## [63] "tGravityAcc_mean_Z"        "tGravityAcc_std_X"        
## [65] "tGravityAcc_std_Y"         "tGravityAcc_std_Z"        
## [67] "tGravityAccMag_mean"       "tGravityAccMag_std"
```
  
The first two variables are: 

  *`SubjectID`: subject number, (1-30)    
  
  *`ActivityType`: activity labels (WALKNG, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 
      
  The rest of the variables represent the average mean and std measurements for each of 33 features, aggregated for each subject and each activity. The original features were:
  
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

  Each of the features above had a `mean()` and `std()` value, which were extracted and then averaged at each subject-activity combination. The names of the features were slightly modified to get rid of special characters () and - just to make manipulating the variables in the dataset a little cleaner. 

