
runAnalysis <- function(sourceDir='/home/wijnand/Downloads/UCI HAR Dataset/test/Inertial Signals/')
{
        require(data.table)
        files <- list.files(sourceDir)
        
        dataTable <- NULL
        for(i in files)
        {
                path <- paste(sourceDir, i, sep='')
                x <- fread(path, sep='\n', sep2='-', header=FALSE)
                View(x)
                break
                dataTable <- rbind(dataTable, x)
        }
        View(dataTable)
}