#Date: 13-May-2019
#Author: Diego Berriel
#Project: Exploratory Data Analysis - Project 1 - Plot 2

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

##Data formatting
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

###Date time creation for plotting
datetime <- strptime(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")
powerdata$dateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), format = "%Y-%m-%d %H:%M:%S",tz="")

##Device: png
png("plot2.png", width=480, height=480)
##calling the basic plot function
plot(x = powerdata$dateTime
     , y = powerdata$Global_active_power
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()