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


## create function for plot2
plot2 <- function() { 
  plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
}


# plot on screen 
plot2()

# Saving to file using png function to avoid the copy issue distorting the plot
png( file="plot2.png", height=480, width=480 )
plot2( )
dev.off()

