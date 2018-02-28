library("lubridate") #To Convert into Date format (mm/dd/yy).
library("forecast")#used for time-series forecasting.
library("ggplot2")#for plotting graphs.
monthly = read.csv("Continuous_Data_Monthly.csv")#reading the C.S.V file.Please Set working Directory before Importting dataset.
weekly = read.csv("Continuous_Data_weekly.csv")
weekly
monthly
weekly$ArrivalDate = mdy(weekly$ArrivalDate)
monthly$ArrivalDate = mdy(monthly$ArrivalDate)
table(year(monthly$ArrivalDate))
table(year(weekly$ArrivalDate))
weeklyy <- weekly[19:230,]
table(year(weeklyy$ArrivalDate))
monthlyp <- monthly[5:52,]
monthlyprice <- monthlyp$Price
weeklyprice <- weeklyy[,3]
weeklyprice
plot(weeklyprice,type = "l")
TSweekly <- ts(data = weeklyprice,start = 1,end = 212)
adf.test(TSweekly)
auto.arima(TSweekly)
str(monthlyprice)
plot(monthlyprice,type = "l")
acf(monthlyprice)
pacf(monthlyprice)
TSmonthly <- ts(data = monthlyprice,start = 1,end = 48)
auto.arima(TSmonthly)
acf(TSweekly)
pacf(TSweekly)
WEEKLYMODEL <- arima(TSweekly,order = c(5,1,1))
Wpredicted <- forecast(WEEKLYMODEL,h = 1)
Weekly_orignal <- weekly[231,3]
MONTHLYMODEL <- arima(TSmonthly,order = c(0,1,0))
Mpredicted <- forecast(MONTHLYMODEL,h=1)
Mpredicted
Monthly_orignal <- monthly[53,3]
accuracy(Mpredicted,Monthly_orignal)
accuracy(Wpredicted,Weekly_orignal)
Mpredicted <- as.data.frame(Mpredicted)
M <- cbind(Mpredicted,Monthly_orignal)
Wpredicted <- as.data.frame(Wpredicted)
W <- cbind(Wpredicted,Weekly_orignal)