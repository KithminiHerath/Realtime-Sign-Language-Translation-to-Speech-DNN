import pandas as pd
import numpy as np
import math
import os
from tensorflow.python.util import deprecation
deprecation._PRINT_DEPRECATION_WARNINGS=False
import time
import tensorflow as tf
from gtts import gTTS


from pandas import read_csv
from numpy import dstack
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,LSTM,Dropout
from tensorflow.keras.layers import TimeDistributed,MaxPooling1D,Conv1D,Flatten,Dropout,ConvLSTM2D
import matplotlib.pyplot as plt



from tensorflow.keras.models import load_model

from tensorflow import keras
#from sklearn import preprocessing
#from sklearn.metrics import classification_report,confusion_matrix
#import matplotlib.pyplot as plt 
#import seaborn as sns            # visualization tool
#import matplotlib.cm as cm       # for colour mapping to use for the pca plots
from scipy.signal import hilbert, chirp
from scipy import signal
#from scipy.fftpack import fft

classes = ['YELLOW', 'WATER', 'YES', 'THANKYOU', 'NO']

### udith model start

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

def predict(ep,gp): #csv_files
    e = clean(ep)
    g = clean(gp)

    index = e[3:]


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
###udith model end

def clean(filename):
    main_signal=pd.read_csv(filename)
    print(filename)
    
    t= main_signal['timestamp']
    N=main_signal.shape[0]
    temp = np.array([])
    temp = np.hstack((temp, np.array(t)))
    cols = list(main_signal.columns)

    for column in cols[1:]: #miss the timestamp column
        print(column)
        signal_ =np.abs(main_signal[column])

        b, a = signal.butter(1,0.02, 'low', analog = False) 
        output = signal.filtfilt(b, a, signal_)

        analytic_signal = hilbert(output)
        amplitude_envelope = np.abs(analytic_signal)
        
        temp = np.vstack((temp, amplitude_envelope))
        '''
        fourier = np.fft.fft(output)

        s=0
        e=N
        

        plt.figure(figsize=(20,10))
        
        plt.plot(t[s:e], signal_[s:e], label='signal')
        plt.plot(t[s:e], output[s:e], label='signal')

        plt.plot(t[s:e], amplitude_envelope[s:e], label='envelope',color='black')
        plt.show()
        plt.plot(t[s:e], output[s:e], label='envelope',color='red')
       
        
        plt.plot(t[s:e], amplitude_envelope[s:e], label='envelope',color='black')
        plt.show()
        
        '''
        #plt.plot((xf*200)[10:N//2], (fourier.real**2 + fourier.imag**2)[10:N//2])
        
    result = pd.DataFrame(temp.transpose(),columns = cols)
    print('clean done!')
    return result

def process_one_df(df):
    data = df.drop('timestamp',axis = 1)
    if 'x' in list(data.columns):
        columns = list(data.columns)
    elif 'emg1' in list(data.columns):
        columns = ['emg1', 'emg2', 'emg4', 'emg6', 'emg7']

    #features = ['E','MAX','SSC','Sk','Ku','AR']

    vector = []
    
    for item in columns:
        temp = list(data[item])
        l = len(temp)
        
        # calculating mean
        mu = np.mean(np.array(temp))
        
        # calculating std
        dif = temp - mu
        s = np.sqrt(np.mean(np.array(dif)**2))
        
        # calculating E ***
        #out_columns.append(item+features[0])
        vector.append(np.mean(np.array(temp)**2))
        
        # calculating SSC ***
        #out_columns.append(item+features[2])
        tot = 0
        for i in range(1,l-1): 
            if (temp[i]-temp[i-1])*(temp[i+1]-temp[i]) < 0:
                tot += 1
        vector.append(tot/l-2)
        
        if 'x' in list(data.columns):
            # calculating max ***
            #out_columns.append(item+features[1])
            vector.append(max(temp))


        if 'emg1' in list(data.columns):
            # calculating Sk ***
            # out_columns.append(item+features[3])
            vector.append((np.sum(np.array(dif)**3) * l)/((l-1)*(l-2)*(s**3)))

            # calculate Ku ***
            #out_columns.append(item+features[4])
            Ku = (np.sum(np.array(dif)**4) * l * (l+1))/((l-1)*(l-2)*(l-3)*(s**4)) - (3*((l-1)**2))/((l-2)*(l-3))
            vector.append(Ku)
    print('features done!')
    return vector
def text_to_speech(text_):
    speech=gTTS(text=text_, lang='en',slow=False)
    speech.save("x.mp3")
    os.system("mpg321 x.mp3")


def infer(emg_file,gyro_file):
    cleaned_emg = clean(emg_file)
    cleaned_gyro = clean(gyro_file)

    #cleaned_emg = pd.read
    #cleaned_gyro = gyro_file

    # feature engineering
    output = []
    output += process_one_df(cleaned_emg)
    output += process_one_df(cleaned_gyro)
    processed = pd.DataFrame(output)

    # min-max scaler
    X_min = np.loadtxt('DNNX_min_new.txt', dtype=float)
    X_max = np.loadtxt('DNNX_max_new.txt', dtype=float)
    X = (processed.transpose()-X_min)/(X_max-X_min)


    start = time.time()
    # read trained model
    trained_model = keras.models.load_model('intelihack_both_new_model.h5')
    print('model loading done!')
    #infer model
    y_pred = trained_model.predict(X).tolist()[0]
    #y_pred = y_pred.index(max(y_pred))

    # classes = ['YELLOW', 'WATER', 'YES', 'THANKYOU', 'NO']

    print("all done!!")
    print(0)
    ans=y_pred.index(max(y_pred))


    #text_to_speech(classes[ans])

    print("Gesture is ",end="")
    print(classes[ans])

    end = time.time()
    print("###### Elapsed Time")
    print(end - start)
        
    return y_pred.index(max(y_pred))


dict={}

def pair_name(file):
    if(file[0:3]=='emg'):
        return 'gyro'+file[3:]
    else:
        return 'emg'+file[4:]



files= os.listdir('/home/ramith/Desktop/InnovateFPGA')
for file in files:
    if(file[-3:]=='csv'):
        os.remove(file)



while(1):
    files= os.listdir('/home/ramith/Desktop/InnovateFPGA')
    for file in files:


        if(file[-3:]=='csv' and file[0]=='e' and file not in dict and pair_name(file) in files):
            print("gesture detected!!")
            time.sleep(3.5)
            
            dict[file]=1
            dict[pair_name(file)]=1
            print(file,pair_name(file))


            
           

            print(infer(file,pair_name(file)))
            
            

            #(dict.keys())
