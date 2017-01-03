# installing pryr package to find out the size of the file and objects on R
# and also to make sure that we have enough RAM
install.packages("pryr")
library(pryr)
object_size("/Users/p/Desktop/Look/Education/Coursera/Data_Science_Certification/4_Exploratory_Data_Analysis/data/exdata%2Fdata%2Fhousehold_power_consumption.zip")

# unzipign the downloaded file
unzip("../../../../data/exdata%2Fdata%2Fhousehold_power_consumption.zip")
# measuring the size of the file before using read.table() function
object_size("../../household_power_consumption.txt")
object_size(read.table("../../household_power_consumption.txt"))
hspconsumption <- read.table("../../household_power_consumption.txt", sep = ";", header = TRUE)

hspconsumption$Date <- as.Date(strptime(hspconsumption$Date, "%d/%m/%Y"), "%Y-%m-%d")
hspconsumption$Time <- format(strptime(hspconsumption$Time, "%H:%M:%S"), format = "%H:%M:%S")

hspconsumptionmain1 <- subset(hspconsumption, Date =="2007-02-01")
hspconsumptionmain2 <- subset(hspconsumption, Date =="2007-02-02")
hspconsumptionmain <- rbind(hspconsumptionmain1, hspconsumptionmain2)
str(hspconsumptionmain)
dim(hspconsumptionmain)

# converting variable from factor to numeric and keeping the decimals
hspconsumptionmain$Global_active_power <- as.numeric(as.character(hspconsumptionmain$Global_active_power))

# pasting date and time
dtdata <- paste(as.Date(hspconsumptionmain$Date), hspconsumptionmain$Time)
# creating column for combined date/time
hspconsumptionmain$Date_Time <- as.POSIXct(dtdata)

# converting Sub_metering_1 and Sub_metering_2 to numeric (Sub_metering_3 is already numeric)
hspconsumptionmain$Sub_metering_1 <- as.numeric(as.character(hspconsumptionmain$Sub_metering_1))
hspconsumptionmain$Sub_metering_2 <- as.numeric(as.character(hspconsumptionmain$Sub_metering_2))
hspconsumptionmain$Sub_metering_3 <- as.numeric(as.character(hspconsumptionmain$Sub_metering_3))


# saving the plot in the PNG file
#png("./plot2.png", width = 480, height = 480)

# creating the Plot 3
with(hspconsumptionmain, plot(Date_Time,Sub_metering_1,ylab = "Energy sub metering",xlab = "",type = "l",yaxt="n"))
axis(side=2,at=c(0,10,20,30),labels=c(0,10,20,30))
lines(hspconsumptionmain$Date_Time,hspconsumptionmain$Sub_metering_2, col = "red")
lines(hspconsumptionmain$Date_Time,hspconsumptionmain$Sub_metering_3, col = "blue")
legend("topright",col = c("black", "red", "blue" ), lty = "solid", legend = c("Sub_merging_1", "Sub_merging_2", "Sub_merging_3"))
# closing the file
dev.off()