# Clean up workspace
rm(list=ls())

# As my R is in "French", I have to change to produce the same graph as required
Sys.setlocale(category = "LC_ALL", locale = "english")

# This prog assumes that the data are already present in your working dir

household_power_consumption<- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip") # unzip the file

data_full <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";") # read file.


# In order to limit working with huge files, I subset from scratch

selected_data<- subset(data_full, data_full$Date == "1/2/2007" | data_full$Date == "2/2/2007")

# As we will not work anymore with data_full, remove

rm(data_full)

# For this graph we need to merge the Date and Time together. Here I take advantage of the strptime function which converts character (class of this data) in date and time

DateAndTime<- strptime(paste(selected_data$Date, selected_data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
selected_data<- cbind(selected_data, DateAndTime)

# assign the desired  to numeric

selected_data$Sub_metering_1<-as.numeric(selected_data$Sub_metering_1)
selected_data$Sub_metering_2<-as.numeric(selected_data$Sub_metering_2)
selected_data$Sub_metering_3<-as.numeric(selected_data$Sub_metering_3)
selected_data$Global_active_power<- as.numeric(selected_data$Global_active_power)
selected_data$Voltage<- as.numeric(selected_data$Voltage)
selected_data$Global_reactive_power<- as.numeric(selected_data$Global_reactive_power)

# open the desired graphic device, setting the size of the image
png("Plot4.png", width=480, height=480)

# Creates the slot for future figures
par(mfcol = c(2,2))

#Creates the plot with the required features

with(selected_data, plot(DateAndTime, Global_active_power,type="l", xlab="", ylab="Global Active Power"))
with(selected_data, plot(DateAndTime, Sub_metering_1,type="l", xlab="", ylab="Energy sub metering"))
lines(selected_data$DateAndTime, selected_data$Sub_metering_2, type="l", col= "red")
lines(selected_data$DateAndTime, selected_data$Sub_metering_3, type="l",col= "blue")
# Create the legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
with(selected_data, plot(DateAndTime, Voltage, type = "l",lwd=0.5, xlab= "datetime", ylab="Voltage"))
with(selected_data, plot(DateAndTime, Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power"))

# close de graphic device
dev.off()





