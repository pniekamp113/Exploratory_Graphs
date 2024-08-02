#Assignment

#Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
#Different electrical quantities and some sub-metering values are available.

library(dplyr)

#load and pre-process data
setwd("C:/Users/Patrick Niekamp/Desktop/Data Science Series")
list.files()
dev.off()
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
head(data)

## Create column in table with date and time merged together
FullTimeDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, FullTimeDate)
head(data)

#convert data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

#Subset the data set for the dates 2007-02-01 to 2007-02-02
subset_data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]
str(subset_data)
head(subset_data)

#plot 1
Global_Active_Power <- as.numeric(subset_data$Global_active_power)
Global_Active_Power
png("plot1.png", width = 480, height = 480)
hist(Global_Active_Power, col = "red", main = "Global Active Power",, xlab = "Global Ative Power (kilowatts)", ylab = "Frequency")
dev.off()

#plot 2
png("plot2.png", width = 480, height = 480)
with(subset_data, plot(FullTimeDate, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
dev.off()



#plot 3
png("plot3.png", width = 480, height = 480)
with(subset_data, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "black"))
lines(subset_data$FullTimeDate, subset_data$Sub_metering_2, col="red")
lines(subset_data$FullTimeDate, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()


#plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(subset_data, plot(FullTimeDate, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
with(subset_data, plot(FullTimeDate, Voltage, type="l", xlab = "datetime", ylab="Voltage"))
with(subset_data, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "black"))
lines(subset_data$FullTimeDate, subset_data$Sub_metering_2, col="red")
lines(subset_data$FullTimeDate, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
with(subset_data, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Energy sub metering", col = "black"))
