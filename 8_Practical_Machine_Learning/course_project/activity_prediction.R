# rm(list=ls(all=TRUE))
location <- '/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/train.csv'


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
                
        # scale & center all numeric variables
        # preObj <- preProcess(training[,sapply(training,is.numeric)], method=c("center","scale"))
        
        print(str(training))
        training
        
        trainedModel <- train(classe ~ . , training, 
                              method="rf",
        #                      method="C5.0",
                              preProcess=NULL, 
                              tuneLength = 5,
                              trControl = trainControl(method = "cv"), 
                              do.trace=T,
                              ntree=100)
        
        print(trainedModel)
        prediction <- predict(trainedModel, testing)
        print(confusionMatrix(prediction, testing$classe))
}