#Install connection program
install.packages("RMySQL")

#Libraries
library(RMySQL)
library(ggplot2)

#Connect r to mysql database
auto_con = dbConnect(MySQL(),
                     dbname = "auto",
                     host = "localhost",
                     user = "root",
                     password = passwd)

#retrieve mpg table
auto_q = dbSendQuery(auto_con, "SELECT * FROM mpg")
auto = fetch(auto_q)

#Dataset summary
summary(auto)

#create a subset only for numeric
auto_sub = subset(auto, select = c("mpg", "cylinders", "displacement", "horsepower", "weight"))

#Correlation of weight and horsepower
round(cor(auto_sub, use = "complete.obs", method = "pearson"), digits = 4)

#Plot of weight vs horsepower colored with mpg
ggplot(auto, aes(weight, horsepower, colour = mpg)) + geom_point() + labs(title = "weight vs horsepower")

#Plot of weights vs horsepower colored using prediction
wh = subset(auto, select = c("weight", "horsepower"))
whC = kmeans(wh,4,nstart = 20)
ggplot(auto, aes(weight, horsepower, color = whC$cluster))+geom_point()+labs(title = "weight vs horsepower")



