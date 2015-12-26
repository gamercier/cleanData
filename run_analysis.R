# Main R script
#   Sets working directory to cleanData repo
#   Downloads data from source url
#   reads the data, generates the tidy data set, and writes it out to tidyData.csv
#   reads the tidy data set and computes a tidy summary (mean data) that is written to tidySummary.csv
source("setWDir.R")
source("downLoadData.R")
source("readMergeClean.R")
source("tidySummary.R")
print("Success!")
