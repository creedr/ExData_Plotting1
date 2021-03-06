## The following script plots a time series of three different metering
## stations in the same household overlaid onto the same plot
## for the dates Feb. 1 and 2, 2007 for an individual household.
## The data is the Individual Household Electric Power Consumption Data Set
## taken from the UC Irvine Machine Learning Repository
## http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+
## consumption
##
## Created by Cory R Robinson on 08/07/2014
##
## The dataset has 2,075,259 rows and 9 columns.
## 2075259 x 9 x 8 ~ 149418648 bytes
## --> 142.4967 MB

## We begin by reading in a subset of the data for dates from 01/02/2007
## to 02/02/2007 -- dd/mm/yyy
## We have subsetted the data on the system (Mac OS 10.9.4) command line
## by first creating a new file using the header values from the original data
## file with the following command:

##$ head -n 1 household_power_consumption.txt > feb_1.txt

## Then we search the file using regular expressions to pick out the 
## appropriate dates with two commands, first:

##$ cat data/household_power_consumption.txt  | grep '^1/2/2007'
##      >> feb_1.txt

## and then for Feb. 2 we use the command:

##$ cat data/household_power_consumption.txt  | grep '^2/2/2007'
##      >> feb_2.txt

## We then combine these two file with the 'cat' command into one file
## which we will use for reading the data into R:

##$ cat feb_1.txt feb_2.txt > feb_1_and_2_2007.txt

##
## reading data
fileName <- "data/feb_1_and_2_2007.txt"
dat <- read.table(fileName, header=TRUE, sep=";",
                  na.strings="?")

## reformat the dates and time using strptime()
dt <- paste(dat$Date, dat$Time)
dat$Datetime <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## plot the sub-metering time series data
plot(dat$Datetime, dat$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering", col = "black")
lines(dat$Datetime, dat$Sub_metering_2, type = "l", xlab = "",
       ylab = "Energy sub metering", col = "red")
lines(dat$Datetime, dat$Sub_metering_3, type = "l", xlab = "",
       ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## save the picture to a png file
dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off