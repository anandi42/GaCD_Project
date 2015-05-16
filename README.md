# GaCD_Project
##Getting and Cleaning Data Project

**Summary**: Starting with the dataset available at [the UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), we construct a final tidy dataset consisting of the average of each variable for each activity and each subject. 

This repo contains:  
	* [run_analysis.R]("run_analysis.R"), a script, which when run, will download the dataset, and create the final dataset.  
	* [CodeBook.md]("CodeBook.md"), a markdown file containing information on the creation and contents of the final dataset created by run_analysis.R.   
	* [tidydata.txt]("tidydata.txt"), the final data, which can be read into r with the code below: 

`read.table("tidydata.txt", sep="\t", header = TRUE)`



