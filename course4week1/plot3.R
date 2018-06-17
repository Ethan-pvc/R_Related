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
png(file = "plot3.png", width=480, height=480)
with(subdataset, {
    plot(datetime,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(Sub_metering_2 ~ datetime, col="red")
    lines(Sub_metering_3 ~ datetime, col="blue")
})
legend("topright",col=c("black", "red", "blue"),lty=1, lwd=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
