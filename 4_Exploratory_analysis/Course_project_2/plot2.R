# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

q2_emissionPerYearBaltimore <- function(location='/home/wijnand/Downloads/emissionData/', 
                               targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot2.png')
{
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        balt <- NEIdata[NEIdata$fips=='24510',]
        png(targetFile, width=480, height=480)
        emissionPerYear <- aggregate(Emissions ~ year, balt, sum)
        barplot(emissionPerYear$Emissions, emissionPerYear$year, xlab="year", ylab="sum emissions", names.arg=emissionPerYear$year, 
                main="sum of emissions per year in Baltimore")
        dev.off()
}