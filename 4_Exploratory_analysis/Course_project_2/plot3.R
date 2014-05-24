# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in #emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 

# Use the ggplot2 plotting system to make a plot #answer this question.

q3_typesOfSourcesBaltimore <- function(location='/home/wijnand/Downloads/emissionData/', 
                                        targetFile='/home/wijnand/R_workspace/4_Exploratory_analysis/Course_project_2/plot3.png')
{
        require(ggplot2)
        NEIdata <- readRDS(paste(location, "summarySCC_PM25.rds", sep=''))
        balt <- NEIdata[NEIdata$fips=='24510',]
        emissionPerYear <- aggregate(Emissions ~ year + type, balt, sum)
        View(emissionPerYear)
        plotje <- ggplot(emissionPerYear, aes(year, Emissions)) + geom_line(stat="identity", aes(fill=emissionPerYear$type, colour=emissionPerYear$type)) + ggtitle("Sum emissions per year per type in Baltimore")
        # ggsave(targetFile, plotje, width=6, height=6)
}