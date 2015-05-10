## reading the dataset: 
# 
# * The dataset has 2,075,259 rows and 9 columns. First
# calculate a rough estimate of how much memory the dataset will require
# in memory before reading into R. Make sure your computer has enough
# memory (most modern computers should be fine).
# 
# * You may find it useful to convert the Date and Time variables to
# Date/Time classes in R using the `strptime()` and `as.Date()`
# functions.
# 
# * Note that in this dataset missing values are coded as `?`.
# 
dataset <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# convert date column
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

# 
# * We will only be using data from the dates 2007-02-01 and
# 2007-02-02. One alternative is to read the data from just those dates
# rather than reading in the entire dataset and subsetting to those
# dates.
data <- subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
# remove the full dataset from memory
rm(dataset)

# Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


## create function for plot 4
plot4 <- function(){
  # this time we need 4 plots, and a specified margin
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  
  # the plots
  with(data, {
      # plot 1
      plot(Global_active_power~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      # plot 2
      plot(Voltage~Datetime, type="l", 
           ylab="Voltage (volt)", xlab="")
      # plot 3
      plot(Sub_metering_1~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      # plot 4
      plot(Global_reactive_power~Datetime, type="l", 
           ylab="Global Rective Power (kilowatts)",xlab="")
  })
}
# plot on screen 
plot4()

# Saving to file using png function to avoid the copy issue distorting the plot
png( file="plot4.png", height=480, width=480 )
plot4( )
dev.off()
