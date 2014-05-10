
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
plot4 <- function(data, targetFile='/home/wijnand/R_workspace_ex/plot4.png')
{
        png(targetFile, width=480, height=480)
        dateTime <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')
        
        par(mfrow=c(2,2))
        with(data, {
                # plot 1,1
                plot(dateTime, as.numeric(data$Global_active_power), type='l', ylab="Global Active Power", xlab='')
                # plot 1,2
                plot(dateTime, as.numeric(data$Voltage), type='l', ylab="Voltage", xlab='datetime')
                
                # plot 2,1
                plot(dateTime, data$Sub_metering_1, type='l', ylab="Energy sub metering", xlab='', col='black')
                lines(dateTime, data$Sub_metering_2, type='l', col='red')
                lines(dateTime, data$Sub_metering_3, type='l', col='blue')
                legend("topright", cex=0.7, legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c('black', 'red', 'blue'),lty=1)  
                
                # plot 2,2
                plot(dateTime, as.numeric(data$Global_reactive_power), type='l', ylab="Global_reactive_power", xlab='datetime')
        })
        dev.off()
}