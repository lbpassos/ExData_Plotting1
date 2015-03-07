library(lubridate)
library(datasets)

data_path <- "..\\exdata-data-household_power_consumption\\household_power_consumption.txt"

data <- read.table(data_path, header=TRUE, sep=";", na.strings="?")
##Converting factor to Date object
data$Date <- as.Date(as.character(data[,1]), format = "%d/%m/%Y")

##Creating the interval 
start_date<-as.Date("2007/02/01")
interval <- new_interval(start_date, start_date+1)

##Select the interval
mydata <- data[data$Date %within% interval, ]
rm(data)

##Creating x axis data
t_1<-strptime(as.character(mydata$Time), format = "%H:%M:%S")
mydata$Date <- update(t_1, years=year(mydata$Date), months=month(mydata$Date), days=day(mydata$Date))

Sys.setlocale("LC_TIME", "English")

##Creating the png device
png(file="plot4.png")
par( mfrow = c(2, 2) )
with(mydata, {
	
	plot(Date, Global_active_power, type="l", xlab="", ylab="Global Acrive Power")
	plot(Date, Voltage, type="l", xlab="datetime", ylab="Voltage")
	plot(Date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	points(Date, Sub_metering_2, type="l", col="red")
	points(Date, Sub_metering_3, type="l", col="blue")
	legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	plot(Date, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

})

dev.off()