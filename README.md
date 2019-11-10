# Realtime-Sign-Language-Translation-to-Speech-DNN

## FPGA Implementation Background

[InnovateFPGA Project Page](http://www.innovatefpga.com/cgi-bin/innovate/teams.pl?Id=AP047)

## Machine Learning Background 

The Machine Learning aspect of this project is carried out for the **Intellihack 2019 competition by team fastermosquitonet150**. Our motive of the project is to create a device that helps the people with speech and hearing disorders. We used Myo armband, a device which measures the electrical activity from human muscles. Thus detects the gestures shown.

Our project consists of two main sections and they are;.
* Pre processing of the raw EMG, Gyroscope and Accelerometer signals using Digital Signal Processing techniques
* Training a Deep Neural Network(DNN) to classify 5 sign language gestures.

A raw data of myo armband signals is required to cary out the project and we came over a public dataset for identifying American Sign Language(ASL)  Classification in the following [website](https://data.mendeley.com/datasets/wgswcr8z24/2). Unfortunately the unavailabity of data collection process of this dataset, we generated our own dataset of myo armband signals for 5 ASL gestures. 

The preprocessing technique goes on cleaning the raw data in order to feed a crystal clear form of gestures to the neural network to be trained. Digital Signal Processing techniques such as low-pass filtering followed by hilbert transform are used to carry out the work.

Feature engineering and training models were done using Python 3 in JupyterLab. We used correlation matrices and PCA plots to determine the final set of signals and features to be used in our final model. 
Our features include;
* For EMG signals - Energy, Slope Sign Change, Skewness, Kurtosis
* For gyroscope signals - Energy, Slope Sign Change, Maximum Value

Finally we created a neural network which utlizes these features for the classification process and our neural network was capable of producing a training accuracy of 98.84%, a validation accuracy of 95.45% and a test accuracy of 92.86%.

[![Project demonstration video](https://github.com/KithminiHerath/Realtime-Sign-Language-Translation-to-Speech-DNN/blob/master/meta/youtube.png?raw=true)](https://youtu.be/jygNk3SqnJ8)

