#Remove current working enviroment
rm(list = ls())

#set working directory
setwd("I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\dailypulsesdata\\")

#collect data from different files
data_2012 = read.csv("Pulsesdata2012.csv")
data_2013 = read.csv("Pulsesdata2013.csv")
data_2014 = read.csv("Pulsesdata2014.csv")
data_2015 = read.csv("Pulsesdata2015.csv")
data_2016 = read.csv("Pulsesdata2016.csv")
data_2017 = read.csv("Pulsesdata2017.csv")


#install.packages("lubridate")
library(lubridate)

#Date formatting
data_2012$ArrivalDate=dmy(data_2012$ArrivalDate)
data_2013$ArrivalDate=dmy(data_2013$ArrivalDate)
data_2014$ArrivalDate=dmy(data_2014$ArrivalDate)
data_2015$ArrivalDate=dmy(data_2015$ArrivalDate)
data_2016$ArrivalDate=dmy(data_2016$ArrivalDate)
data_2017$ArrivalDate=dmy(data_2017$ArrivalDate)


#Collect the data into single variable
data=rbind(data_2012,data_2013,data_2014,data_2015,data_2016,data_2017)

#Filter it by particular district
data=data[data$district_name=="Dibrugarh",]

#Filter it by particular commodity
data=data[data$comm_name=="Arhar (Tur/Red Gram)",]


#Select particular column
data=data[,c(5,8,9)]


#Export the output
write.csv(data,"I:\\Commodity_Price_Prediction\\Data_Preperation\\1_Collected_Weather_Pulses_Data\\Assam_Dibrugarh_Tur.csv")








