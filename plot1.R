# installing pryr package to find out the size of the file and objects on R
# and also to make sure that we have enough RAM
install.packages("pryr")
library(pryr)
object_size("/Users/p/Desktop/Look/Education/Coursera/Data_Science_Certification/4_Exploratory_Data_Analysis/data/exdata%2Fdata%2Fhousehold_power_consumption.zip")

# unzipign the file
unzip("../../../../data/exdata%2Fdata%2Fhousehold_power_consumption.zip")
# measuring the size of the file before using read.table() function
object_size("../../household_power_consumption.txt")
object_size(read.table("../../household_power_consumption.txt"))
hspconsumption <- read.table("../../household_power_consumption.txt", sep = ";", header = TRUE)
dim(hspconsumption)
head(hspconsumption)

hspconsumption$Date <- as.Date(strptime(hspconsumption$Date, "%d/%m/%Y"), "%Y-%m-%d")
hspconsumption$Time <- format(strptime(hspconsumption$Time, "%H:%M:%S"), format = "%H:%M:%S")

hspconsumptionmain1 <- subset(hspconsumption, Date =="2007-02-01")
hspconsumptionmain2 <- subset(hspconsumption, Date =="2007-02-02")
hspconsumptionmain <- rbind(hspconsumptionmain1, hspconsumptionmain2)
str(hspconsumptionmain)
dim(hspconsumptionmain)

# converting variable from factor to numeric and keeping the decimals
hspconsumptionmain$Global_active_power <- as.numeric(as.character(hspconsumptionmain$Global_active_power))

# saving the plot in the PNG file
png("./plot1.png", width = 480, height = 480)

# creating the Plot 1
hist(hspconsumptionmain$Global_active_power, xlab="Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

# closing the file
dev.off()