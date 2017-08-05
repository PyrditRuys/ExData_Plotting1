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


# assign the desired info on "Global Active Power" to a new variable, as it is the only data that we need

  GlobalActivePower<- selected_data$Global_active_power

# note that data are in a "character" class, need to change to numeric for plotting 

  GlobalActivePower<- as.numeric(GlobalActivePower)

# open the desired graphic device, setting the size of the image
  png("Plot2.png", width=480, height=480)

#Creates the plot with the required features
  plot(DateAndTime, GlobalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# close de graphic device
  dev.off()

