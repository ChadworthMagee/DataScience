
q1 <- function()
{
#        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', method='curl', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/comm.csv')

        require(data.table)
        data <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/comm.csv')
        splittedColnames <- strsplit(colnames(data), split="wgtp")
        print(splittedColnames[[123]])
}

q2 <- function()
{
#        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', method='curl', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/gdp.csv')
        
        data <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/gdp.csv')
        ranked <- data[as.numeric(data$V2) < 191]
        gdpFigures <- ranked$V5
        gdpFiguresNoComma <- as.numeric(gsub(gdpFigures, pattern=",", replacement=""))
        print(mean(gdpFiguresNoComma))
}

q3 <- function()
{
        #        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', method='curl', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/gdp.csv')
        
        data <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/gdp.csv')
        data <- data[order(data$V4)]
        View(data)
}

q4 <- function()
{
#        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', method='curl', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/edu.csv')
        
        gdp <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/gdp.csv')
        gdp <- gdp[as.numeric(gdp$V2) < 191]
        edu <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_4/edu.csv')
        setnames(gdp, "V1", "CountryCode")
        merged <- merge(gdp, edu, by="CountryCode", all.x=TRUE)
        merged <- merged[order(merged[["Special Notes"]])]
        notes <- merged[["Special Notes"]]
        fiscal <- grep("^Fiscal", notes, value=T)
        fiscalJune <- grep("June", fiscal, value=T)
        # View(fiscalJune)
        print(length(fiscalJune))
}

q5 <- function()
{
        library(quantmod)
        amzn = getSymbols("AMZN",auto.assign=FALSE)
        sampleTimes = index(amzn) 
        values2012 <- grep(sampleTimes, pattern="2012", value=T)
        print(length(values2012))
}