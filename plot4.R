# FIle created for the Exploratory data analysis - Week 1 - Project

# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
# In particular, we will be using the “Individual household electric power consumption Data Set” representing the measurements
# of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.

# The dataset has 2,075,259 rows and 9 columns
# The variables in the dataset are the following:
# * Date: Date in format dd/mm/yyyy
# * Time: time in format hh:mm:ss
# * Global_active_power: household global minute-averaged active power (in kilowatt)
# * Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# * Voltage: minute-averaged voltage (in volt)
# * Global_intensity: household global minute-averaged current intensity (in ampere)
# * Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy).
#   It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# * Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy).
#   It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# * Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Step 1: check necessary memory

lines <- 2075260;
head.size <- object.size(read.table("household_power_consumption.txt", nrow=1000))
size.estimate <- as.numeric(head.size*lines / 1000 /1048576)
if (memory.size() < size.estimate) {
  print("Not enough memory")
} else {
  # read the data from the file "household_power_consumption.txt";
  # knowing that the separator character is ";" and the na.strings are represented by "?" and the file contains the name of the variables
  filename <- "household_power_consumption.txt"
  data <- read.table(filename,sep = ";",header = TRUE,na.strings = "?")
  
  
  
  # select only the data from the dates 2007-02-01 and 2007-02-02
  data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
  date1 <- as.Date("2007/02/01")
  date2 <- as.Date("2007/02/02")
  dates <- seq(date1, date2, by="days")
  selectedData <- subset(data, Date %in% dates)
  head(selectedData)
  
  rm(data)
  
  options(scipen = 999)
  Sys.setlocale("LC_ALL","English")
  
  # Create the 4th figure:
  png("plot4.png", width = 480, height = 480, units = "px",pointsize = 12, bg = "white")
  par(mfcol = c(2,2))
  
  temp <- paste(selectedData$Date,selectedData$Time, sep = " ")
  dates_time <- strptime(temp, format = "%Y-%m-%d %H:%M:%S")
  
  # 1st plot
  with(selectedData,plot(dates_time,Global_active_power,xaxt="n",type = "l",lwd=2,ylab="Global Active Power",xlab = "Day")) # do not plot the x axis
  axis.POSIXct(1, at=seq(date1, date2+1, by="day"), format="%a") #label the x axis by day
  
  # 2nd plot
  with(selectedData,plot(dates_time,Sub_metering_1,xaxt="n",type = "l",lwd=2,ylab="Energy sub metering",xlab = "Day")) # do not plot the x axis
  points(dates_time,selectedData$Sub_metering_2,xaxt="n",type = "l",lwd = 2,col="red")
  points(dates_time,selectedData$Sub_metering_3,xaxt="n",type = "l",lwd = 2,col="blue")
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  axis.POSIXct(1, at=seq(date1, date2+1, by="day"), format="%a") #label the x axis by day
  
  #3d plot
  with(selectedData,plot(dates_time,Voltage,xaxt="n",type = "l",lwd=2,ylab="Voltage",xlab = "Day")) # do not plot the x axis
  axis.POSIXct(1, at=seq(date1, date2+1, by="day"), format="%a") #label the x axis by day
  
  #4th plot
  with(selectedData,plot(dates_time,Global_reactive_power,xaxt="n",type = "l",lwd=2,ylab="Global Reactive Power",xlab = "Day")) # do not plot the x axis
  axis.POSIXct(1, at=seq(date1, date2+1, by="day"), format="%a") #label the x axis by day
  
  dev.off()
  
}
