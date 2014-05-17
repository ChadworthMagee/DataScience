
question1 <- function()
{
        #file <-download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/data.csv', method='curl')
        
        require(data.table)
        dataset <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/data.csv')
        agricultureLogical <- which(with(dataset, ACR==3 & AGS==6))
}

question2 <- function()
{
        require(jpeg)
        #file <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', 
        #                      destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/picture.jpeg', method='curl')
        jpg <- readJPEG('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/picture.jpeg', native=TRUE)
        print(quantile(jpg,c(0.3,0.8)))
}

question3 <- function()
{
        require(data.table)
        #download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/countries.csv', method='curl')
        #download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/edu.csv', method='curl')
        
        countries <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/countries.csv')
        countries <- countries[as.numeric(countries$V2) < 191]
        print(nrow(countries))
        edu <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/edu.csv')
        print(nrow(edu))
        
        setnames(countries, "V1", "CountryCode")

        merged <- merge(countries, edu, by="CountryCode")
        merged <- merged[order(-as.numeric(merged$V2))]
        View(merged)
}

question4 <- function()
{
        require(data.table)
        #download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/countries.csv', method='curl')
        #download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/edu.csv', method='curl')
        
        countries <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/countries.csv')
        countries <- countries[as.numeric(countries$V2) < 191]
        edu <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/edu.csv')
        setnames(countries, "V1", "CountryCode")
        merged <- merge(countries, edu, by="CountryCode")
        merged <- merged[order(-as.numeric(merged$V2))]
        
        highIncomeOECD <- merged[merged[["Income Group"]]== 'High income: OECD']
        highIncomeNonOECD <- merged[merged[["Income Group"]]== 'High income: nonOECD']
        print(mean(as.numeric(highIncomeOECD$V2)))
        print(mean(as.numeric(highIncomeNonOECD$V2)))
}

question5 <- function()
{
        countries <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/countries.csv')
        countries <- countries[as.numeric(countries$V2) < 191]
        edu <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_3/edu.csv')
        setnames(countries, "V1", "CountryCode")
        merged <- merge(countries, edu, by="CountryCode")
        
        answer <- merged[as.numeric(merged$V2) < 39]
        answer <- answer[answer[["Income Group"]]== 'Lower middle income']
        print(nrow(answer))
}