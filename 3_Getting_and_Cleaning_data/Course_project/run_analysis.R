
runAnalysis <- function(sourceDir='/home/wijnand/Downloads/UCI HAR Dataset/')
{
        # load / read all relevant files 
        activityLabels <- read.table(paste(sourceDir, "activity_labels.txt", sep=''), header=FALSE)
        features <- read.table(paste(sourceDir, "features.txt", sep=''), header=FALSE)
        trainX <- read.table(paste(sourceDir, "train/X_train.txt", sep=''), header=FALSE)
        testX <- read.table(paste(sourceDir, "test/X_test.txt", sep=''), header=FALSE)
        trainY <- read.table(paste(sourceDir, "train/y_train.txt", sep=''), header=FALSE)
        testY <- read.table(paste(sourceDir, "test/y_test.txt", sep=''), header=FALSE)
        trainTestSubject <- read.table(paste(sourceDir, "train/subject_train.txt", sep=''), header=FALSE)
        testTestSubject <- read.table(paste(sourceDir, "test/subject_test.txt", sep=''), header=FALSE)
        
        # set column names
        colnames(activityLabels) <- c('activityId','activityType')
        colnames(trainX) <- features[,2]
        colnames(trainY) <- "activityId"
        colnames(trainTestSubject) <- "subjectId"
        colnames(testX) <- features[,2]
        colnames(testY) <- "activityId"
        colnames(testTestSubject) <- "subjectId"
        
        
        # step 1, merge training and test sets
        trainData <- cbind(trainY, trainTestSubject, trainX)
        testData <- cbind(testY, testTestSubject, testX)
        allData <- rbind(trainData, testData)

        # step 2, select the columns about mean / standard deviation (plus the activity / subject)
        cols <- c(grep("mean|activity|subject|std", colnames(allData)))
        filteredData <- allData[,cols]
        
        
        # step 3, descriptive activity names
        for(i in 1:length(filteredData[,1]))
        {
                filteredData[i,1] <- as.character(activityLabels[filteredData[i,1],2])
        }
}