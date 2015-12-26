# Final Project - Getting and Cleaning Data.
# G. Mercier
# 2015-06-21

# File: downLoadData.R
# Auxilliary script to download the data, uncompress it,
# and put it in directory with name: data
# Assumes that working directory has been set already.
# source("setWDir.R")

print("Started script: downLoadData.R")

# Unzipped directory name:
UNZIPPED <- "UCI HAR Dataset"
# Default raw data directory name:
DATA.dir <- "data"

# Download the data into the GIT.repo directory.
# The data comes in a zip compressed file that when uncompressed generates UNZIPPED
# For simplicity this is renamed to the value of DATA.dir

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempName <- tempfile(tmpdir=getwd())   # get temporary file name
error <- download.file(url,tempName,method="curl")
if (error){
    stop("Error downloading the file!")
}
rawData.downLoadDate <- date()
print(paste("Data downloaded on ",rawData.downLoadDate))

unzip(tempName)
file.rename(UNZIPPED,DATA.dir)
unlink(tempName)                      # delete the temporary file
print(paste("Data downloaded into directory: ",DATA.dir))
print("Script, downLoadData.R, successfully finished!")
