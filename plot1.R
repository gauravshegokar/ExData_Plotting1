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
dataset <- read.csv("data/household_power_consumption.txt",sep = ";",na.strings = "?")

## Converting to date usning lubridate
dataset$Date <- dmy(dataset$Date)

## subsetting file using dplyr
subDataset <- filter(dataset, "2007-02-01" == Date | Date == "2007-02-02")

## opening device
png("plot1.png", width=480, height=480)
globalActivePower <-  as.numeric(subDataset$Global_active_power)

## generating histogram
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## closing device
dev.off()