# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")), ]

# Merge the columns, Date and Time into column, DateTime
power2 <- cbind(DateTime = paste(as.character(power1$Date), power1$Time, sep=" "), Day = weekdays(as.Date(power1$Date),abbreviate=TRUE), power1) 

# Plot plot2 using qplot
library(ggplot2)
qplot(as.numeric(DateTime), Global_active_power, data=power2,xlab=power2$Day, ylab="Global Active Power (kilowatts)", geom="path")

dev.copy(png, file = "plot2.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!