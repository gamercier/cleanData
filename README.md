# Final Project - Getting and Cleaning Data.
# cleanData Repository
## G. Mercier
## Due 2015-06-21

This repository contains files associated with the final project in the
course, Getting and Cleaning Data Coursera Data Science Series. It is 
recommended that you read this document and the [CodeBook.md](CodeBook.md) before
digging any further.


The following files are in this repository:

File                 |   Description
---------------------|---------------------------------------------------
README.md           | Describes content and scripts using R markdown
CodeBook.md         | Details data, its source and processing.
data                 | Directory containing downloaded data.
run_analysis.R       | Master script to tidy data and create summary.
setWDir.R            | Script to set working directory to this repo.
downLoadData.R       | Script to download data file. Creates *data*.
readMergeClean.R     | Script to clean data. Creates *tidyData.csv*.
tidySummary.R        | Computes data summary. Creates *tidySummary.csv*.
tidyData.csv         | Output of readMergeClean.R script.
tidySummary.csv      | Output of tidySummary.R script.


All files are in the top directory of the repo, and the only subdirectory
is *data*. The directory tree for *data* is described in *Codebook.md*.

# Script operations

* Language: R version 3.2.0
* Dependencies: dplyr package version 0.4.1

The __run_analysis.R__ script is the master script. Running this script will
execute the following scripts in the order listed below:

1. setWDir.R
2. downLoadData.R
3. readMergeClean.R
4. tidySummary.R

None of the scripts take parameters. As the scripts run their
progress is displayed in the standard output.
It is assumed that there is an internet connection with downloading
privileges, and writting privileges in the working directory.

The readMergeClean.R script takes the data and generates a tidy data dataframe
that is written to *tidyData.csv*. This dataframe is then read by `tidySummary.R`
to generate the final tidy summary data submitted to the Courera assignment. The
submitted file is named *tidySummary.csv*

# setWDir.R

This script identifies the HOME directory and sets the working
directory to *HOME/git/cleanData*. However, it is easy to modify
so you can pick your own working directory. 

# downLoadData.R

This script uses built-in R functions to download the data,
uncompressed the downloaded zip file, and rename the default
uncompressed directory name to *data*.

The download url is hard coded to the one listed in the *Cookbook.md*.

# readMergeClean.R

This script assumes the data has been downloaded to a the *data* directory
with a tree structure as listed under the *Cookbook.md*. It is the default
tree structure you get from uncompressing the downloaded data. The script
__downLoadData.R__ will take care of these steps, and should be run before
the __readMergeClean.R__ script.

This script will read the data, create a series of dataframes to merge
the data in the *data/test* and *data/train* directories, select columns
from this merged data, and finally prepend columns to identify the subjects
and activity associated with the data. The final dataframe is written to a file,
*tidyData.csv*, using write.table function. This tidy data file can be read using
`read.table(file.path(GIT.repo,"tidyData.csv"),header=T)`


The specific steps are as follows:

1. Read Step:

   Reads the following files into dataframes using read.table:

   Source File       |   Description         |  Dataframe   |  Dimensions
   ------------------|-----------------------|---------------|--------------
   X_train.txt       | training: data        | dataTrain     |  7352x561  
   X_test.txt        | test: data            | dataTest      |  2947x561
   y_train.txt       | training: activity id | activityTrain |  7352x1  
   y_test.txt        | test: activity id     | activityTest  |  2947x1  
   subject_train.txt | training: subject id  | subjectsTrain |  7352x1  
   subject_test.txt  | test: subject id      | subjectsTest  |  2947x1  

   Note: All source files are in the *data* directory in text format
with no header. The "X" files contain real numbers in scientific
notation separated by blank spaces. The "y" and "subject" files
contain integer data in one column. For the "y" file the range is 1-6,
and for the "subject" files it is 1-30.

2. First Merge Step:

  Merges by appending dataTest to bottom of dataTrain using `rbind`.
Does the same for the subject ids and the activity codes.
This results in three dataframes with the following dimensions:

 Dataframe   |  Dimensions
 ------------|------------
 data        | 10299x561
 subjects    | 10299x1
 activity    | 10299x1
 
3. Clean Step:

   + Select data

     From the merged file (i.e. data) columns containg data that
is either "mean" or "std" are selected, and loaded into a new
dataframe, `selectedData` with dimensions 10299x66. For convenience
the column names in `selectedData` are renamed to provide descriptive
names consistent with those in the *features.txt* file. However, their
column order is preserved as listed in the table below. For example,
tAcc.avg.X, tAcc.avg.Y, and tAcc.avg.Z are in columns 1 through 3 of
`selectedDAta` (and subsequently columns 3 through 5 in `tidyData` given
the changes described below).


     Name in *feature.txt*      | Column Name in "data"   | Descriptive Name in `selectedData`
     ---------------------------|-------------------------|-----------------------------------
     tBodyAcc-mean()-XYZ        |   V1:V3                 |  tAcc.avg.XYZ        
     tBodyAcc-std()-XYZ         |   V4:V6                 |  tAcc.std.XYZ        
     tGravityAcc-mean()-XYZ     |   V41:V43               |  tGravityAcc.avg.XYZ 
     tGravityAcc-std()-XYZ      |   V44:V46               |  tGravityAcc.std.XYZ 
     tBodyAccJerk-mean()-XYZ    |   V81:V83               |  tAccJerk.avg.XYZ    
     tBodyAccJerk-std()-XYZ     |   V84:V86               |  tAccJerk.std.XYZ    
     tBodyGyro-mean()-XYZ       |   V121:V123             |  tGyro.avg.XYZ       
     tBodyGyro-std()-XYZ        |   V124:V126             |  tGyro.std.XYZ       
     tBodyGyroJerk-mean()-XYZ   |   V161:V163             |  tGyroJerk.avg.XYZ   
     tBodyGyroJerk-std()-XYZ    |   V164:V166             |  tGyroJerk.std.XYZ   
     tBodyAccMag-mean()         |   V201                  |  tAccMag.avg         
     tBodyAccMag-std()          |   V202                  |  tAccMag.std         
     tGravityAccMag-mean()      |   V214                  |  tGravityAccMag.avg  
     tGravityAccMag-std()       |   V215                  |  tGravityAccMag.std  
     tBodyAccJerkMag-mean()     |   V227                  |  tAccJerkMag.avg     
     tBodyAccJerkMag-std()      |   V228                  |  tAccJerkMag.std     
     tBodyGyroMag-mean()        |   V240                  |  tGyroMag.avg        
     tBodyGyroMag-std()         |   V241                  |  tGyroMag.std        
     tBodyGyroJerkMag-mean()    |   V253                  |  tGyroJerkMag.avg    
     tBodyGyroJerkMag-std()     |   V254                  |  tGyroJerkMag.std    
     fBodyAcc-mean()-XYZ        |   V266:V268             |  fAcc.avg.XYZ        
     fBodyAcc-std()-XYZ         |   V269:V271             |  fAcc.std.XYZ        
     fBodyAccJerk-mean()-XYZ    |   V345:V347             |  fAccJerk.avg.XYZ    
     fBodyAccJerk-std()-XYZ     |   V348:V350             |  fAccJerk.std.XYZ    
     fBodyGyro-mean()-XYZ       |   V424:V426             |  fGyro.avg.XYZ       
     fBodyGyro-std()-XYZ        |   V427:V429             |  fGyro.std.XYZ       
     fBodyAccMag-mean()         |   V503                  |  fAccMag.avg         
     fBodyAccMag-std()          |   V504                  |  fAccMag.std         
     fBodyBodyAccJerkMag-mean() |   V516                  |  fAccJerkMag.avg     
     fBodyBodyAccJerkMag-std()  |   V517                  |  fAccJerkMag.std     
     fBodyBodyGyroMag-mean()    |   V529                  |  fGyroMag.avg        
     fBodyBodyGyroMag-std()     |   V530                  |  fGyroMag.std        
     fBodyBodyGyroJerk-mean()   |   V542                  |  fGyroJerk.avg       
     fBodyBodyGyroJerk-std()    |   V543                  |  fGyroJerk.std       
---
    Notes: Extension -XYZ means the name is repeated with extensions -X (or .X), etc for the X, Y, Z directions.


   + Rename `activity` dataframe single column to "Activity"

   + Converts activity data into a factor variable

     The content of the single column in this dataframe is converted
to a factor with levels renamed to match the activity labels in
*data/activity_labels.txt*.

     Activity Value  |  Factor Level 
     ----------------|-----------------
      1              |  Walking
      2              |  Walking_Upstairs
      3              |  Walking_Downstairs
      4              |  Sitting
      5              |  Standing
      6              |  Laying
     
   + Rename `subjects` dataframe column name to "Subject"
     
4. Final Merge Step:

   The `subjects`, `activity`, and `selectedData` dataframes are merged by using `cbind`.
This creates a `tidyData` dataframe with the first column containing the subject
ids, the second column the activity as a factor with 6 levels, and the remaining
columns the data. The `tidyData` dataframe has dimensions 10299x68 with the following
struture:


   #### `tidyData` dataframe structure

    Subject | Activity | tAcc.avg.X | tAcc.avg.Y | tAcc.avg.Z | tAcc.std.X | ...  
    --------|----------|------------|------------|------------|------------|-----
    integer |  level   |  numeric   |  numeric   |  numeric   |  numeric   | ...
     .      |    .     |     .      |    .       |    .       |    .       |  .
     .      |    .     |     .      |    .       |    .       |    .       |  .
     .      |    .     |     .      |    .       |    .       |    .       |  .
    
    
   #### Output (abbreviated) from `str(tidyData)`:

   ```
'data.frame':	10299 obs. of  68 variables:
 $ Subject           : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity          : Factor w/ 6 levels "Laying","Sitting",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ tAcc.avg.X        : num  0.289 0.278 0.28 0.279 0.277 ...
 $ tAcc.avg.Y        : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ tAcc.avg.Z        : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ tAcc.std.X        : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ tAcc.std.Y        : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 $ tAcc.std.Z        : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
 $ tGravityAcc.avg.X : num  0.963 0.967 0.967 0.968 0.968 ...
 $ tGravityAcc.avg.Y : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
 $ tGravityAcc.avg.Z : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
 ...
   ```

5. Output result:

   The `tidyData` dataframe is written to a file, *tidyData.csv*, using `write.table` with
and no row names. By default the column names will be the headers. The data
can be read back using `read.table` built-in function with option
header=T.

# tidySummary.R

  This file loads the tidy data (*tidyData.csv*) generated by the __readMergeClean.R__ script
and creates a new tidy dataframe that contains summary data (mean values) for all the
measures in *tidyData.csv* but grouped based on "Subject" and "Activity".
The __dplyr__ package is used for creating the groups and summary.
The output is a dataframe, `tidySummary`, written to *tidySummary.csv*.

  ```
bySubjectAndActivity <- group_by(inputData,Subject,Activity)
tidySummary <- summarise_each(bySubjectAndActivity,funs(mean))
write.table(tidySummary,file.path(GIT.repo,"tidySummary.csv"),row.names=F)
  ```


#### Output (abbreviated) from `print(tidySummary)`:

 ```
> print(tidySummary)
Source: local data frame [180 x 68]
Groups: Subject

   Subject           Activity tAcc.avg.X   tAcc.avg.Y tAcc.avg.Z  tAcc.std.X
1        1             Laying  0.2215982 -0.040513953 -0.1132036 -0.92805647
2        1            Sitting  0.2612376 -0.001308288 -0.1045442 -0.97722901
3        1           Standing  0.2789176 -0.016137590 -0.1106018 -0.99575990
4        1            Walking  0.2773308 -0.017383819 -0.1111481 -0.28374026
5        1 Walking_Downstairs  0.2891883 -0.009918505 -0.1075662  0.03003534
6        1   Walking_Upstairs  0.2554617 -0.023953149 -0.0973020 -0.35470803
7        2             Laying  0.2813734 -0.018158740 -0.1072456 -0.97405946
8        2            Sitting  0.2770874 -0.015687994 -0.1092183 -0.98682228
9        2           Standing  0.2779115 -0.018420827 -0.1059085 -0.98727189
10       2            Walking  0.2764266 -0.018594920 -0.1055004 -0.42364284
..     ...                ...        ...          ...        ...         ...
Variables not shown: tAcc.std.Y (dbl), tAcc.std.Z (dbl), tGravityAcc.avg.X
  (dbl), tGravityAcc.avg.Y (dbl), tGravityAcc.avg.Z (dbl), tGravityAcc.std.X
  (dbl), tGravityAcc.std.Y (dbl), ...
 ```

