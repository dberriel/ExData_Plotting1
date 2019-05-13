#Date: 13-May-2019
#Author: Diego Berriel
#Project: Exploratory Data Analysis - Project 1 - Plot 1

install.packages("sqldf")
#Loading package needed
library(sqldf)

#Praparing and dowloading data and data sets creation

zipfile <- "./data/household_power_consumption.zip"
##File exists?
if (!file.exists("data")){
    dir.create("data")
}  
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, zipfile, method="curl")

##Unzip files into specific folder
if (!file.exists("./data/household_power_consumption")) { 
    unzip(zipfile,exdir = "./data") 
}

###Read Data
powerdata <- read.csv.sql("./data/household_power_consumption.txt", sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

#Plot1
##png
png("plot1.png", width=480, height=480)
##calling the basic plot function
hist(as.numeric(powerdata$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
title(main="Global Active Power")
dev.off()
