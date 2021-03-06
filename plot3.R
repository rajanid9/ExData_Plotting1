#R script used to create Plot 3 for Week 1 EDA Assignment from Household Power Consumption Dataset


library(downloader)
library(readr)

#Download Raw data into working directory

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(data_url,dest = "./exdata_data_household_power_consumption.zip",mode = "wb")
unzip("exdata_data_household_power_consumption.zip",exdir = "./")

#Read power consumption data from text file
elec_consum_data <- read_csv2("household_power_consumption.txt")
elec_consum_data$Date <- as.Date(elec_consum_data$Date, "%d/%m/%Y")
elec_consum_data <- subset(elec_consum_data,Date>= "2007-02-01" & Date <= "2007-02-02")
elec_consum_data$datetime <- as.POSIXct(paste(elec_consum_data$Date,elec_consum_data$Time))
elec_consum_data$Global_active_power<- as.numeric(elec_consum_data$Global_active_power)

dev.print(png, file = "plot3.png", width = 480, height = 480)
png(file = "plot3.png", bg = "white")
with(elec_consum_data,plot(datetime,Sub_metering_1,type="l",col="black",xlab="datetime",ylab="Energy sub metering"))
with(elec_consum_data,points(datetime,Sub_metering_2,type="l",col="red"))
with(elec_consum_data,points(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright", lty=1,   col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()