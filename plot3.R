# Loading data from source file
# After setting working directory

loadData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                       , check.names=F, stringsAsFactors=F)

#Convert into date format
loadData$Date <- as.Date(loadData$Date, format="%d/%m/%Y")

#Filter the required data as described in assignment of dates between 2007-02-01 and 2007-02-02
filterData <- subset(loadData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))



#Cast Global_active_power as number
globalActivePower <- as.numeric(filterData$Global_active_power)
subMeter1 <- as.numeric(filterData$Sub_metering_1)
subMeter2 <- as.numeric(filterData$Sub_metering_2)
subMeter3 <- as.numeric(filterData$Sub_metering_3)

#Convert datetime as POSIXct
dt <- paste(as.Date(filterData$Date), filterData$Time)
filterData$Datetime <- as.POSIXct(dt)


## Plot 3 starts
plot(subMeter1~Datetime, 
      data = filterData,
      type="l", 
      ylab="Energy sub metering", 
      xlab="")

lines(subMeter2~Datetime, 
      data = filterData, 
      type="l", 
      col = "gray")

lines(subMeter3~Datetime, 
      data = filterData, 
      type="l", 
      col = "red")

legend("topright",
       col = c("black","red","blue"), 
       lty = 1, 
       lwd = 2, 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )


# Save histogram into working directory
dev.copy(png, 
          file = "plot3.png", 
          height=480, 
          width=480)

# Close the current device
dev.off()
