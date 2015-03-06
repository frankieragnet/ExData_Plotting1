plot4 <- function()
{
  ##RE COMMENT OUT
  #download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./PowerConsumption.zip")
  #unzip("PowerConsumption.zip")
  
  ## Estimated memory requirements can be estimated using pryr
  ##install.packages("pryr")
  ##library(pryr)
  data<-read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=1000)
  ##object_size(data)
  ##returns value of 735 KB
  ## 2 M rows is at most 2000 times more = 1.4 GB. 
  ## => We can read full file without issues.
  energyDF<-read.csv("household_power_consumption.txt", sep=";", na.strings="?")

  ##Subset of relevant dates
  energyDF<-subset(energyDF,(Date=="1/2/2007"|Date=="2/2/2007")) 
  DOW<-strtrim(weekdays(as.Date(strptime(energyDF[,1],"%d/%m/%Y"))),3)
  ##Find index of first occurence of second day (Friday)
  newDayIndex<-match("Fri",DOW)
  ##Find last index
  end<-length(DOW) 
  
  ##Open png device
  png("plot4.png", width=480, height=480)
  ##create a 2x2 matrix
  par(mfrow=c(2,2))

  with(energyDF, {
  
        ##create plot(1,1) = plot2 (slight change in ylab)
        plot(Global_active_power, type="l", xlab="", ylab="Global Active Power",xaxt="n")
        axis(1, at=c(1,newDayIndex,end),labels=c(DOW[1],DOW[newDayIndex],"Sat"))         
        
        ##plot(1,2) = new
        plot(Voltage, type="l", xlab="datetime", ylab="Voltage",xaxt="n")
        axis(1, at=c(1,newDayIndex,end),labels=c(DOW[1],DOW[newDayIndex],"Sat"))         
        
        
        ##plot (2,1)= plot 3 (change: no border to legend)
        plot(Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", xaxt="n")
        ##Add lines for each sub_metering
        lines(Sub_metering_1, type="l", xlab="", ylab="", xaxt="n")
        lines(Sub_metering_2, type="l", xlab="", ylab="", xaxt="n", col="red")
        lines(Sub_metering_3, type="l", xlab="", ylab="", xaxt="n", col="blue")
        ##Create vector of Day of Week. This will be used for index manipulations
        axis(1, at=c(1,newDayIndex,end),labels=c(DOW[1],DOW[newDayIndex],"Sat"))
        legend("topright", lty=1, lwd=1, bty="n", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

        
        ##plot(2,2) = new
        plot(Global_reactive_power, type="l",xlab="datetime", xaxt="n")
        axis(1, at=c(1,newDayIndex,end),labels=c(DOW[1],DOW[newDayIndex],"Sat"))         
        
        
        })
  
  dev.off()
}