# plot4.R
# Constructs plot4 (4 plots on one graphics device), and creates and 
# saves it to a PNG file with a width of 480 pixels and a height of 480 pixels.

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
# Launch Graphics Device
png("plot4.png", width=480, height=480, units="px") 

# Set up area for 4 plots (2 columns x 2 rows)
par(mfcol=c(2,2))  

# 1. Upper Left
with(psub, plot(datetime, Global_active_power, 
                xlab=NA, ylab="Global Active Power", type="l"))

# 2. Lower Left
plot(psub$datetime, psub$Sub_metering_1, 
        xlab=NA, ylab="Energy sub metering", type="n")
lines(psub$datetime, psub$Sub_metering_1, col="black")
lines(psub$datetime, psub$Sub_metering_2, col="red")
lines(psub$datetime, psub$Sub_metering_3, col="blue")
legend("topright", bty="n",
       lty=c("solid", "solid", "solid"), 
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 3. Upper Right (axis labels are the variable names)
with(psub, plot(datetime, Voltage, type="l"))    

# 4. Lower Right (axis labels are the variable names)
with(psub, plot(datetime, Global_reactive_power, type="l"))

# Close Graphics Device
dev.off(which=dev.cur())    


