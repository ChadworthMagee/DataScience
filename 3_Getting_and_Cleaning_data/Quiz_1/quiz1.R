

question_5 <- function()
{
        #file <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', 
        #                      destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data_q5.csv', method="curl")
        
        require(data.table)
        DT <- fread(input='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data_q5.csv')
        
        print("--1--")
        print(mean(DT$pwgtp15,by=DT$SEX))
        print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
        
        
        #print(system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]))
        
        
        print("--2--")
        print(sapply(split(DT$pwgtp15,DT$SEX),mean))
        print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
        
        print("--3--")
        print(DT[,mean(pwgtp15),by=SEX])
        print(system.time(DT[,mean(pwgtp15),by=SEX]))
        
        print("--4--")
        print(tapply(DT$pwgtp15,DT$SEX,mean))
        print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
        
        
        #print(system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)))wgtp15)))
}

question_4 <- function()
{
        require(XML)
        file <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml', 
                              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.xml', method="curl")
        
        xml <- xmlTreeParse('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.xml', useInternal=TRUE)
        xmlRoot <- xmlRoot(xml)
        zipCodes <- xpathSApply(xmlRoot, "//row[zipcode=21231]")
        print(length(zipCodes))
}


question_3 <- function()
{
        require(xlsx)
        file <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', 
                              destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.xlsx', method='curl')
        
        excelFile <- read.xlsx('/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.xlsx', sheetIndex=1, 
                               colIndex=7:15, rowIndex=18:23)
        
        answer <- sum(excelFile$Zip*excelFile$Ext,na.rm=T)
        print(answer)
        
}

question_1 <- function()
{
        require(data.table)
        
        file <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.csv', method='curl')
        
        x <- fread(input='/home/wijnand/R_workspace/3_Getting_and_Cleaning_data/Quiz_1/data.csv', sep=",")
        
        xFiltered <- x[x$VAL==24]
        print(nrow(xFiltered))
}