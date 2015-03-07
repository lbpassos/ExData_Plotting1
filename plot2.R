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
png(file="plot2.png")
plot(mydata$Date, mydata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()





