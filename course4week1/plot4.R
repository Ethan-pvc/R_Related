# set working directory and read data
setwd("C:/Users/Sinyi/Desktop/Coursera/Course_4/Week1/Assignment")
datafile <- "./household_power_consumption.txt"
dataset <- read.table(datafile, header=TRUE, sep=";", na.strings="?",
                      stringsAsFactors=FALSE)

# change the format of the date
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

# subset the data for 2007-02-01 and 2007-02-02
subdataset <- subset(dataset,Date == "2007-02-01" | Date =="2007-02-02")

# create date time variable
datetime <- paste(subdataset$Date, subdataset$Time)
datetime <- as.POSIXct(datetime)
subdataset <- cbind(subdataset,datetime)

# plot hisogram for the 2 days
png(file = "plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subdataset, {
    # 1st plot
    plot(Global_active_power ~ datetime, type="l", xlab = "", ylab = "Global Active Power")
    
    # 2nd plot
    plot(Voltage ~ datetime, type="l")
    
    # 3rd plot
    plot(Sub_metering_1 ~ datetime, type="l", xlab = "", ylab = "Energy sub metering")
    lines(Sub_metering_2 ~ datetime, col = 'Red')
    lines(Sub_metering_3 ~ datetime, col = 'Blue')
    legend("topright",col=c("black", "red", "blue"),lty=1, lwd=1,
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # 4th plot
    plot(Global_reactive_power ~ datetime, type="l")
})


dev.off()
