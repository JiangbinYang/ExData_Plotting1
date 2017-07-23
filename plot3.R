#####################
# Loading the data: #
#####################

setwd("C:/_Jiangbin/Studies/Data Science/R JHU/Course4_Exploratory/Week1")

if (!file.exists("./data")){
  dir.create("data")
}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
FileName <- "./data/household_power_consumption.zip"
if (!file.exists(FileName)) {
  download.file(fileURL, FileName)
  unzip(FileName)
}
list.files()

dfColNames <- read.table("household_power_consumption.txt", 
                         header=TRUE, sep=";", nrows=2)
df <- read.table("household_power_consumption.txt", header=FALSE, sep=";",
           skip=(grep("1/2/2007", readLines("household_power_consumption.txt"))[1] - 1),
           nrows=2880)
colnames(df) <- colnames(dfColNames)
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

####################
# Making the plot: #
####################

png(file="plot3.png")
with(df, plot(DateTime, Sub_metering_1, type="l", ylab="Energe sub metering"))
with(df, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(df, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend(as.POSIXct("2007-02-02 07:00:00"), 39.5,
       lty=c(1,1,1), col=c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
