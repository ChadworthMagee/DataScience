# Write a function that reads a directory full of files and reports the number of completely observed cases in each  data file. 

#The function should return a data frame where the first column is the name of the file and the second  column is the number of complete cases.

complete <- function(directory, id = 1:332)
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
                #print(csvFileStrip)
                data1file <- read.csv(csvFileStrip, dec=".", header=TRUE)
                clean <- na.omit(data1file)
                if(is.null(x))
                {
                     x <- data.frame(id=i, nobs=nrow(clean)) 
                }
                else
                {
                        x <-rbind(x, c(i, nrow(clean)))
                }
        }
        x
        print(x)
 #       View(x)
}