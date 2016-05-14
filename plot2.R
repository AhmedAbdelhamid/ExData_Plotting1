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
png(file="plot2.png")
plot(NDt$DW,NDt$Global_active_power,type = 'l',ylab = "Global Active Power (kilowatts)",xlab = "")
dev.off()
