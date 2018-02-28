#Library set
setwd("I:\\Project\\project\\War\\21_1")
rm(list = ls())
library(lubridate)

#Data Import
data=read.csv("ExtraAnalysis_v2.csv")
data1=read.csv("Data_Man.csv")

#Data Selection
data=data[,c(2,3,4,5)]
data$ArrivalDate=mdy(data$ArrivalDate)
data1$ArrivalDate=mdy(data1$ArrivalDate)


#All data
data3=merge(data1,data,by="ArrivalDate",all.x = TRUE)
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

data_wea=read.csv("TotalWeather_V1.csv")
data_wea=data_wea[,c(2:4)]
data_wea$ArrivalDate=mdy(data_wea$ArrivalDate)
aggregate_wea<-merge(data3, data_wea,by="ArrivalDate",all.x = TRUE)
aggregate_wea<- aggregate_wea[,c(1,2,5,6)]


#aggregate_wea=aggregate_wea[year(aggregate_wea$ArrivalDate)==2015,]
aggregate_final_Wo_date=aggregate_wea[,c(2,3,4)]
write.csv(aggregate_wea,"Continuous_Data_V2.csv")

aggregate_final_Wo_date$RA.y = factor(aggregate_final_Wo_date$RA.y,levels = c(0,1),labels = c(0,1))
regressor = lm(formula = Price ~ T.y,data = aggregate_final_Wo_date)
summary(regressor)
#write.csv(aggregate_final_Wo_date,"Continuous_Data_2011_v2.csv")
#print(regressor)
