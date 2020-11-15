#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Nov 15 11:49:27 2020

@author: theone
"""
import datetime
import pandas as pd
from pandas_datareader import data
import numpy as np
from datetime import timedelta
#pip install pandas-datareader

hoje = datetime.datetime.today()
#hoje=now.strftime("%Y,%m,%d")
inicio=(datetime.datetime.today() - timedelta(days=200))#.strftime("%Y,%m,%d")
      
def predict(acao):

    try:
        stock = '{}.SA'.format(acao)
        source = 'yahoo'
        
        # Set date range (Google went public August 19, 2004)
        start =inicio
        end = hoje
        
        # Collect Google stock data
        goog_df = data.DataReader(stock, source, start, end)
        
        dataset = goog_df['Adj Close']
        print(len(dataset))
        goog_df['Adj Close'].plot(kind='line', grid=True, title='{} Adjusted Closes, IPO through 2016'.format(stock))
        
        ## FIBO DINAMICO
        max_periodo=np.max(dataset[-144:])
        min_periodo=np.min(dataset[-144:])
        
        diff=max_periodo-min_periodo
        
        primeiro_fibo=min_periodo+0.328*diff
        segundo_fibo=min_periodo+0.618*diff
        
        
        media_verde=np.mean(dataset[-8:])
        media_vermelha=np.mean(dataset[-12:])
        
        tendencia=media_verde-media_vermelha
        print(tendencia)
        print(acao)
        fibo_superior=dataset[-1]-segundo_fibo
        
        
        fibo_inferior=dataset[-1]-primeiro_fibo
        
        if tendencia>0 and fibo_superior>0 and fibo_superior<0.04*dataset[-1]:
            output='buy'
            print('buy')
        elif tendencia<0 and fibo_inferior<0 and fibo_inferior<-0.04*dataset[-1]:
            output='short'
            print('short')
        else:
            output='wait'
            print('wait')
    except Exception as e:
        print(e)
        output='NA'
    return output

df=pd.read_csv('Lista_Acoes.csv',sep=';',header=0)
df.columns=['Sigla','Previsao']

for i in range(0,df.shape[0]):
    df['Previsao'].iloc[i]=predict(df.iloc[i,0])


df.to_csv('recomendacoes_{}.csv'.format(hoje),sep=',',columns=df.columns,index=False)
