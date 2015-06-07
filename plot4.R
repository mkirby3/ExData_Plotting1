# Coursera Data Science Specialization
# 4 - Exploratory Data Analysis
# Plot4.R

library(plyr); library(dplyr); library(magrittr); 
library(stats); library(plotrix); library(reshape2); library(lubridate); 
library(scales); 

# This script reads in the raw data set, cleans the data as needed,
# reproduces plot 4, and then writes the plot to a .png file named plot4.png.
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

# Create a histogram of Global Active Power 

with(cleanDat, plot(Time, Sub_metering_1,
                    type = "n", xlab="",
                    ylab="Energy sub metering"))
with(cleanDat, lines(Time, Sub_metering_1, col = "black"))
with(cleanDat, lines(Time, Sub_metering_2, col = "red"))
with(cleanDat, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty=1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.65)

# Write the histogram to plot1.png. 
setwd('~/DataScienceSpecialization-Coursera/4-ExploratoryDataAnalysis/CourseProject1/')
png(filename='plot4.png', width=480, height=480)
with(cleanDat, plot(Time, Sub_metering_1,
                    type = "n", xlab="",
                    ylab="Energy sub metering"))
with(cleanDat, lines(Time, Sub_metering_1, col = "black"))
with(cleanDat, lines(Time, Sub_metering_2, col = "red"))
with(cleanDat, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty=1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.65)
dev.off()