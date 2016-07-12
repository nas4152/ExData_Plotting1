url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
        download.file(url, "plotdata.zip", method = "curl")
        unzip("plotdata.zip")
}

## used to view data before download:
## headtext <- read.csv("household_power_consumption.txt", sep = ";", nrows = 5)
##headtext[ ,1] <- as.Date(headtext[ ,1], format = "%d/%m/%Y")


plotdata <- read.csv.sql("household_power_consumption.txt", sql = 
                                 "select * from file where Date = '1/2/2007' OR Date = '2/2/2007' ", 
                         sep = ";")

## checked 02/02/2007, 2/02/2007 formats and returned no results
## check that both dates selected:
##unique(plotdata$Date)
## returns: "1/2/2007" "2/2/2007"
plotdata[ ,1] <- as.Date(plotdata[ ,1], format = "%d/%m/%Y")

## double checking that selected data has no missing values, either as
## found with is.na or as coded with "?"
if(sum(is.na(plotdata)) != 0) {
        print("Warning: NA's present")
}

if(sum(plotdata[2:9] == "?") != 0) {
        print("Warning: NA's present")
}


png(filename = "plot4.png", bg = "transparent")
par(mfcol = c(2,2))

plot(plotdata$Time, plotdata$Global_active_power, type = "l", xlab = "Time", 
     ylab = "Global Active Power (kilowatts)", bg = "transparent")

plot(plotdata$Time, plotdata$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering", bg = "transparent")
points(plotdata$Time, plotdata$Sub_metering_1, type = "l")
points(plotdata$Time, plotdata$Sub_metering_2 , type = "l", col = "red")
points(plotdata$Time, plotdata$Sub_metering_3 , type = "l", col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("black", "red", "blue"), 
       text.width = strwidth("Sub_metering_3"), cex = 0.75)

dev.off()
