## Plot 2

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
png(filename = "plot2.png", height = 480, width = 480, bg = "white")

## Make line chart
plot(household$DateTime, household$Global_active_power, type = "l",
     ylab = "Global Active Power (killowatts)",
     xlab = "")

## Close file device
dev.off()