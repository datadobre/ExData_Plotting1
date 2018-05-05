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
  
  
  # create the first figure
  png("plot1.png", width = 480, height = 480, units = "px",pointsize = 12, bg = "white")
  with(selectedData,hist(Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
  rug(selectedData$Global_active_power)
  dev.off()
  
}
  