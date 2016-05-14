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
png(file="plot4.png")

par(mfrow = c(2,2))
with(NDt,c(
  plot(DW,Global_active_power ,type = 'l',ylab = "Global Active Power",xlab = ""),
  plot(DW,Voltage ,type = 'l',ylab = "Voltage",xlab = "datetime"),
  plot(DW,Sub_metering_1,type= 'n',xlab= "",ylab ="Energy sub metering"),
  points(DW,Sub_metering_1,type = 'l',ylab = "",xlab = "",col = "black"),
  points(DW,Sub_metering_2,type = 'l',ylab = "",xlab = "",col = "red"),
  points(DW,Sub_metering_3,type = 'l',ylab = "",xlab = "",col = "blue"),
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"),cex = 0.75,bty = 'n'),  
  plot(DW,Global_reactive_power ,type = 'l',ylab = "Global_reactive_power",xlab = "datetime"))
)


dev.off()
