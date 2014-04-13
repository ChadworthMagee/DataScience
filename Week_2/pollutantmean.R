#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 

#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 

#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. A prototype of the function is as follows

# HELPFULL

# rm(list=ls(all=TRUE))
# View(functionData)

pollutantmean <- function(directory, pollutant, id = 1:332) 
{
  csv <- readCsvData(directory, id)
  #View(csv)
}

readCsvData <- function(directory, id = 1:332)
{
  library(stringr)
  data <- NULL
  for(i in id)
  {
    tmp <- i
    if(tmp < 10)
    {
        tmp <- paste("00", tmp)
    }
    else if (i < 100)
    {
        tmp <- paste("0", tmp)
    }
    csvFile <- paste(directory, tmp, ".csv")
    csvFileStrip <- str_replace_all(string=csvFile, pattern=" ", repl="")
    print(csvFileStrip)
    data1file <- read.csv(csvFileStrip, dec=",", header=TRUE)
    nitrateValues <- c(data1file["nitrate"])
    data <- c(nitrateValues, data) 
    #data <- rbind(nitrateValues)
    #print(nitrateValues[2])
    
    print(paste("length nitrateValues", length(nitrateValues$nitrate))) # works
    print(paste("length data", length(data$nitrate))) # works
  }
  data1file
}
