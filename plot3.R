library(data.table)

# Download and Unzip the data
if (!file.exists("exdata_data_household_power_consumption.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,"exdata_data_household_power_consumption.zip",method="curl")
  unzip("exdata_data_household_power_consumption.zip") 
}  

#read data
Dt <- fread("household_power_consumption.txt",na.strings = "?")
NDt <- Dt[Dt$Date %in% c("1/2/2007","2/2/2007"),] #select required data
NDt <- na.omit(NDt) #remove Na
rm(Dt) #clear memory
#convert time to POSIXct object
NDt[,DW := (as.POSIXct(paste(NDt$Date,NDt$Time),format= "%d/%m/%Y %H:%M:%S"))]


#Plot and create PNG file
png(file="plot3.png")
with(NDt,plot(DW,Sub_metering_1,type= 'n',xlab= "",ylab = ""))
# draw points and separate meter with color
points(NDt$DW,NDt$Sub_metering_1,type = 'l',ylab = "",xlab = "",col = "black")
points(NDt$DW,NDt$Sub_metering_2,type = 'l',ylab = "",xlab = "",col = "red")
points(NDt$DW,NDt$Sub_metering_3,type = 'l',ylab = "",xlab = "",col = "blue")
#add y label and legend
title( ylab = "Energy sub metering")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col = c("black","red","blue"))
dev.off()
