## Plot 4

## Extract only days 2/1/2007-2/2/2007 from file
colNames <- names(read.table("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";"))
household <- read.table("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt", 
                        na.strings = "?", sep = ";", header = FALSE, 
                        col.names = colNames, 
                        skip = grep("^[1, 2]/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1] - 1, 
                        nrows = grep("3/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1] - 
                            grep("1/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1],
                        stringsAsFactors = FALSE)

## Convert columns to date/time
household$Date <- as.Date(household$Date, "%d/%m/%Y")
household$DateTime <- paste(household$Date, household$Time, sep = " ")
household$DateTime <- strptime(household$DateTime, format = "%Y-%m-%d %H:%M:%S")

## Make png image
png(filename = "plot4.png", height = 480, width = 480, bg = "white")

## Make plots
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
# Plot 1 (top-left)
plot(household$DateTime, household$Global_active_power, type = "l",
     ylab = "Global Active Power",
     xlab = "")
# Plot 2 (top-right)
plot(household$DateTime, household$Voltage, type = "l",
     xlab = "DateTime",
     ylab = "Voltage")
# Plot 3 (bottom-left)
plot(xRange, yRange, type = "n",
     ylab = "Energy Sub Metering",
     xlab = "")
points(household$DateTime, household$Sub_metering_1, type = "l", col = "black")
points(household$DateTime, household$Sub_metering_2, type = "l", col = "red")
points(household$DateTime, household$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 2)
# Plot 4 (bottom-right)
plot(household$DateTime, household$Global_reactive_power, type = "l",
     xlab = "DateTime",
     ylab = "Global_reactive_power")

# Close file device
dev.off()