# set working directory and read data
setwd("C:/Users/Sinyi/Desktop/Coursera/Course_4/Week1/Assignment")
datafile <- "./household_power_consumption.txt"
dataset <- read.table(datafile, header=TRUE, sep=";", na.strings="?",
                      stringsAsFactors=FALSE)

# change the format of the date
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

# subset the data for 2007-02-01 and 2007-02-02
subdataset <- subset(dataset,Date == "2007-02-01" | Date =="2007-02-02")

# plot hisogram for the 2 days
png(file = "plot1.png", width=480, height=480)
hist(subdataset$Global_active_power, col="red", border="black", 
     main ="Global Active Power", xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
dev.off()

