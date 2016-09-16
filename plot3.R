## loading libraries
library(lubridate)
library(dplyr)

## Downloading and unzipping dataset
if(!file.exists("./data")){
    dir.create("./data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="./data/Dataset.zip")
    
    # Unzip dataSet to /data directory
    unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

## Reading file
dataset <- read.csv("data/household_power_consumption.txt",sep = ";",na.strings = "?", nrows = 207525)

## Converting to date usning lubridate
dataset$Date <- dmy(dataset$Date)

## subsetting file using dplyr
subDataset <- filter(dataset, "2007-02-01" == Date | Date == "2007-02-02")

## getting data in datetime format using lubridate 
dateTime <- ymd_hms(paste(subDataset$Date,subDataset$Time, " "))

# getting submetering data
subMetering1 <- as.numeric(subDataset$Sub_metering_1)
subMetering2 <- as.numeric(subDataset$Sub_metering_2)
subMetering3 <- as.numeric(subDataset$Sub_metering_3)

# openeing device
png("plot3.png", width=480, height=480)
## generating plot
plot(dateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
## closing device
dev.off()