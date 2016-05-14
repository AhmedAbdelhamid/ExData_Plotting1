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

#Plot and create PNG file
png(file="plot1.png")
hist(NDt$Global_active_power,xlab = "Global Active Power (kilowatts)",col = "red",main ="")
title(main = "Global Active Power")
dev.off()
