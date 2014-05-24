# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 

# Which city has seen greater changes over time in motor vehicle emissions?


q6_motorBaltLA <- function(location='/home/wijnand/Downloads/emissionData/', 
                                        targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot6.png')
{
        require(ggplot2)
        require(data.table)
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        balt <- NEIdata[NEIdata$fips=='24510',]
        la <- NEIdata[NEIdata$fips=='06037',]
        
        emissionPerYearBalt <- as.data.table(aggregate(Emissions ~ year, balt, sum))
        emissionPerYearLA <- as.data.table(aggregate(Emissions ~ year, la, sum))
        
        emissionPerYearBalt <- emissionPerYearBalt[order(emissionPerYearBalt$year),]
        emissionPerYearLA <- emissionPerYearLA[order(emissionPerYearLA$year),]
        
        setnames(emissionPerYearBalt, "Emissions", "EmissionsBalt")
        setnames(emissionPerYearLA, "Emissions", "EmissionsLA")
        
        require(quantmod)
        together <- merge(emissionPerYearBalt, emissionPerYearLA, all=TRUE, by="year")
        together$diffBalt <- Delt(together$EmissionsBalt)
        together$diffLa <- Delt(together$EmissionsLA)
        
        png(targetFile, width=480, height=480)
        barplot(t(data.frame(together$diffBalt,together$diffLa)) , together$year, names.arg=as.character(together$year), beside=TRUE, main="Change sum emission Baltimore vs LA", col=c("blue", "red"))
        legend("top", legend=c("Baltimore", "LA"), fill=c("blue", "red"))
        dev.off()
}