#Set working directory and import library
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\3_Statistical_Inference\\Continuous\\")
rm(list = ls())
library(lubridate)

#Import the continuous data
data=read.csv("Continuous_Data_V2.csv")

#Format Rain into factor and date variable
data$Rain = factor(data$Rain,levels = c(0,1),labels = c(0,1))

#Select the necessary column
data$ArrivalDate=mdy(data$ArrivalDate)
data=data[,c(3,4,5)]

#Check model1

#Null hypothesis is that all the variable is independent from each other which means 
#Temperature and Rain doesn’t make any impact on Price
regressor = lm(formula = Price ~ Temperature + Rain,data = data)
summary(regressor)



#Eliminated Rain Varialbe and check again
regressor2 = lm(formula = Price ~ Temperature,data = data)
summary(regressor2)



