## Plot 3

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
png(filename = "plot3.png", height = 480, width = 480, bg = "white")

## Get the range for the x and y axis
xRange <- range(household$DateTime)
yRange <- range(household$Sub_metering_1)

## Set up line chart
plot(xRange, yRange, type = "n",
     ylab = "Energy Sub Metering",
     xlab = "")

## Add lines
points(household$DateTime, household$Sub_metering_1, type = "l", col = "black")
points(household$DateTime, household$Sub_metering_2, type = "l", col = "red")
points(household$DateTime, household$Sub_metering_3, type = "l", col = "blue")

## Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 2)

## Close file device
dev.off()
