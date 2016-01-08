## Plot 1 Global Active Power

## Extract only days 2/1/2007-2/2/2007 from file
colNames <- names(read.table("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";"))
household <- read.table("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt", 
                        na.strings = "?", sep = ";", header = FALSE, 
                        col.names = colNames, 
                        skip = grep("^[1, 2]/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1] - 1, 
                        nrows = grep("3/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1] - 
                            grep("1/2/2007", readLines("./Coursera/Exploratory Analysis/Course Project 1/household_power_consumption.txt"))[1])

## Make png image
png(filename = "plot1.png", height = 480, width = 480, bg = "white")

## Make histogram
hist(household$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (killowatts)")
    
## Close file device
dev.off()