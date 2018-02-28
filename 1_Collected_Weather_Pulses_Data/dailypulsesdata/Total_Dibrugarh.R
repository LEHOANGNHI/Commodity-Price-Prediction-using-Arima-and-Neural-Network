rm(list = ls())
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\dailypulsesdata\\")

data_2012 = read.csv("Pulsesdata2012.csv")
data_2013 = read.csv("Pulsesdata2013.csv")
data_2014 = read.csv("Pulsesdata2014.csv")
data_2015 = read.csv("Pulsesdata2015.csv")
data_2016 = read.csv("Pulsesdata2016.csv")
data_2017 = read.csv("Pulsesdata2017.csv")

data_2012$ArrivalDate=dmy(data_2012$ArrivalDate)
data_2013$ArrivalDate=dmy(data_2013$ArrivalDate)
data_2014$ArrivalDate=dmy(data_2014$ArrivalDate)
data_2015$ArrivalDate=dmy(data_2015$ArrivalDate)
data_2016$ArrivalDate=dmy(data_2016$ArrivalDate)
data_2017$ArrivalDate=dmy(data_2017$ArrivalDate)


data=rbind(data_2012,data_2013,data_2014,data_2015,data_2016,data_2017)
data=data[data$district_name=="Dibrugarh",]
data=data[data$comm_name=="Arhar (Tur/Red Gram)",]
data=data[,c(5,8,9)]
write.csv(data,"Assam_Dibrugarh_Tur.csv")
#summary(data)
#data