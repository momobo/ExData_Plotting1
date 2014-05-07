#-------------------------------------------------------------------------------
# plot 1
#  see Readme File
#
# launch the script with source(plot1.R, chdir=T)
#-------------------------------------------------------------------------------
# create directory if they do not exists
if(!file.exists("../../data")){dir.create("../../data")}
if(!file.exists("../../figure")){dir.create("../../figure")}

# check if data exists. If not download it.
if(!file.exists("../../data/hpc.zip")){
    Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(Url,destfile="../../data/hpc.zip", mode = "wb", method="auto") 
}

# direct reading into dataframe
powCons <- read.csv(unzip("../../data/hpc.zip"), sep=";", stringsAsFactors=F)

# filter data
shortPowCons <- powCons[powCons$Date=="1/2/2007" | powCons$Date=="2/2/2007", ]

# parse datetime
shortPowCons$DateTime <- strptime(paste(shortPowCons$Date, shortPowCons$Time), 
                                  "%d/%m/%Y %H:%M:%S");

# set locale and be sure is the right trellis setting
Sys.setlocale("LC_TIME", "English") 
#-------------------------------------------------------------------------------


shortPowCons$sub_met_num1 <- as.numeric(shortPowCons$Sub_metering_1)
shortPowCons$sub_met_num2 <- as.numeric(shortPowCons$Sub_metering_2)
shortPowCons$sub_met_num3 <- as.numeric(shortPowCons$Sub_metering_3)

png(filename="../../figure/plot3.png",  width= 480, height = 480)

par(mfrow = c(1, 1), bg="transparent")

with(shortPowCons, plot(DateTime, shortPowCons$sub_met_num1, 
                        ylab="Energy sub metering", xlab="", type="n" ))
with(shortPowCons, points(DateTime, sub_met_num1, col="black", type="l"))
with(shortPowCons, points(DateTime, sub_met_num2, col="red",   type="l"))
with(shortPowCons, points(DateTime, sub_met_num3, col="blue",  type="l"))
legend("topright", lwd="1", 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



dev.off()

    