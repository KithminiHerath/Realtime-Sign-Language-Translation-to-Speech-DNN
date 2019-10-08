# Realtime-Sign-Language-Translation-to-Speech-DNN
This project is carried out for the InnovateFPGA 2019 competition as regional finalists in the AciaPacific region. A detailed discription of our project and demonstration video is available [here](http://www.innovatefpga.com/cgi-bin/innovate/teams.pl?Id=AP047).

Our project consists of three main sections and they are;
* Training a Deep Neural Network(DNN) to classify atleast 5 sign language gestures.
* Inferencing of the DNN and fusion of sensors using the DE10-Nano FPGA board
* Interfacing of external devices with the DE10-Nano FPGA board

Before training a DNN for sign language translation - for sign language gesture classification the process started by identifying a few features to train a Support Vector Classifier to do the classification using 
the American Sign Language(ASL) examples in this dataset available at the following [website](https://data.mendeley.com/datasets/wgswcr8z24/2). Due to the less amount of information on the data collection process of this dataset we created our own dataset for 5 ASL gestures, which consists of 25-28 exmples in one gesture. We passed all signals through a lowpass filter and applied the hilbert transform to get the envelope of each signal.

Feature engineering and training models were done using Python 3 in JupyterLab. We used correlation matrices and PCA plots to determine the final set of signals and features to be used in our final model. 
Our features include;
* For EMG signals - Energy, Slope Sign Change, Skewness, Kurtosis.
* For gyroscope signals - Energy, Slope Sign Change, Maximum Value.
Finally we created a neural network which utlizes these features for the classification process and our neural network was capable of producing a training accuracy of 98.84%, a validation accuracy of 95.45% and a test accuracy of 92.86%.

We are planning to use Intel openCL SDK for FPGA to implement the system in the FPGA board.
