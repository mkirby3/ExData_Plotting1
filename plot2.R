# Coursera Data Science Specialization
# 4 - Exploratory Data Analysis
# Plot2.R

library(plyr); library(dplyr); library(magrittr); 
library(stats); library(plotrix); library(reshape2); library(lubridate); 
library(scales); 

# This script reads in the raw data set, cleans the data as needed,
# reproduces plot 2, and then writes the plot to a .png file named plot2.png.
setwd('~/DataScienceSpecialization-Coursera/4-ExploratoryDataAnalysis/CourseProject1/')
col_classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", 
                 "numeric", "numeric", "numeric")
subsetDat <- read.table('data/household_power_consumption.txt', header=TRUE, 
                        sep=";", na.strings=c("NA", "?"), 
                        colClasses=col_classes, nrows=100000)

# Check for NA values and then remove from df.
colSums(is.na(subsetDat))
subsetDat[is.na(subsetDat$Global_active_power), ]
subsetDat <- subsetDat[!is.na(subsetDat$Global_active_power), ]


# Coerce Date & Time variable to class Date
subsetDat$Date <- as.Date(lubridate::dmy(subsetDat$Date), tz="UTC")
subsetDat$Time <- as.Date(lubridate::hms(subsetDat$Time), subsetDat$Date,
                          tz="UTC")

# Filter rows where date = 2007-02-01 and date = 2007-02-02.
subsetDat2 <- subset(subsetDat, Time >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S", 
                                                 tz="UTC"))
cleanDat <- subset(subsetDat2, Time <= strptime("02/02/2007 23:59:00", "%d/%m/%Y %H:%M:%S", 
                                                tz="UTC"))

# Create a line graph of Global Active Power 

plot(cleanDat$Time, cleanDat$Global_active_power, type='l', xlab="",
     ylab="Global Active Power (kilowatts)")

# Write the histogram to plot1.png. 
setwd('~/DataScienceSpecialization-Coursera/4-ExploratoryDataAnalysis/CourseProject1/')
png(filename='plot2.png', width=480, height=480)
plot(cleanDat$Time, cleanDat$Global_active_power, type='l', xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()