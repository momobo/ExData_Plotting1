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

shortPowCons$Gl_act_pow_num <- as.numeric(shortPowCons$Global_active_power)

shortPowCons$sub_met_num1 <- as.numeric(shortPowCons$Sub_metering_1)
shortPowCons$sub_met_num2 <- as.numeric(shortPowCons$Sub_metering_2)
shortPowCons$sub_met_num3 <- as.numeric(shortPowCons$Sub_metering_3)

shortPowCons$Voltage <- as.numeric(shortPowCons$Voltage)
shortPowCons$Gl_rea_pow_num <- as.numeric(shortPowCons$Global_reactive_power)

png(filename="../../figure/plot4.png",  width= 480, height = 480)

# mfrow should be set after the opening of the device
par(mfrow = c(2, 2))
# plotting
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

    