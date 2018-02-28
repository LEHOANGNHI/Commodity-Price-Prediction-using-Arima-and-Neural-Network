# -*- coding: utf-8 -*-
"""
Created on Sat Jan 27 17:11:22 2018

@author: Mukesh
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

training_set = pd.read_csv("Continuous_Data_weekly.csv")
training_set1 = training_set.iloc[:,2:3].values

from sklearn.preprocessing import MinMaxScaler
sc = MinMaxScaler()

training_set2 = sc.fit_transform(training_set1)

x_train = training_set2[0:236]
y_train = training_set2[1:237]

#Reshaping 
x_train = np.reshape(x_train, (237,1,1))
 
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM

regressor = Sequential()

regressor.add(LSTM(units=20,activation = 'sigmoid', input_shape=(None,1)))

regressor.add(Dense(units=1))

regressor.compile(optimizer='adam', loss='mean_squared_error')

regressor.fit(x_train,y_train,batch_size=32,epochs=220)

test_set = pd.read_csv("newtest.csv")
real_price = test_set.iloc[:,2:3].values

inputs = real_price
inputs = sc.transform(inputs)
 
new_train = np.reshape(inputs, (10, 1, 1))

pred_price = regressor.predict(new_train)
pred_price1 = sc.inverse_transform(pred_price)

type(real_price)
type(pred_price1)

real_price1 = pd.DataFrame(real_price)
pred_price2 = pd.DataFrame(pred_price1)

#df_out = pd.DataFrame([real_price])

#date = test_set[1]

new_combined = pd.concat([real_price1[0],pred_price2[0]],axis = 1,keys = ['Date','real_price', 'pred_price1'])

new_combined2 = pd.concat([test_set[1],new_combined],axis = 1,keys = ['Date','real_price', 'pred_price1'])

new_combined2.to_csv("Output3.csv", encoding='utf-8', index=False)

