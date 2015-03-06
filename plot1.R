plot1 <- function()
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./PowerConsumption.zip")
  unzip("PowerConsumption.zip")
  
  
  ## Estimated memory requirements can be estimated using pryr
  ##install.packages("pryr")
  ##library(pryr)
  ##data<-read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=1000)
  ##object_size(data)
  ##returns value of 735 KB
  ## 2 M rows is at most 2000 times more = 1.4 GB. 
  ## => We can read full file without issues.
    
  energyDF<-read.csv("household_power_consumption.txt", sep=";", na.strings="?")

  ##Subset of relevant dates
  energyDF<-subset(energyDF,(Date=="1/2/2007"|Date=="2/2/2007"))
  
  ##Convert to real dates
  energyDF$Date2<-as.Date(strptime(energyDF[,1],"%d/%m/%Y"))
  
  png("plot1.png", width=480, height=480)
  hist(energyDF$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
  
  dev.off()
  
}