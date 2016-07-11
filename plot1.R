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
png(filename = "plot1.png", bg = "transparent")
hist(plotdata$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red", bg = "transparent")
dev.off()


