# Final Project - Getting and Cleaning Data.
# G. Mercier
# 2015-06-21

# File: setWDir.R
# Sets the working directory for the scripts
#
# Set working directory to local hub repository
HOME.dir <- Sys.getenv("HOME")
GIT.repo <- file.path(HOME.dir,"git","cleanData")
setwd(GIT.repo)
print(paste("Set working directory to ",GIT.repo))

