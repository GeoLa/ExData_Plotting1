# Set working directory

setwd("./exdata-data-household_power_consumption")

# See all files available in the directory
list.files()

# Read dataset
hpc <- read.table("household_power_consumption.txt", header=T, sep=";", 
                  stringsAsFactors=F, na.strings="?")
str(hpc)

# Format dates and times
hpc$Datetime <- strptime(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

# Keep only data between 2007-02-01 and 2007-02-02.

place <- hpc$Date == '2007-02-01'|hpc$Date == '2007-02-02'
hpc07 <- subset(hpc, place)
remove(hpc, place)

# Plot sub_metering 4 plots on a page


png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2))
    

# First plot (left, top)
plot(hpc07$Datetime,hpc07$Global_active_power, type="n", 
     xlab="", ylab="Global Active Power (kilowatts)")
lines(hpc07$Datetime,hpc07$Global_active_power)

# Second plot (right,top)
plot(hpc07$Datetime,hpc07$Voltage, type="n", 
     xlab="datetime", ylab="Voltage")
lines(hpc07$Datetime,hpc07$Voltage)

# Third plot (left, bottom)

plot(hpc07$Datetime,hpc07$Sub_metering_1,type="n",
     ylab="Energy sub metering", xlab="")
lines(hpc07$Datetime,hpc07$Sub_metering_1,col="black")
lines(hpc07$Datetime,hpc07$Sub_metering_2,col="red")
lines(hpc07$Datetime,hpc07$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1), col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", cex=0.7)

# Fourth plot (bottom, right)

plot(hpc07$Datetime,hpc07$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(hpc07$Datetime,hpc07$Global_reactive_power)

dev.off()
