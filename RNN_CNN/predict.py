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
model_dir=''
inv_label_dic= #insert this

def predict(predictX):
    model=load_model(model_dir)
    predictX=interpolating(predictX,100) #n_rows=100 
    predictX=predictX.reshape((predictX.shape[0], n_steps, n_length, n_features))
    output=model.predict(evaluateX)
    ges_num=np.argmax(model.predict(predictX))
    return inv_label_dict[ges_num]
