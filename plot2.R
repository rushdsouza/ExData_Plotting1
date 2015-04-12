# Read the txt file into a data frame using read.table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE )

# Format date 
power$Date <- as.Date(power$Date, format="%d/%m/%Y",tz="")

# Filter for dates Feb 01 and 02, 2007
power1 <- power[((power$Date == "2007-02-01") | (power$Date == "2007-02-02")) |((power$Date == "2007-02-03") & power$Time == "00:00:00"), ]

# Merge the columns, Date and Time into column, DateTime
power2 <- cbind(DateTime = strptime(paste(as.character(power1$Date), power1$Time, sep=" "), "%Y-%m-%d %H:%M:%S"), power1) 

# Plot plot2 using plot
with(power2,{
    plot(as.numeric(power2$DateTime),power2$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l",xaxt="n")
    xday <- as.POSIXct(range(power2$DateTime))
    axis.POSIXct(1,xday, at=seq(xday[1], xday[2], by = "days"), format="%a", labels = TRUE)
})

# Copy my plot to a PNG file, plot2.png in working directory
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off() ## Don't forget to close the PNG device!
