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

globalActivePower <-  as.numeric(subDataset$Global_active_power)

## opening device
png("plot2.png", width=480, height=480)

## generating plot
plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## closing device
dev.off()