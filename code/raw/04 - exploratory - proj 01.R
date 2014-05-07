# prog assign 1: row data
getwd()
setwd("C:\\Users\\mmorelli\\Google Drive\\Data Science\\04 - Exploratory Data Analysis\\Project 01\\ExData_Plotting1")

#
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# prepare dir structure
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./figure")){dir.create("./figure")}

download.file(fileUrl,destfile="./data/hpc.zip", mode = "wb", method="auto")

# strange bug in rstudio. the file war 
# unzipped file is a .txt semicolon separated

# direct reading into dataframe
powCons <- read.csv(unzip("./data/hpc.zip"), sep=";", stringsAsFactors=FALSE)

# object.size(powCons) # 83 Mb

# filter data
shortPowCons <- powCons[powCons$Date=="1/2/2007" | powCons$Date=="2/2/2007", ]

# str(shortPowCons)

# parse datetime
shortPowCons$DateTime <- strptime(paste(shortPowCons$Date, shortPowCons$Time), 
                                  "%d/%m/%Y %H:%M:%S");

# par()
# 
str(shortPowCons)
Sys.setlocale("LC_TIME", "English") 
par(mfrow = c(1, 1))
# ---------------- plot 1
shortPowCons$Gl_act_pow_num <- as.numeric(shortPowCons$Global_active_power)
# str(shortPowCons$Gl_act_pow_num)
png(filename="./figure/plot1.png",  width= 480, height = 480)
hist(shortPowCons$Gl_act_pow_num, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

# ---------------- plot 2


plot(shortPowCons$DateTime, shortPowCons$Gl_act_pow_num, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# need to be resolved the language of the axis


# ---------------- plot 3

shortPowCons$sub_met_num1 <- as.numeric(shortPowCons$Sub_metering_1)
shortPowCons$sub_met_num2 <- as.numeric(shortPowCons$Sub_metering_2)
shortPowCons$sub_met_num3 <- as.numeric(shortPowCons$Sub_metering_3)


with(shortPowCons, plot(DateTime, shortPowCons$sub_met_num1, 
                        ylab="Energy sub metering", xlab="", type="n" ))
with(shortPowCons, points(DateTime, sub_met_num1, col="black", type="l"))
with(shortPowCons, points(DateTime, sub_met_num2, col="red",   type="l"))
with(shortPowCons, points(DateTime, sub_met_num3, col="blue",  type="l"))
legend("topright", lwd="1", 
        col=c("black", "red", "blue"), 
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# ---------------- plot 4

shortPowCons$Voltage <- as.numeric(shortPowCons$Voltage)
shortPowCons$Gl_rea_pow_num <- as.numeric(shortPowCons$Global_reactive_power)
png(filename="./figure/plot4.png",  width= 480, height = 480)

par(mfrow = c(2, 2))

with(shortPowCons, {
    # plot 1,1
    plot(DateTime, Gl_act_pow_num, type="l",
         ylab="Global Active Power", xlab="")

    # plot 1,2
    plot(DateTime, Voltage, ylab="Voltage", xlab="datetime", type="l")

    # plot 2,1
    with(shortPowCons, plot(DateTime, shortPowCons$sub_met_num1, 
                            ylab="Energy sub metering", xlab="", type="n" ))
    with(shortPowCons, points(DateTime, sub_met_num1, col="black", type="l"))
    with(shortPowCons, points(DateTime, sub_met_num2, col="red",   type="l"))
    with(shortPowCons, points(DateTime, sub_met_num3, col="blue",  type="l"))
    legend("topright", lwd="1", 
           col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # plot 2,2
    plot(DateTime, Gl_rea_pow_num, ylab="Global_reactive_power", 
         xlab="datetime", type="l")
    
})
dev.off()
# ----------------
# TEST

source("./code/final/plot1.R", chdir=T)
source("./code/final/plot2.R", chdir=T)
source("./code/final/plot3.R", chdir=T)
source("./code/final/plot4.R", chdir=T)
?png

