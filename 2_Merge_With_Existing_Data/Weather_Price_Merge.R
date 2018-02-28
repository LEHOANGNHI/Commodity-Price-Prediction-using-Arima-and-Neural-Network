#Remove current working enviroment
rm(list = ls())

#set working directory
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\2_Merge_With_Existing_Data\\")

#import important packages
library(lubridate)
library(plyr)

#collect data from different files
weather_data=read.csv("TotalWeather_V1.csv")
commodity_data=read.csv("Assam_Dibrugarh_Tur.csv")


#Select desired columns
weather_data=weather_data[,c(2,3,4)]
commodity_data=commodity_data[,c(2,3,4)]

#Date formatting
weather_data$ArrivalDate=ymd(weather_data$ArrivalDate)
commodity_data$ArrivalDate=ymd(commodity_data$ArrivalDate)


#Change the format of RA column as factor
weather_data$RA=as.factor(weather_data$RA)

#Merge the commodity data with the weather data
weather_commodity_data=join(commodity_data,weather_data,type = "left",by= "ArrivalDate")


#Export the output
write.csv(weather_commodity_data,"weather_commodity_data.csv")













