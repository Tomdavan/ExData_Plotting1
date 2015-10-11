library(data.table)
library(dplyr)

#read data from working directory
elec <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
str(elec)

#format Date column
elec$Date <- as.Date(elec$Date, format = "%d/%m/%Y")

#select the appropriate dates for the project
elecsh <- filter(tbl_df(elec), Date == "2007-02-01" | Date == "2007-02-02")

#check to make sure okay
str(elecsh)
unique(elecsh$Date)

#Concatenate time to date, forming a single variable DateTime and bind it to the data frame
dttm <- paste(elecsh$Date, elecsh$Time)
DateTime <- strptime(dttm, format = "%Y-%m-%d %H:%M:%S")
electric <- cbind(DateTime, elecsh)
str(electric)

#Plot the histogram in a .png file
png("ExData_Plotting1/plot1.png", width = 480, height = 480)
with(electric, hist(electric$Global_active_power, 
    main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
