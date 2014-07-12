# rm(list=ls(all=TRUE))

runQ5 <- function()
{
        # from the question
        set.seed(3433)
        library(AppliedPredictiveModeling)
        library(caret)
        data(AlzheimerDisease)
        adData = data.frame(diagnosis,predictors)
        inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
        training = adData[ inTrain,]
        testing = adData[-inTrain,]
        
        # own code
        train_IL <- training[,grep('^IL',names(training))]
        train_IL$diagnosis <- training$diagnosis
        
        testing_PCA <- testing[,grep('^IL',names(training))]
        
        modelFit <- train(diagnosis ~ . , data = train_IL, method = "glm")
        prediction <- predict(modelFit, newdata = testing)
        print(confusionMatrix(prediction, testing$diagnosis))
        
        # with PCA
        print(str(train_IL[-13]))
        train_PCA <- preProcess(train_IL[-13], method="pca", tresh=0.8)
        trainPC <- predict(train_PCA, train_IL[-13])
        testing_PCA <- predict(train_PCA, testing_PCA)
        trainPC$diagnosis <- train_IL$diagnosis
        
        modelFitPCA <- train(diagnosis ~ . , data = trainPC, method = "glm")
        predictionPCA <- predict(modelFitPCA, newdata = testing_PCA)

        print(confusionMatrix(predictionPCA, testing$diagnosis))
}

runQ2 <- function()
{
        # from question
        library(AppliedPredictiveModeling)
        data(concrete)
        library(caret)
        set.seed(975)
        inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
        training = mixtures[ inTrain,]
        testing = mixtures[-inTrain,]
        
        # own code
        print(str(training))
        print(summary(training$CompressiveStrength))
        #plot(training$CompressiveStrength, training$Age)
        featurePlot(training, training$CompressiveStrength, plot="pairs")
}