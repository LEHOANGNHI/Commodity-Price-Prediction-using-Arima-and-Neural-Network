setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\4_Stationarize_Series\\")
rm(list = ls())
library(lubridate)
dataset = read.csv('Continuous_Data_V2.csv')
dataset=dataset[,c(2,3,4,5)]
dataset$ArrivalDate=mdy(dataset$ArrivalDate)
dataset$Rain = factor(dataset$Rain,levels = c(0,1),labels = c(0,1))


dataset_2015=dataset[year(dataset$ArrivalDate) == 2015,]

dataset=dataset[year(dataset$ArrivalDate) >= 2011,]
dataset=dataset[year(dataset$ArrivalDate) < 2015,]

aggdata <-aggregate(dataset[,c(2,3)], by=list(month(dataset$ArrivalDate),year(dataset$ArrivalDate)),FUN=mean, na.rm=TRUE)


my_matrix=matrix(nrow = 4,ncol = 12)
rownames(my_matrix)<-c(2011,2012,2013,2014)
colnames(my_matrix)<-c(1,2,3,4,5,6,7,8,9,10,11,12)

count=1
for(i in c(2011,2012,2013,2014))
{
  for(j in c(1,2,3,4,5,6,7,8,9,10,11,12))
  {
    i=as.character(i)
    k=as.character(j)
    my_matrix[i,k]=aggdata$Price[count]
    count=count+1
  }
}
my_matrix_t=t(my_matrix)
my_vector_ts=as.vector(as.matrix(my_matrix_t))
library(tseries)
my_ts<- ts(my_vector_ts, start=c(2011,1), end=c(2014,12), frequency=12)

my_ts_auto <- auto.arima(my_ts)

accuracy(my_ts_auto)
#plot(forecast(my_ts_auto,1))
#print(forecast(my_ts_auto,2))
hell<-forecast(my_ts_auto,4)
hella<-hell
hell<-hell$upper

hello=cbind(hella$lower,hell)



aggdata_2015 <-aggregate(dataset_2015[,c(2)], by=list(month(dataset_2015$ArrivalDate),year(dataset_2015$ArrivalDate)),FUN=mean, na.rm=TRUE)
aggdara_2015_pred=cbind(hello,aggdata_2015[,3])



# 
# # Step 1: Visualize the Time Series
# plot(my_ts,xlab="Time Period",ylab="Price")
# 
# # Step 2: Stationarize the Series
# adf.test(my_ts) # augmented Dickey Fuller Test
# 
# #Extract Seasonal & Trend: using decomposition in R
# #detect the trend
# library(forecast)
# trend_price = ma(my_ts, order = 12, centre = T)
# plot(as.ts(my_ts))
# lines(trend_price)
# plot(as.ts(trend_price))
# 
# #detrend the time series
# detrend_price = my_ts / trend_price
# plot(as.ts(detrend_price))
# 
# #average seasonality
# m_price = t(matrix(data = detrend_price, nrow = 12))
# seasonal_price = colMeans(m_price, na.rm = T)
# plot(as.ts(rep(seasonal_price,12)))
# 
# #random noise left
# random_price = my_ts / (trend_price * seasonal_price)
# plot(as.ts(random_price))
# 
# install.packages('astsa')
# library(astsa)
# acf2(my_ts)
# adf.test(diff(diff(my_ts)))
# acf2(diff(diff(my_ts)))
# sarima(diff(diff(my_ts)),0,2,0)
# 
# sarima.for(diff(my_ts),12,0,1,1)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# #plot(decompose(my_ts,"additive"))
# 
