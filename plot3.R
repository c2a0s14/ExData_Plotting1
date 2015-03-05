# plot3.R
# Constructs plot3 and saves it to a PNG file with a width of 480 pixels and a height of 480 pixels.

#---------------------------------------------------
# Verify input file exists.  If not, then get it.  
#---------------------------------------------------
sourcefile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile    <- "household_power_consumption.zip"
txtfile    <- "household_power_consumption.txt"
if(!file.exists(zipfile)) {download.file(sourcefile, zipfile, mode="wb")}
if(!file.exists(txtfile)) {unzip(zipfile)}  #unzip creates .txt file

#---------------------------------------------------
# Read and subset data
#---------------------------------------------------
daterange  <- c("1/2/2007","2/2/2007")  #(date format d/m/yyyy)
pdata   <- read.table(txtfile, header=TRUE, sep=";", na.strings="?")
psub    <- pdata[pdata$Date %in% daterange, ]
psub$datetime <- strptime(paste(psub$Date, psub$Time), "%d/%m/%Y %H:%M:%S")
print(table(as.Date(psub$datetime)))    # Print record counts

#---------------------------------------------------
# Make the chart
#---------------------------------------------------
png("plot3.png", width=480, height=480, units="px")

plot(psub$datetime, psub$Sub_metering_1, 
        xlab=NA, ylab="Energy sub metering", type="n")
lines(psub$datetime, psub$Sub_metering_1, col="black")
lines(psub$datetime, psub$Sub_metering_2, col="red")
lines(psub$datetime, psub$Sub_metering_3, col="blue")
legend("topright", 
       lty=c("solid", "solid", "solid"), 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off(which=dev.cur())    

