from pandas import read_csv
from numpy import dstack
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,LSTM,Dropout
from tensorflow.keras.layers import TimeDistributed,MaxPooling1D,Conv1D,Flatten,Dropout,ConvLSTM2D
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
import pandas as pd
from tensorflow.keras.models import load_model
from scipy.ndimage.interpolation import map_coordinates


def interpolating(data,n_rows): #output of read_csv
    #new_data is a dataframe
    n_columns=len(list(data))
    A = np.array(data) 
    new_dims = [] 
    for original_length, new_length in zip(A.shape, (n_rows,n_columns)): 
        new_dims.append(np.linspace(0, original_length-1, new_length)) 
    coords = np.meshgrid(*new_dims, indexing='ij') 
    B = map_coordinates(A, coords)
    data=pd.DataFrame(B)
    return data

n_steps, n_length = 4, 25 # n_timesteps = n_steps * n_length (n_timesteps =100)
n_features=17
model_dir='conv_lstm_full.h5'
dict_labels={0:'NO',1:'THANKYOU',2:'WATER',3:'YELLOW',4:'YES'}

def csv_read(csv_dir):
    f = open(csv_dir,'rb')
    if b',' in f.readline():
        data = pd.read_csv(csv_dir)
    else:
        data = pd.read_csv(csv_dir,encoding = 'utf-16',delimiter = '\t')
    data = data.drop('Timestamp',axis = 1)
    data=interpolating(data,100)
    return data

def predict(ap,ep,op,gp): #csv_files
    model=load_model(model_dir)
    a=csv_read(ap)
    e=csv_read(ep)
    o=csv_read(op)
    g=csv_read(gp)       
    sample_df=pd.concat([a,e,o,g],axis=1)
    predictX=np.array(sample_df)
    #print(predictX.shape)
    #predictX.expand_dims(predictX, axis=0)
    predictX=predictX.reshape((1, n_steps, n_length, n_features))
    output=model.predict(predictX)
    ges_num=np.argmax(model.predict(predictX))
    return dict_labels[ges_num]    


ap='accelerometer-1569406602_2.csv'
ep='emg-1569406602_2.csv'
gp='gyro-1569406602_2.csv'
op='orientationEuler-1569406602_2.csv'

print(predict(ap,ep,op,gp))