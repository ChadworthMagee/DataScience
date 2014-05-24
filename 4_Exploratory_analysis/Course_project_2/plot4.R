# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

q4_coalCombustionUS <- function(location='/home/wijnand/Downloads/emissionData/', 
                                        targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot4.png')
{
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        SCC <- readRDS(paste(location, "Source_Classification_Code.rds", sep=''))
        
        coalSCC <- grep('*((C|c)oal)+', SCC$EI.Sector)
        filteredSCC <- as.character(SCC[coalSCC,]$SCC)
        
        require(data.table)
        options(stringsAsFactors=FALSE)

        neiTable <- as.data.table(NEIdata)
        filter <- neiTable[neiTable$SCC==filteredSCC,]
        
        png(targetFile, width=480, height=480)
        emissionPerYear <- aggregate(Emissions ~ year, filter, sum)
        barplot(emissionPerYear$Emissions, emissionPerYear$year, xlab="year", ylab="sum emissions", names.arg=emissionPerYear$year, 
                main="sum of emissions per year, coal-related")
        dev.off()
}