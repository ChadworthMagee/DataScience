
# load the raw data
loadRawData <- function(location='/home/wijnand/household_power_consumption.txt')
{
        require(data.table)
        data <- fread(location, sep=";", na.strings='?')
        # filter the data based on given dates
        data <- data[as.Date(data$Date, format='%d/%m/%Y') >= as.Date('01/02/2007', format='%d/%m/%Y')
                             & as.Date(data$Date, format='%d/%m/%Y') <= as.Date('02/02/2007', format='%d/%m/%Y')]
}

# plot a histogram and save it to the targetFile
plot1 <- function(data, targetFile='/home/wijnand/R_workspace_ex/plot1.png')
{
        png(targetFile, width=480, height=480)
        hist(as.numeric(data$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
        dev.off()
}