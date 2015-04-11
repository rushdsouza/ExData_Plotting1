# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")), ]

# Merge the columns, Date and Time into column, DateTime
power2 <- cbind(DateTime = paste(as.character(power1$Date), power1$Time, sep=" "), Day = weekdays(as.Date(power1$Date),abbreviate=TRUE), power1) 

# Plot plot3 using plot and lines
with(power2, plot(as.numeric(DateTime), Sub_metering_1, xlab=unique(power2$Day), ylab="Energy sub metering", type="l", xaxt="n", xaxs="r"))
with(subset(power2),lines(as.numeric(DateTime), Sub_metering_2, type="l", col="red"))
with(subset(power2),lines(as.numeric(DateTime), Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1,  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy my plot to a PNG file, plot3.png in working directory
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()