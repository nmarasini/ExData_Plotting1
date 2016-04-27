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


#Convert the datetime as POSIXct
dt <- paste(as.Date(filterData$Date), filterData$Time)
filterData$Datetime <- as.POSIXct(dt)


#Plot 2 Starts from here
plot(globalActivePower~Datetime, 
     data = filterData, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")


# Save histogram into working directory
dev.copy(png, 
          file = "plot2.png", 
          height=480, 
          width=480)

# Close the current device
dev.off()
