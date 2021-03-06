# Code Book for *cleanData*
**Author: Gustavo Mercier**

**Created: June 10, 2015**

**Last Modified: June 19, 2015 08:27 am**

# Data Info:

* Data:
    + Human Activity Recognition Using Smartphones Data Set
* Data reference:
    + Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
      A Public Domain Dataset for Human Activity Recognition Using Smartphones.
      21th European Symposium on Artificial Neural Networks,
      Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
* Data source: 
    + UCI Machine Learning Repository
    + Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1),
      Luca Oneto(1) and Xavier Parra(2)
      1 - Smartlab - Non-Linear Complex Systems Laboratory
          DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
      2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
          Universitat Politècnica de Catalunya (BarcelonaTech).
          Vilanova i la Geltrú (08800), Spain
          activityrecognition '@' smartlab.ws
    + https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Data summary:
    + Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with
embedded inertial sensors.
* Download date and time:
    + June 8, 2015 9:28pm EDT
* Data source file format:
    +  zip
* Data source file download and expansion:
    + downLoadData.R performs download and file expansion with R built-in functions 
    + Expanded into folder: UCI HAR Dataset
* Data folder:
    + The folder UCI HAR Dataset was renamed *data*
* Data folder location:
    + Placed in local git repository: cleanData
    + URL for github repository: https://github.com/gamercier/cleanData
* Data folder directory structure:
    + data:
        + README.txt
        + activity_labels.txt
        + features.txt
        + features_info.txt
        + test:
            + X_test.txt
            + subject_test.txt
            + y_test.txt
            + Inertial Signals:
                + body_acc_x_test.txt
                + body_acc_y_test.txt
                + body_acc_z_test.txt
                + total_acc_x_test.txt
                + total_acc_y_test.txt
                + total_acc_z_test.txt
                + body_gyro_x_test.txt
                + body_gyro_y_test.txt
                + body_gyro_z_test.txt
        + train:
            + X_train.txt
            + subject_train.txt
            + y_train.txt
            + Inertial Signals:
                + body_acc_x_train.txt
                + body_acc_y_train.txt
                + body_acc_z_train.txt
                + total_acc_x_train.txt
                + total_acc_y_train.txt
                + total_acc_z_train.txt
                + body_gyro_x_train.txt
                + body_gyro_y_train.txt
                + body_gyro_z_train.txt
* Tidy Data
    + tidyData.csv
    + tidySummary.csv


# Summary of experiment and generation of data


Thirty volunteers between ages of 19-48 engaged in 6 activities while wearing
a smartphone (Samsung Galaxy II) in their waist. The six activities included:
walking, walking upstairs, walking downstairs, sitting, standing, and laying down.
Twenty-one (70%) of the subjects were randomly assigned to
a training set (*data/train*) and the remaining 9 (30%) were assigned to a test set (*data/test*).


Using the accelerometer and gyroscope in the smartphone the 3 linear accelerations
and the 3 angular velocities were captured at a rate of 50 Hz (i.e. 50 readings
per second) for each subject during each activity. This raw data was
smoothed using noise filters. For the acceleration data additional filters were
applied to extract the body acceleration, i.e. the measured (total)
acceleration without the contribution from gravity.
These raw data is stored in the directory, *Inertial Signals*, located under
the *test* and *train* directories. These inertial signals were excluded 
in the creation of the tidy data for this project, but are the basis for the
source data for this project.


The source data used to create our tidy data are the 561 features computed from the
inertial signals, and stored in the *X_train.txt* and *X_test.txt* files under the *train*
and *test* directories, respectively. Each line in the source data files is matched
by a line in the *subject_train(or test).txt* file that contains the subject
ids (integers: 1-30). At the same time the *y_train(or test).txt* file contains
a matching line with an integer entry (1-6) to describe the activity done
by the subject. The file *activity_labels.txt* describes which activity matches
a given integer in the *y_train(or test).txt* file. For example the number 3
refers to walking. The file *feature_info.txt* describes the features computed
from the raw data, and the file *features.txt* lists labels for the features listed
in the source files in the order that they appear in each line. All the source
data files are in text format with numbers in the format listed below, and separated
by blank spaces.


Source File         | Data         | Dimension     | Data Format       | Sep
--------------------|--------------|---------------|-------------------|-----------      
X_train.txt         | Features     |    7352x561   | Scientific Not.   | blank space
X_test.txt          | Features     |    2947x561   | Scientific Not.   | blank space
y_train.txt         | Activity Ids |    7352x1     | Integer (1-6)     | none
y_test.txt          | Activity Ids |    2947x1     | Integer (1-6)     | none
subject_train.txt   | Subject Ids  |    7352x1     | Integer (1-30)    | none
subject_test.txt    | Subject Ids  |    2947x1     | Integer (1-30)    | none



# Variables and Units


The tidy data only includes a subset of the features in the source data -- 66 of the
561 features. The table below lists the 66 variables using names in the *features.txt*
file, and the column number for the variable in the source files, *X_train.txt*
and *X_test.txt*. For simplicity the labels listed in *features.txt* have been
renamed for use as labels in the columns (3-68) of the `tidyData` dataframe saved in
*tidyData.csv*, and also used in the `tidySummary` dataframe saved under
*tidySummary.csv* and that was submitted to the assignment area in Coursera.
The 1st and 2nd columns of the `tidyData` and `tidySummary` dataframes contain the
subject and activity ids and are labeled, Subject and Activity, respectively. The
subject ids remain unchanged as integers from 1-30, but the activity labels were
converted to a factor with labels.

The `tidyData` dataframe has dimensions 10299x68 while the `tidySummary` data
frame has dimensions 180x68 since it is produced by generating the means for the
66 variables but grouped by Subject (30) and Activity (6).


## Variable names and locations:


Feature Variable Names      |Old Columns   |New Name            |New Columns
----------------------------|--------------|--------------------|-----------
tBodyAcc-mean()-XYZ         |  1:3         |tAcc.avg.XYZ        |  3:5                              
tBodyAcc-std()-XYZ          |  4:6         |tAcc.std.XYZ        |  6:8                              
tGravityAcc-mean()-XYZ      |  41:43       |tGravityAcc.avg.XYZ |  9:11                                 
tGravityAcc-std()-XYZ       |  44:46       |tGravityAcc.std.XYZ | 12:14                                  
tBodyAccJerk-mean()-XYZ     |  81:83       |tAccJerk.avg.XYZ    | 15:17                              
tBodyAccJerk-std()-XYZ      |  84:86       |tAccJerk.std.XYZ    | 18:20                              
tBodyGyro-mean()-XYZ        |  121:123     |tGyro.avg.XYZ       | 21:23                              
tBodyGyro-std()-XYZ         |  124:126     |tGyro.std.XYZ       | 24:26                              
tBodyGyroJerk-mean()-XYZ    |  161:163     |tGyroJerk.avg.XYZ   | 27:29                              
tBodyGyroJerk-std()-XYZ     |  164:166     |tGyroJerk.std.XYZ   | 30:32                              
tBodyAccMag-mean()          |  201         |tAcc.avg            |  33                           
tBodyAccMag-std()           |  202         |tAcc.std            |  34                           
tGravityAccMag-mean()       |  214         |tGravityAcc.avg     |  35                               
tGravityAccMag-std()        |  215         |tGravityAcc.std     |  36                               
tBodyAccJerkMag-mean()      |  227         |tAccJerk.avg        |  37                           
tBodyAccJerkMag-std()       |  228         |tAccJerk.std        |  38                           
tBodyGyroMag-mean()         |  240         |tGyro.avg           |  39                           
tBodyGyroMag-std()          |  241         |tGyro.std           |  40                           
tBodyGyroJerkMag-mean()     |  253         |tGyroJerk.avg       |  41                           
tBodyGyroJerkMag-std()      |  254         |tGyroJerk.std       |  42                           
fBodyAcc-mean()-XYZ         |  266:268     |fAcc.avg.XYZ        | 43:45                              
fBodyAcc-std()-XYZ          |  269:271     |fAcc.std.XYZ        | 46:48                              
fBodyAccJerk-mean()-XYZ     |  345:347     |fAccJerk.avg.XYZ    | 49:51                              
fBodyAccJerk-std()-XYZ      |  348:350     |fAccJerk.std.XYZ    | 52:54
fBodyGyro-mean()-XYZ        |  424:426     |fGyro.avg.XYZ       | 55:57                              
fBodyGyro-std()-XYZ         |  427:429     |fGyro.std.XYZ       | 58:60                              
fBodyAccMag-mean()          |  503         |fAcc.avg            |  61                     
fBodyAccMag-std()           |  504         |fAcc.std            |  62                     
fBodyBodyAccJerkMag-mean()  |  516         |fAccJerk.avg        |  63                 
fBodyBodyAccJerkMag-std()   |  517         |fAccJerk.std        |  64                 
fBodyBodyGyroMag-mean()     |  529         |fGyro.avg           |  65                 
fBodyBodyGyroMag-std()      |  530         |fGyro.std           |  66                 
fBodyBodyGyroJerk-mean()    |  542         |fGyroJerk.avg       |  67                    
fBodyBodyGyroJerk-std()     |  543         |fGyroJerk.std       |  68                    
---
* Notes:
    + Extension -XYZ means the name is repeated with extensions -X (or .X), etc
      for the X, Y, Z directions.
    + When the extension is missing the data refers to the Euclidean Norm.
    + "t" refers to time domain data and "f" to frequency domain.
    + "avg" and "std" refer to average and standard deviation values. These are computed from the 128 readings for each activity and subject combination.
    + In the time domain:
        + Acc = acceleration in units of "g".
            + 1g = Earth's gravitational acceleration = 9.8 m/s<sup>2</sup>.
        + AccJerk= first derivative of the acceleration in units of g/s.
        + Gyro = angular velocity in units of radians/s.
        + GyroJerk = first derivative of the angular velociy in units of radians/s<sup>2</sup>.
    + In frequency domain fourier transformed time domain data units:
        + Acc = g-s
        + AccJerk = g
        + Gyro = radians
        + GyroJerk = radians/s


# Steps in generating clean data


1. A **GitHub** [repo](github.com/gamercier/cleanData) was created in
https://github.com/gamercier/cleanData and copied to the local git repository. 
Top directory: cleanData. This is the working directory containing data, scripts,
codebook, and readme files.

2. The script *run_analysis.R* downloads the data, and generates the *tidyData.csv*
and *tidySummary.csv* files by calling auxilliary R scripts in the following order:

    + *downLoadData.R*
        + downloads the data from the source [url](d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
uncompresses it into a directory, and renames the uncompressed directory to *data*.

    + *readMergeClean.R*
        + loads the data (X_train.txt, X_test.txt, subject_train.txt, subject_test.txt,
y_train.txt, and y_test.txt) into memory and merges the *train* and *test* data
sets by stacking the *X_train.txt* data on top of the *X_test.txt* data. It then selects the specific
variables and renames the variable names to match the table above. Subject ids and activity codes are 
clipped to the left of the merged data to create a 10299x68 dataframe, `tidyData`. 
In the process the activity codes are converted from integer data to factors to match the 
description in *activity_labels.txt*. However, the factor levels are all lower case, except for 
the first letter (i.e WALKING becoms Walking). This dataframe is written to the file *tidyData.csv*. 
The details of its structure can be found in the [README.md](README.md) file in the repo.
      
    + *tidySummary.R*
        + This scripts loads the data from the file *tidyData.csv* and generates
simple summary statistics (mean values) after grouping by subject id and activity. 
The result is a dataframe that is written to the file *tidySummary.csv*. The 
dimensions of this dataframe is 180x68 and details of its structure can be 
found in the [README.md](README.md) file in the repo.

Details of the operations of these scripts are found in [README.md](README.md). Also see
comments within the scripts. Note that the file *tidyData.csv* is an intermediate
file to generate the final tidy summary data file, *tidySummary.csv* that was
submitted to the Coursera assignment.

