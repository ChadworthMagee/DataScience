#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 

#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 

#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. A prototype of the function is as follows

# HELPFULL

# rm(list=ls(all=TRUE))
# View(functionData)

pollutantmean <- function(directory, pollutant, id = 1:332) 
{
  csv <- readCsvData(directory, id)
  if(pollutant == "sulfate")
  {
         #print(as.double(csv$sulfate))
        calculatedMean <- mean(csv$sulfate, na.rm = TRUE);
        
  }
  else if (pollutant == "nitrate")
  {
        calculatedMean <- mean(as.numeric(csv$nitrate), na.rm = TRUE); 
  }
  print(calculatedMean)
}

readCsvData <- function(directory, id = 1:332)
{
  library(stringr)
  x <- NULL
  for(i in id)
  {
    #print(getwd())
    tmp <- i
    if(tmp < 10)
    {
        tmp <- paste("00", tmp)
    }
    else if (i < 100)
    {
        tmp <- paste("0", tmp)
    }
    csvFile <- paste(getwd(), '/', directory,'/', tmp, ".csv")
    csvFileStrip <- str_replace_all(string=csvFile, pattern=" ", repl="")
    print(csvFileStrip)
    data1file <- read.csv(csvFileStrip, dec=".", header=TRUE)
    if(is.null(x))
    {
        x <- data1file
    }
    else
    {
        x <- rbind(x, data1file)
    }
    #print(nrow(x))
  }
  x
}