setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\2_Merge_With_Existing_Data\\Discontinuous\\")
rm(list = ls())

library(lubridate)
weather_data=read.csv("TotalWeather_V1.csv")