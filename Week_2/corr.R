# Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. 

# The function should return a vector of correlations for the monitors that meet the threshold requirement. 

# If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. A prototype of this function follows

corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        library(stringr)
        x <- NULL
        for(i in 1:332)
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
                csvFile <- paste(getwd(), '/', directory,'/', tmp, ".csv")
                csvFileStrip <- str_replace_all(string=csvFile, pattern=" ", repl="")
                data1file <- read.csv(csvFileStrip, dec=".", header=TRUE)
                clean <- na.omit(data1file)
                if(is.null(x))
                {
                        if(nrow(clean) > threshold)
                        {
                                x <- cor(clean$sulfate, clean$nitrate)                        
                        }
                }
                else
                {
                        if(nrow(clean) > threshold)
                        {
                                x <- append(x, cor(clean$sulfate, clean$nitrate))  
                        }
                }
                
                #View(clean)
                #break;        
        }
        View(x)
        print(class(x))
        x
}