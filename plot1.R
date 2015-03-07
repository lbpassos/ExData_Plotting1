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

##Creating the png device
png(file="plot1.png")
hist(mydata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()




