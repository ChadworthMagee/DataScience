# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

q5_motorBaltimore <- function(location='/home/wijnand/Downloads/emissionData/', 
                                        targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot5.png')
{
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        baltOnRoad <- NEIdata[NEIdata$fips=='24510' & NEIdata$type=='ON-ROAD',]
                
        png(targetFile, width=480, height=480)
        emissionPerYear <- aggregate(Emissions ~ year, baltOnRoad, sum)
        barplot(emissionPerYear$Emissions, emissionPerYear$year, xlab="year", ylab="sum emissions", names.arg=emissionPerYear$year, 
                main="sum of emissions per year in Baltimore, vehicle-related")
        dev.off()
}