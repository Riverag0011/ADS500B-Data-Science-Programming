#Gabi Rivera
#ADS500B
#06Aug2022

#Module 6 Assignment

#Question 2

#Set working directory
setwd('/Users/gabirivera/Desktop/MSADS1/ADS500B/Module6')

#Import table of women professional golfers' performance on the LPGA, 2008 tour 
lpga = read.table(file.choose(), header = TRUE, sep = ",")

#libraries
#library(stats)
#install.packages('skimr')
library(skimr)
#install.packages("cluster")
library(cluster)

#Pre-processing step for general dataset information
skim(lpga) #no missing data
rownames(lpga) = lpga$Golfer
gl = subset(lpga, select = 2:10)
head(gl, 3)

#Agglomerative clustering by average
agn_gl1 = agnes(gl, diss = FALSE, stand = TRUE, method = "average")
den_gl = as.dendrogram(agn_gl1)
plot(den_gl, main = "Agglomerative Clustering - Average")

#Agglomerative clustering by ward
agn_gl2 = agnes(gl, diss = FALSE, stand = TRUE, method = "ward")
den_gl = as.dendrogram(agn_gl2)
plot(den_gl, main = "Women LPGA, 2008 tour: Agglomerative Clustering - Ward")
par(cex=.5, font = 1)

#Compare agglomerative clustering - average and ward
agn_gl1 #agglomerative coefficient - average = 81.28%
agn_gl2 #agglomerative coefficient - ward = 93.40% (stronger clustering structure)
par(cex=.5, font = 1)


#Divisive clustering 
dna_gl = diana(gl, diss = FALSE, stand = TRUE)
dden_gl = as.dendrogram(dna_gl)
plot(dden_gl, main = "Women LPGA, 2008 tour: Divisive Clustering")
par(cex=.5, font = 1)

#Divisive coefficient = 87.80%
dna_gl 
