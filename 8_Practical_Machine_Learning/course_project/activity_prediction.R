# rm(list=ls(all=TRUE))

loadData <- function(location='/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/train.csv')
{
        library(caret); set.seed(1234)
        
        data <- read.csv(location, na.strings = c("NA", "#DIV/0!", ""))
        # remove column with unique number
        data$X <- NULL
        
        # remove 'zero' and 'near-zero' columns
        uselessColumns <- nearZeroVar(data, freqCut = 95/5, uniqueCut = 10, saveMetrics = T)
        uselessColumns <- names(data[,uselessColumns$zeroVar==TRUE | uselessColumns$nzv==TRUE])
        data <- data[,!(names(data) %in% uselessColumns)]
        
        # remove columns in which > 97% of the values are not available
        data <- data[,colSums(is.na(data))<(nrow(data)*0.97)]
        
        # randomize the dataset
        data <- data[order(runif(nrow(data))),]
        
        inTrain <- createDataPartition(data$classe, p = 0.7, list=F)
        training <- data[inTrain,]
        testing <- data[-inTrain,]
        
        trainedModel <- train(classe ~ . , training, method="rf", trControl = trainControl(method = "cv", number = 2),do.trace=T,ntree=50)
        prediction <- predict(trainedModel, testing)
        confusionMatrix(prediction, testing$classe)
        
        testdata <- read.csv('/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/test.csv', 
                             na.strings = c("NA", "#DIV/0!", ""))
        prediction <- predict(trainedModel, testdata)
        
        pml_write_files(prediction)
        
        trainedModel
}

pml_write_files = function(x)
{
        n = length(x)
        for(i in 1:n){
                filename = paste0("/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}