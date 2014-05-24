

q1_emissionPerYear <- function(location='/home/wijnand/Downloads/emissionData/', 
                               targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot1.png')
{
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        png(targetFile, width=480, height=480)
        emissionPerYear <- aggregate(Emissions ~ year, NEIdata, sum)
        barplot(emissionPerYear$Emissions, emissionPerYear$year, xlab="year", ylab="sum emissions", names.arg=emissionPerYear$year, 
                main="sum of emissions per year")
        dev.off()
}