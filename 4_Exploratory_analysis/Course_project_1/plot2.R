
# load the raw data
loadRawData <- function(location='/home/wijnand/household_power_consumption.txt')
{
        require(data.table)
        data <- fread(location, sep=";", na.strings='?')
        # filter the data based on given dates
        data <- data[as.Date(data$Date, format='%d/%m/%Y') >= as.Date('01/02/2007', format='%d/%m/%Y')
                     & as.Date(data$Date, format='%d/%m/%Y') <= as.Date('02/02/2007', format='%d/%m/%Y')]
}

# plot a graph and save it to the targetFile
plot2 <- function(data, targetFile='/home/wijnand/R_workspace_ex/plot2.png')
{
        png(targetFile, width=480, height=480)
        dateTime <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')
        plot(dateTime, as.numeric(data$Global_active_power), type='l', ylab="Global Active Power (kilowatts)", xlab='')
        dev.off()
}