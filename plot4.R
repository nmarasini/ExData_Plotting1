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
voltage <- as.numeric(filterData$Voltage)
globalReactivePower <- as.numeric(filterData$Global_reactive_power)
subMeter1 <- as.numeric(filterData$Sub_metering_1)
subMeter2 <- as.numeric(filterData$Sub_metering_2)
subMeter3 <- as.numeric(filterData$Sub_metering_3)


#Convert datetime as POSIXct
dt <- paste(as.Date(filterData$Date), filterData$Time)
filterData$Datetime <- as.POSIXct(dt)


## Plot 4 starts from here
par(mfrow = c(2, 2), 
    mar=c(4,4,2,1), 
    oma=c(0,0,2,0))

##  graph 1
plot(globalActivePower~Datetime, 
      data = filterData, 
      type="l", 
      ylab="Global Active Power", 
      xlab="")

## graph 2
plot(voltage~Datetime, 
      data = filterData, 
      type="l", 
      ylab="Voltage", 
      xlab="datetime")

## graph 3
plot(
      subMeter1~Datetime, 
      data = filterData, 
      type="l", 
      ylab="Energy sub metering", 
      xlab="")

lines(subMeter2~Datetime, 
      data = filterData, 
      type="l", 
      col = "red")

lines(subMeter3~Datetime, 
      data = filterData,
      type="l", 
      col = "blue")

legend("topright", 
       col = c("black","red","blue"), 
       lty = 1, 
       lwd = 2, 
       bty="n", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

## graph 4
plot(globalReactivePower~Datetime, 
      data = filterData, 
      type="l", 
      ylab="Global_reactive_power", 
      xlab="datetime")

# Save combined graph into working directory
dev.copy(png, 
         file="plot4.png", 
         height=480, 
         width=480)

# Close the current device
dev.off()