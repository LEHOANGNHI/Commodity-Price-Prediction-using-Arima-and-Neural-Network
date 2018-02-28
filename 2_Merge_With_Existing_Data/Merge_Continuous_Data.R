#Library set
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\2_Merge_With_Existing_Data\\")
rm(list = ls())
library(lubridate)

#Data Import
data=read.csv("ExtraAnalysis_v2.csv")
data1=read.csv("Data_Man.csv")

#Data Selection
data=data[,c(2,3,4,5)]
data$ArrivalDate=mdy(data$ArrivalDate)
data1$ArrivalDate=mdy(data1$ArrivalDate)


#Merge the discountninous merged data and empty continuous date
data3=merge(data1,data,by="ArrivalDate",all.x = TRUE)



#Replace NA of the data from average
x=0
y=0
first=0
second=0

for(i in c(1:1700))
{
  
  if (is.na(data3$Price[i])==TRUE && first==0)
  {
    x=data3$Price[i-1]
    first=i-1
  }
  if (is.na(data3$Price[i])==FALSE && (second==0 && first !=0))
  {
    y=data3$Price[i]
    second=i
  }
  if(first !=0 && second !=0)
  {
    for(lol in c((first+1):(second-1)))
    {
      data3$Price[lol]=(x+y)/2
    }
    first=0
    second=0
  }
}

#Import Weather data
data_wea=read.csv("TotalWeather_V1.csv")

#Select desired column
data_wea=data_wea[,c(2:4)]


#Date foratting
data_wea$ArrivalDate=mdy(data_wea$ArrivalDate)

#Merge the weather data with the continuous commodity price data and select the desired column
aggregate_wea<-merge(data3, data_wea,by="ArrivalDate",all.x = TRUE)
aggregate_wea<- aggregate_wea[,c(1,2,5,6)]


#Export the data
write.csv(aggregate_wea,"Continuous_Data_V2.csv")













