# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")), ]

hist(power1$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

# Copy my plot to a PNG file, plot1.png in working directory
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
