plot2 <- function()
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

  ##Subset relevant dates
  energyDF<-subset(energyDF,(Date=="1/2/2007"|Date=="2/2/2007")) 
  
  ##Open png device
  png("plot2.png", width=480, height=480)
  ##Create plot without x axis
  plot(energyDF$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)",xaxt="n")
 
  ##Create vector of Day of Week. This will be used for index manipulations
  DOW<-strtrim(weekdays(as.Date(strptime(energyDF[,1],"%d/%m/%Y"))),3)
  ##Find index of first occurence of second day (Friday)
  newDayIndex<-match("Fri",DOW)
  ##Find last index
  end<-length(DOW)
  
  ##Add Custom X axis with Thu, Fri (on corresponding first match in vector) and Sat (at last position)
  axis(1, at=c(1,newDayIndex,end),labels=c(DOW[1],DOW[newDayIndex],"Sat"))
  
  dev.off()
}