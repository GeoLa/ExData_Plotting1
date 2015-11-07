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

# Plot histogram of Global active power
png(filename="plot1.png", width=480, height=480)
hist(hpc07$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()


