library("lubridate") #To Convert into Date format (mm/dd/yy).
library("forecast")#used for time-series forecasting.
library("ggplot2")#for plotting graphs.
library("tseries")
cleaned = read.csv("Continuous_Data_V2.csv")#reading the C.S.V file. Please Set Working directory Before Importing dataset.
cleaned$ArrivalDate = mdy(cleaned$ArrivalDate)
str(cleaned)
plot(c)
table(year(cleaned$ArrivalDate))
cleandd <-cleaned[121:1581,]#we select data from year 2011 to 2014
table(year(cleandd$ArrivalDate))#to find out the no values in each year
price <- cleandd[3]#selecting only price column for the prdcition .
str(price)
plot(price,type = "l")
acf(price)#acf plot 
pacf(price)#pacf plot
logprice <- log(price)
matt <- ts(data = price,start = 1,end =1461)#to convert the data into time series format.
str(matt)
plot(matt)
adf.test(matt,alternative = "stationary")
arima(matt,order = c(0,1,0))
auto.arima(matt)#using auto.arima to find the best model.
ARIMAMODEL <- arima(matt, order = c(0,1,0))#fitting the model.
p <- forecast(ARIMAMODEL,h = 15)# forecasting
predicted <- as.data.frame(p)
predicted
orignal <- cleaned[1582:1596,3]
orignal
plot(predicted,type = 'l')
plot(orignal,type = 'l')
listss <- data.frame(predicted,orignal)
listss 
accuracy(p,orignal)
write.csv(listss,file ="C://Users//HP//Desktop//Prediced.csv")