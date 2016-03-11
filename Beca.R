#Jesus Rincon
#20.142.782
#Insersion de librerias
library(NbClust)
library(cluster) 
library(fpc)
library(apcluster)
library(tree)
library(kknn)
library(party)
library(rattle)
library(arules)
library(RWeka)

fulldata <- read.csv("minable.csv", header = TRUE, sep = ",")
minado <- fulldata

wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}


str(minado$fNacimiento)
minado$fNacimiento = NULL
minado$aEconomica = NULL
minado$jReprobadas = NULL
minado$pReside = NULL
minado$dHabitacion = NULL
minado$cDireccion = NULL
minado$oSolicitudes = NULL
minado$grOdontologicos = NULL
minado$sugerencias = NULL
minado$beca = NULL 
minado <- scale(minado[-1])
set.seed(100)

train <- sample (1:nrow(minado), .8*nrow(minado)) # training row indices

standar <- minado[train, ] # training data

testData <- minado[-train, ] # test data

set.seed(123)

wssplot(standar)


fit.km <- kmeans(standar, 2, nstart=25) 

clusplot(standar, fit.km$cluster, color=TRUE, shade=TRUE, 
         labels=2, lines=0)
plotcluster(standar, fit.km$cluster)
standar <- as.data.frame(standar)
testData <- as.data.frame(testData)
kvec <- kknn(formula = mIngreso ~. , train=standar, test=testData,k=10)
prediction <- predict(kvec, standar$mIngreso)

mk <- table(testData$mIngreso, kvec$fitted.values)
mk

standar <- as.data.frame(standar)
testData <- as.data.frame(testData)
#tree <- ctree(standar$eficiencia ~ .,data = standar, method = 'class')
#tree <- ctree(mIngreso ~ .,data = standar)
tree = rpart(mIngreso ~ ., data = standar, method = "class", control = rpart.control(minsplit = 10, cp = 0.001, maxdepth = 3))
fancyRpartPlot(tree)

pred.response <- as.character (predict(tree), testData)
input.response <- as.character (testData$eficiencia)
mean (input.response != pred.response)

m = table(testData$mIngreso, predict(tree, newdata = testData,type = "class"))

m
standar$mIngreso <- as.factor(standar$mIngreso)
rule <- JRip(formula = mIngreso ~ ., data = standar)
m1 = table(testData$sexo, predict(rule, newdata = testData,type = "class"))

m1

