#Date: 13-May-2019
#Author: Diego Berriel
#Project: Exploratory Data Analysis - Project 1 - Plot 4

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
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
powerdata$Voltage <- as.numeric(powerdata$Voltage)

###Date time creation for plotting
datetime <- strptime(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")
powerdata$dateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), format = "%Y-%m-%d %H:%M:%S",tz="")

##Device: png
png("plot4.png", width=480, height=480)

# Set mulplite plot sections
par(mfrow=c(2,2))

plot(x = powerdata$dateTime
     , y = powerdata$Global_active_power
     , type="l", xlab="", ylab="Global Active Power")

plot(x = powerdata$dateTime
     , y = powerdata$Voltage
     , type="l", xlab="datetime", ylab="Voltage")

plot(x = powerdata$dateTime
     , y = powerdata$Sub_metering_1
     , type="l", xlab="", ylab="Energy Submetering")
with(powerdata,lines(x = powerdata$dateTime, y = powerdata$Sub_metering_2, type="l",col="red"))
with(powerdata,lines(x = powerdata$dateTime, y = powerdata$Sub_metering_3, type="l",col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lty=1, lwd=2.5)

plot(x = powerdata$dateTime
     , y = powerdata$Global_active_power
     , type="l", xlab="", ylab="Global_reactive_power")

dev.off()
