#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 16 20:05:37 2020

@author: theone
"""

import pandas as pd
from pandas_datareader import data
import numpy as np
import datetime
from datetime import timedelta
#pip install pandas-datareader
import time
start=time.time()
hoje =  (datetime.datetime.today() - timedelta(days=2))

inicio=(datetime.datetime.today() - timedelta(days=200))
data1=str(hoje.year)+'-'+str(hoje.month)+'-'+str(hoje.day)

stock = 'TEND3.SA'
source = 'yahoo'

start =inicio
end = hoje

goog_df = data.DataReader(stock, source, start, end)

dataset = goog_df

ST=(((np.mean(dataset.Open)-np.mean(dataset.Low))/dataset.Open[-1])*dataset.Open[-1])
DT=(((np.mean(dataset.Open)-np.mean(dataset.Low))/dataset.Open[-1])*dataset.Open[-1])/2
