## Cook Book


```{r}
        activityLabels <- read.table(paste(sourceDir, "activity_labels.txt", sep=''), header=FALSE)
        features <- read.table(paste(sourceDir, "features.txt", sep=''), header=FALSE)
        trainX <- read.table(paste(sourceDir, "train/X_train.txt", sep=''), header=FALSE)
        testX <- read.table(paste(sourceDir, "test/X_test.txt", sep=''), header=FALSE)
        trainY <- read.table(paste(sourceDir, "train/y_train.txt", sep=''), header=FALSE)
        testY <- read.table(paste(sourceDir, "test/y_test.txt", sep=''), header=FALSE)
        trainTestSubject <- read.table(paste(sourceDir, "train/subject_train.txt", sep=''), header=FALSE)
        testTestSubject <- read.table(paste(sourceDir, "test/subject_test.txt", sep=''), header=FALSE)
```

Merges the training and the test sets to create one data set.
```{r}
        trainData <- cbind(trainY, trainTestSubject, trainX)
        testData <- cbind(testY, testTestSubject, testX)
        allData <- rbind(trainData, testData)
```

Extracts only the measurements on the mean and standard deviation for each measurement. 
```{r}
        cols <- c(grep("mean|activity|subject|std", colnames(allData)))
        filteredData <- allData[,cols]
```

Uses descriptive activity names to name the activities in the data set
```{r}      
        for(i in 1:length(filteredData[,1]))
        {
                filteredData[i,1] <- as.character(activityLabels[filteredData[i,1],2])
        }
```

Appropriately labels the data set with descriptive activity names. 
```{r} 
        require(stringr)
        cols <- colnames(filteredData)
        cols <- str_replace_all(cols, "([-])" , "_" )
        cols <- str_replace_all(cols, "([()])", "" )
        
        require(data.table)
        filteredData <- as.data.table(filteredData)
        setnames(filteredData, old=colnames(filteredData),new=cols)
```

Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 