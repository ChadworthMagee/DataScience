question5 <- function()
{
        #download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_2/data.for', method='curl')
        
        
        x <- read.fwf(
                file="/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_2/data.for",
                skip=4,
                widths=c(12, 7,4, 9,4, 9,4, 9,4))
        print(sum(as.numeric(x$V4)))
}


question4 <- function()
{
        con = url('http://biostat.jhsph.edu/~jleek/contact.html')
        x = readLines(con)
        close(con)
        lines <- as.list(x)
        print(nchar(lines[10]))
        print(nchar(lines[20]))
        print(nchar(lines[30]))
        print(nchar(lines[100]))
}


question2 <- function()
{
        require(data.table)
        require(sqldf)
        #download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', 
        #              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_2/data.csv', method="curl")
        
        acs <- fread('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_2/data.csv')
        x <- sqldf("select pwgtp1 from acs where AGEP < 50")

}