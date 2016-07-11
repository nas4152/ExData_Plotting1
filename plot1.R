url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!dir.exists("plotdata.zip")) {
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