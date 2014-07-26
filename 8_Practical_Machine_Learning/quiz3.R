
q1 <- function()
{
        library(AppliedPredictiveModeling)
        data(segmentationOriginal)
        library(caret)
        
        training <- segmentationOriginal[segmentationOriginal$Case=="Train",]
        test <- segmentationOriginal[segmentationOriginal$Case=="Test",]
        
        set.seed(125)
        trainedModel <- train(Class ~ . , data = training, method="rpart")
}

q3 <- function()
{
        #library(pgmm)
        #library(cepp)
        #data(olive)
        #View(olive)
        olive2 = olive[,-1]
        
        trainedModel <- train(Area ~ . , olive2, method="rpart")
        
        newdata = as.data.frame(t(colMeans(olive2)))
        prediction <- predict(trainedModel, newdata)
        print(prediction)
}

q4 <- function()
{
        library(ElemStatLearn)
        data(SAheart)
        set.seed(8484)
        train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
        trainSA = SAheart[train,]
        testSA = SAheart[-train,]
        
        set.seed(13234)
        trainedModel <- train(chd ~ age + alcohol + obesity +tobacco + typea +ldl, data = trainSA, method="glm", family="binomial")
        
        predictionTrain <- predict(trainedModel, newdata = trainSA)
        predictionTest <- predict(trainedModel, newdata = testSA)
        
        missTrain <- missClass(trainSA$chd, predictionTrain)
        missTest <- missClass(testSA$chd, predictionTest)
        
        print(missTest)
        print(missTrain)
}

missClass <- function(values,prediction)
{
        sum(((prediction > 0.5)*1) != values)/length(values)
}

q5 <- function()
{
        library(ElemStatLearn)
        data(vowel.train)
        data(vowel.test) 
        
        vowel.test$y <- as.factor(vowel.test$y)
        vowel.train$y <- as.factor(vowel.train$y)
        set.seed(33833)
        
        trainedModel <- train(y ~ . , data = vowel.train, method="rf", do.trace=T)
        variableImportance <- varImp(trainedModel)
}