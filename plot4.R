# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")) |((power$Date == "2007-02-03") & power$Time == "00:00:00"), ]

# Merge the columns, Date and Time into column, DateTime
power2 <- cbind(DateTime = strptime(paste(as.character(power1$Date), power1$Time, sep=" "), "%Y-%m-%d %H:%M:%S"), power1) 

par(mfrow = c(2, 2))
with(power2, 
{
    plot(as.numeric(DateTime), Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l",xaxt="n")
    xday <- as.POSIXct(range(power2$DateTime))
    axis.POSIXct(1,xday, at=seq(xday[1], xday[2], by = "days"), format="%a", labels = TRUE)
    
    plot(as.numeric(DateTime), Voltage, xlab="datetime", ylab="Voltage", type="l", xaxt="n")
    xday <- as.POSIXct(range(power2$DateTime))
    axis.POSIXct(1,xday, at=seq(xday[1], xday[2], by = "days"), format="%a", labels = TRUE)
    
    plot(as.numeric(DateTime),Sub_metering_1, xlab="", ylab="Energy sub metering", type="l",xaxt="n")
    xday <- as.POSIXct(range(power2$DateTime))
    axis.POSIXct(1,xday, at=seq(xday[1], xday[2], by = "days"), format="%a", labels = TRUE)
    with(subset(power2),lines(as.numeric(DateTime), Sub_metering_2, type="l", col="red"))
    with(subset(power2),lines(as.numeric(DateTime), Sub_metering_3, type="l", col="blue"))
    legend("topright", lty=1,  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

    plot(as.numeric(DateTime), Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l",xaxt="n")
    xday <- as.POSIXct(range(power2$DateTime))
    axis.POSIXct(1,xday, at=seq(xday[1], xday[2], by = "days"), format="%a", labels = TRUE)    
})

# Copy my plot to a PNG file, plot3.png in working directory
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()