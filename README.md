# Getting and Cleaning Data Course Project
getdata() function extracts subject, activity, and features from a given dataset - test or train. 
Feature filtering and activity name abbreviation is in the function.
Test and train data are combined into the dataset variable, and then averages are calculated using split-apply-combine.
The result is dataset.means variable with:
- subject, activity, and feature columns (tBodyAcc-mean()-X and etc)
- distinct combinations of subject and activity in each row
- mean value of a feature for the subject and activity in the row