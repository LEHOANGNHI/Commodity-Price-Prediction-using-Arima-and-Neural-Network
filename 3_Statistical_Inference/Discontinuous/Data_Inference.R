#Library set
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\3_Statistical_Inference\\Discontinuous\\")
rm(list = ls())
library(lubridate)

data=read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\3_Statistical_Inference\\Discontinuous\\Input\\ExtraAnalysis_v2.csv")
data$RA = factor(data$RA,levels = c(0,1),labels = c(0,1))
data$ArrivalDate=mdy(data$ArrivalDate)
data=data[,c(3,4,5)]

regressor = lm(formula = Price ~ T + RA,data = data)
summary(regressor)

regressor2 = lm(formula = Price ~ T,data = data)
summary(regressor2)

