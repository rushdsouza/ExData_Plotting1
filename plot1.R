# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")), ]

# Combine Date and Time columns 
power2 <- cbind(DateTime = paste(as.character(power1$Date), power1$Time, sep=" "),power1) 

hist(power1$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
