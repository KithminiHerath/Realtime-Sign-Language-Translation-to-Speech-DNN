import pandas as pd
import numpy as np
import math
import os
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import cross_val_predict
from sklearn.decomposition import PCA                 # for dimensionality reduction using PCA
from sklearn.model_selection import GridSearchCV
from sklearn.svm import SVC
from sklearn.metrics import classification_report,confusion_matrix
import matplotlib.pyplot as plt 
import seaborn as sns            # visualization tool
import matplotlib.cm as cm       # for colour mapping to use for the pca plots
from scipy.signal import hilbert, chirp
from scipy import signal
from scipy.fftpack import fft

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

        fourier = np.fft.fft(output)

        s=0
        e=N
        

        plt.figure(figsize=(20,10))
        '''
        plt.plot(t[s:e], signal_[s:e], label='signal')
        plt.plot(t[s:e], output[s:e], label='signal')

        plt.plot(t[s:e], amplitude_envelope[s:e], label='envelope',color='black')
        plt.show()
        plt.plot(t[s:e], output[s:e], label='envelope',color='red')
        '''
        
        plt.plot(t[s:e], amplitude_envelope[s:e], label='envelope',color='black')
        plt.show()

        xf =np.fft.fftfreq(N)  

        #plt.plot((xf*200)[10:N//2], (fourier.real**2 + fourier.imag**2)[10:N//2])
        
    result = pd.DataFrame(temp.transpose(),columns = cols)
    result.to_csv(r'out.csv',index = False)


clean('/home/ramith/Desktop/InnovateFPGA/emg1570379898140851.csv')