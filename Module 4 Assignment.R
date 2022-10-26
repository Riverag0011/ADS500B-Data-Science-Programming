#Packages
library(tidyverse)
library(ggplot2)
library(dslabs)
library(dplyr)
library(Hmisc)
library(corrplot)
library(GGally)
library(scatterplot3d)
library(ggpubr)
library(cluster)
library(factoextra)
library(ggfortify)
library(stats)
library(ClusterR)
library(cluster)
library(datasets)

#-------------------
#set working directory at a mac system
setwd("/Users/gabirivera/Desktop/MSADS1/ADS500B/Module4")

#import tsv into R
custdata <- read.table(file.choose(), header = TRUE, sep = "\t")

#take a peak of the data
head(custdata, 10)

#Histogram 
hist(custdata$income, xlab = 'Income', freq = FALSE, main = 'Histogram of Customer Income')

#-------------------

#Subset data
ht = subset(custdata, select = "housing.type")

#omit Null/NA data
hto = na.omit(ht)

#sort 
hto <- within(hto,housing.type <- factor(housing.type,levels = names (sort(table(housing.type),decreasing = FALSE))))

#Bar chart
ggplot(hto, aes(housing.type)) + geom_bar() + labs(title = "Customer Housing Type", x = "Housing Type")

#-----------------------

#subset with two columns and condition 
i = subset(custdata, income > 50000, select = c("income", "marital.stat"))
m = subset(i, marital.stat == 'Married', select = c("income", "marital.stat"))

#percentage of married customers earning greater than 50k USD that have health insurance
hi = length(mi$health.ins)
htrue = sum(mi$health.ins, na.rm = TRUE)
imh = htrue/hi *100
round(imh, digits = 2)

#percentage of customer with health insurance in whole dataset:
Whi = length(custdata$health.ins)
Whtrue = sum(custdata$health.ins, na.rm = TRUE)
Wimh = Whtrue/Whi *100
round(Wimh, digits = 2)

#Percent diff between imh and Wimh
pdiff = ((imh-Wimh)/((imh+Wimh)/2))*100
round(pdiff, digits = 2)


#---------------------

#Correlation matrix of income, number of vehicles, and age
summary(custdata)
onum = subset(custdata, select = c("income", "num.vehicles", "age"))
cc = cor(onum, y = NULL, use = "complete.obs", method = "pearson")
corrplot(cc, type = "full", order = "hclust", tl.col = "Black", tl.srt = 45)


#----------------------

#Correlation on dating.csv
dating <- read.csv(file.choose(), header = TRUE, sep = ",")
summary(dating)
d = subset(dating, select = c("Miles", "Games", "Icecream"))
dd = cor(d, y = NULL, use = "complete.obs", method = "pearson")
round(dd, digits = 4)
corrplot(dd, method = "color", title = "Correlation Matrix of Dataing", type = "full", order = "hclust", tl.col = "Black", tl.srt = 45)

ggpairs(dating)

#Linear regression
sp = subset(dating, select = c("Miles", "Games"))
summary(sp)
boxplot(sp)
mg = lm(formula = Miles ~ Games, data = sp)
summary(mg)
scatter.smooth(sp, family = "gaussian")

#scatter in 3 variables
t = subset(dating, select = c("Miles", "Games", "Like"))
ggplot(t, aes(Miles, Games, colour = Like)) + geom_point() + labs(title = "Dating Variables")

#kmean clustering
set.seed(20)
spC = kmeans(sp, 3, nstart = 20)
table(spC$cluster, t$Like)
ggplot(t, aes(Miles, Games, color = spC$cluster))+ geom_point() +labs(title = "Dating Variables Using Predicted Cluster")

