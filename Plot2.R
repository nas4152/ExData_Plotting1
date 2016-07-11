url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
        download.file(url, "plotdata.zip", method = "curl")
        unzip("plotdata.zip")
}

## used to view data before download:
## headtext <- read.csv("household_power_consumption.txt", sep = ";", nrows = 5)
##headtext[ ,1] <- as.Date(headtext[ ,1], format = "%d/%m/%Y")


plotdata <- read.csv.sql("household_power_consumption.txt", sql = 
                                 "select * from file where Date = '1/2/2007' OR 
                                Date = '2/2/2007'", sep = ";")

## checked 02/02/2007, 2/02/2007 formats and returned no results
## check that both dates selected:
##unique(plotdata$Date) 1/2/2007 00:00:00
## returns: "1/2/2007" "2/2/2007"
plotdata[ ,2] <- paste(plotdata[ ,1], plotdata[ ,2])
plotdata[ ,2] <- as.POSIXct(plotdata[ ,2], 
                            format = "%d/%m/%Y %H:%M:%S", tz = "GMT") 

plotdata[ ,1] <- as.POSIXct(plotdata[ ,1], format = "%d/%m/%Y")

## double checking that selected data has no missing values, either as
## found with is.na or as coded with "?"
if(sum(is.na(plotdata)) != 0) {
        print("Warning: NA's present")
}

if(sum(plotdata[2:9] == "?") != 0) {
        print("Warning: NA's present")
}
png(filename = "plot2.png", bg = "transparent")
plot(plotdata$Time, plotdata$Global_active_power, type = "l", xlab = "Time", 
     ylab = "Global Active Power (kilowatts)", bg = "transparent")
dev.off()



