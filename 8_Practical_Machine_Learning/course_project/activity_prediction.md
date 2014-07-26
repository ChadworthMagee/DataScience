## Peer Assessment Practical Machine Learning
#### Predict activity type

## Load the data

```r
set.seed(1234)
library(caret)
location <- '/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/train.csv'
data <- read.csv(location, na.strings = c("NA", "#DIV/0!", ""))
```
## Modify data
#### Remove 'zero' and 'near-zero' columns

```r
data$X <- NULL
uselessColumns <- nearZeroVar(data, freqCut = 95/5, uniqueCut = 10, saveMetrics = T)
uselessColumns <- names(data[,uselessColumns$zeroVar==TRUE | uselessColumns$nzv==TRUE])
data <- data[,!(names(data) %in% uselessColumns)]
```

####  Remove columns in which > 97% of the values are not available

```r
data <- data[,colSums(is.na(data))<(nrow(data)*0.97)]
```

## Prepare data
#### Randomize the dataset

```r
data <- data[order(runif(nrow(data))),]
```
#### Create training & test part

```r
inTrain <- createDataPartition(data$classe, p = 0.7, list=F)
training <- data[inTrain,]
testing <- data[-inTrain,]
```

## Train a random forest model

```r
trainedModel <- train(classe ~ . , training, method="rf", trControl = trainControl(method = "cv", number = 2),do.trace=F,ntree=50)
```

```
## Loading required package: randomForest
## randomForest 4.6-7
## Type rfNews() to see new features/changes/bug fixes.
```
## Predict
#### Predict the test data using the created random-forest-model

```r
prediction <- predict(trainedModel, testing)
```

#### Print the results

```r
confusionMatrix(prediction, testing$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1674    3    0    0    0
##          B    0 1134    2    0    0
##          C    0    2 1024    5    0
##          D    0    0    0  958    0
##          E    0    0    0    1 1082
## 
## Overall Statistics
##                                         
##                Accuracy : 0.998         
##                  95% CI : (0.996, 0.999)
##     No Information Rate : 0.284         
##     P-Value [Acc > NIR] : <2e-16        
##                                         
##                   Kappa : 0.997         
##  Mcnemar's Test P-Value : NA            
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             1.000    0.996    0.998    0.994    1.000
## Specificity             0.999    1.000    0.999    1.000    1.000
## Pos Pred Value          0.998    0.998    0.993    1.000    0.999
## Neg Pred Value          1.000    0.999    1.000    0.999    1.000
## Prevalence              0.284    0.194    0.174    0.164    0.184
## Detection Rate          0.284    0.193    0.174    0.163    0.184
## Detection Prevalence    0.285    0.193    0.175    0.163    0.184
## Balanced Accuracy       1.000    0.998    0.998    0.997    1.000
```
The prediction accuracy is .998 on the 30% test-data which is awesome! 

#### Predict unseen testdata

```r
testdata <- read.csv('/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/test.csv', 
                             na.strings = c("NA", "#DIV/0!", ""))
prediction <- predict(trainedModel, testdata)
n <- length(prediction)
for(i in 1:n)
{
        filename <- paste0("/home/wijnand/R_workspace/8_Practical_Machine_Learning/course_project/resources/problem_id_",i,".txt")
        write.table(prediction[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
}
```
All 20 (unseen) cases were predicted correctly.
