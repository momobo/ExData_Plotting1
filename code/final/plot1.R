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
par(mfrow = c(1, 1))

shortPowCons$Gl_act_pow_num <- as.numeric(shortPowCons$Global_active_power)

png(filename="../../figure/plot1.png",  width= 480, height = 480)

hist(shortPowCons$Gl_act_pow_num, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

    