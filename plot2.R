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

png(file="plot2.png")
with(df, plot(DateTime, Global_active_power, type="l", 
              ylab = "Global Active Power (kilowatts)"))
dev.off()
