rm(list = ls())
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\")

#import files
data1 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data1.csv")
data2 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data2.csv")
data3 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data3.csv")
data4 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data4.csv")
data5 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data5.csv")
data6 = read.csv("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Weather_Data\\data6.csv")

#install packages or import libraries
library(lubridate)
library(plyr)

#Formatting
data1$ArrivalDate=mdy(data1$ArrivalDate)
data2$ArrivalDate=mdy(data2$ArrivalDate)
data3$ArrivalDate=mdy(data3$ArrivalDate)
data4$ArrivalDate=mdy(data4$ArrivalDate)
data5$ArrivalDate=mdy(data5$ArrivalDate)
data6$ArrivalDate=mdy(data6$ArrivalDate)

#Total weather Data
TotalWeather=rbind(data1,data2,data3,data4,data5,data6)



#Cleaning
TotalWeather_V1=TotalWeather[is.na(TotalWeather$T)==FALSE,]
TotalWeather_V1$T=as.double(TotalWeather_V1$T)
TotalWeather_V1$RA=as.character(TotalWeather_V1$RA)




#cleaning
for(i in 1:nrow(TotalWeather_V1))
{
  if (TotalWeather_V1$RA[i]=="o")
  {
    TotalWeather_V1$RA[i]=1
    
  } else{
    TotalWeather_V1$RA[i]=0
  }
}

#Formatting
TotalWeather_V1$RA=as.factor(TotalWeather_V1$RA)
#--------------------------------------------------------------
write.csv(TotalWeather_V1,file="I:\\Commodity_Price_Prediction\\Data_Preperation\\TotalWeather_V1.csv")

